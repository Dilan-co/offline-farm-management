import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment_model.dart';
import 'package:farm_management/services/multipart_form_request.dart';

class ProductBatchLabelAssessmentDataService {
  final StateController stateController = Get.find();

  String get formDataUrl =>
      '${stateController.baseUrl}/sf-production-batch-label-assessment';
  String get documentUrl => '${stateController.baseUrl}/document/upload';

  Future<bool> postData() async {
    String bearerToken = stateController.getAccessToken();
    List<ProductionBatchLabelAssessmentModel> recordList =
        await ProductionBatchLabelAssessment().fetchNotSyncedRecords();

    //Delete "delete_date" Expired Records
    ProductionBatchLabelAssessment().deleteExpiredRecords();

    if (recordList.isNotEmpty) {
      for (var record in recordList) {
        Map<String, String?> json = record.toJson();
        try {
          // Sending the POST request
          final response = await http.post(
            Uri.parse(formDataUrl),
            headers: {
              'Authorization': 'Bearer $bearerToken',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(json),
          );
          // Handling the response
          if (response.statusCode == 201 || response.statusCode == 200) {
            // Request was successful
            debugPrint('Response: ${response.body}');
            Map<String, dynamic> responseDecoded = jsonDecode(response.body);

            //Sending Label Sample 1
            bool file1 = await sendMultipartFormRequest(
              url: documentUrl,
              token: bearerToken,
              recordId: responseDecoded["production_batch_label_assessment_id"].toString(),
              modelName: 'SFProductionBatchLabelAssessment',
              fieldName: 'label_sample_01',
              fileType: 'file',
              fileName: record.labelSampleOne,
            );
            if (!file1) return false;

            //Sending Label Sample 2
            bool file2 = await sendMultipartFormRequest(
              url: documentUrl,
              token: bearerToken,
              recordId: responseDecoded["production_batch_label_assessment_id"].toString(),
              modelName: 'SFProductionBatchLabelAssessment',
              fieldName: 'label_sample_02',
              fileType: 'file',
              fileName: record.labelSampleTwo,
            );
            if (!file2) return false;

            //Sending Signature
            bool sig = await sendMultipartFormRequest(
              url: documentUrl,
              token: bearerToken,
              recordId: responseDecoded["production_batch_label_assessment_id"].toString(),
              modelName: 'SFProductionBatchLabelAssessment',
              fieldName: 'signature',
              fileType: 'signature',
              fileName: record.signature,
            );
            if (!sig) return false;

            // Mark is_synced 1 and add delete date
            addSyncAndExpireDate(record: record);
          } else {
            debugPrint(
                'POST SIMPLE_FORM_production_batch_label_assessment Data Sync Failed: ${response.statusCode} - ${response.body}');
            return false;
          }
        } catch (e) {
          debugPrint(
              'POST SIMPLE_FORM_production_batch_label_assessment Error: $e');
          return false;
        }
      }
      // If all records are successfully processed
      return true;
    } else {
      return true;
    }
  }

  addSyncAndExpireDate(
      {required ProductionBatchLabelAssessmentModel record}) async {
    // Calculate ExpireDate
    DateTime today = DateTime.now();
    DateTime expireDate = today.add(Duration(days: 7));
    // Format the date as YYYY-MM-DD
    String formattedExpireDate = expireDate.toString().split(' ')[0];
    debugPrint(formattedExpireDate);
    //Add
    record.isSynced = 1;
    record.deleteDate = formattedExpireDate;
    //Update Record
    int recId =
        await ProductionBatchLabelAssessment().updateRecord(model: record);

    debugPrint("$recId");
  }
}
