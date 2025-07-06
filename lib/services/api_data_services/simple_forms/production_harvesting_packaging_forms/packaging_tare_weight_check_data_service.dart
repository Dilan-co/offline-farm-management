import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check_model.dart';
import 'package:farm_management/services/multipart_form_request.dart';

class PackagingTareWeightCheckDataService {
  final StateController stateController = Get.find();

  String get formDataUrl =>
      '${stateController.baseUrl}/sf-packaging-tare-weight-check';
  String get documentUrl => '${stateController.baseUrl}/document/upload';

  Future<bool> postData() async {
    String bearerToken = stateController.getAccessToken();
    List<PackagingTareWeightCheckModel> recordList =
        await PackagingTareWeightCheck().fetchNotSyncedRecords();

    //Delete "delete_date" Expired Records
    PackagingTareWeightCheck().deleteExpiredRecords();

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

            //Sending Signature
            bool sig = await sendMultipartFormRequest(
              url: documentUrl,
              token: bearerToken,
              recordId: responseDecoded["packaging_tare_weight_check_id"].toString(),
              modelName: 'SFPackagingTareWeightCheck',
              fieldName: 'signature',
              fileType: 'signature',
              fileName: record.signature,
            );
            if (!sig) return false;

            // Mark is_synced 1 and add delete date
            addSyncAndExpireDate(record: record);
          } else {
            debugPrint(
                'POST SIMPLE_FORM_packaging_tare_weight_check Data Sync Failed: ${response.statusCode} - ${response.body}');
            return false;
          }
        } catch (e) {
          debugPrint('POST SIMPLE_FORM_packaging_tare_weight_check Error: $e');
          return false;
        }
      }
      // If all records are successfully processed
      return true;
    } else {
      return true;
    }
  }

  addSyncAndExpireDate({required PackagingTareWeightCheckModel record}) async {
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
    int recId = await PackagingTareWeightCheck().updateRecord(model: record);

    debugPrint("$recId");
  }
}
