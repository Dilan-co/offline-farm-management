import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/org/org_equipment.dart';
import 'package:farm_management/models/table_models/org/org_equipment_model.dart';
import 'package:farm_management/services/multipart_form_request.dart';

class OrgEquipmentDataService {
  final StateController stateController = Get.find();

  String get formDataUrl => '${stateController.baseUrl}/sf-equipment';
  String get documentUrl => '${stateController.baseUrl}/document/upload';

  Future<bool> getData() async {
    // postData is called first to sync any unsynced records
    bool postResult = false;
    do {
      postResult = await _postData();
    } while (!postResult);

    try {
      final response = await http.get(
        Uri.parse(formDataUrl),
        headers: {
          'Authorization': 'Bearer ${stateController.getAccessToken()}',
        },
      );
      debugPrint(
          "Response status code from getData request -->> ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseDecoded = await json.decode(response.body);
        debugPrint("Response from getData Decoded -->> $responseDecoded");
        List<OrgEquipmentModel> dataList = List<OrgEquipmentModel>.from(
            responseDecoded.map((data) => OrgEquipmentModel.fromJson(data)));
        // Attempt batch insert/update
        try {
          if (dataList.isNotEmpty) {
            await OrgEquipment().createRecordsBatch(models: dataList);
          }
        } catch (e) {
          debugPrint("Error during batch insert: $e");
          return false;
        }
        return true;
      } else {
        debugPrint("GET ORG_equipment Data Sync Failed");
        return false;
      }
    } catch (e) {
      debugPrint("GET ORG_equipment Error : $e");
      return false;
    }
  }

  Future<bool> _postData() async {
    String bearerToken = stateController.getAccessToken();
    List<OrgEquipmentModel> recordList =
        await OrgEquipment().fetchNotSyncedRecords();

    //Delete "delete_date" Expired Records
    // OrgEquipment().deleteExpiredRecords();

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

            //Sending Media
            bool file1 = await sendMultipartFormRequest(
              url: documentUrl,
              token: bearerToken,
              recordId: responseDecoded["equipment_id"].toString(),
              modelName: 'Equipment',
              fieldName: 'media',
              fileType: 'file',
              fileName: record.media,
            );
            if (!file1) return false;

            //Sending Signature
            bool sig = await sendMultipartFormRequest(
              url: documentUrl,
              token: bearerToken,
              recordId: responseDecoded["equipment_id"].toString(),
              modelName: 'Equipment',
              fieldName: 'signature',
              fileType: 'signature',
              fileName: record.signature,
            );
            if (!sig) return false;

            // Mark is_synced 1
            updateSync(record: record);
          } else {
            debugPrint(
                'POST ORG_equipment Data Sync Failed: ${response.statusCode} - ${response.body}');
            return false;
          }
        } catch (e) {
          debugPrint('POST ORG_equipment Error: $e');
          return false;
        }
      }
      // If all records are successfully processed
      return true;
    } else {
      return true;
    }
  }

  updateSync({required OrgEquipmentModel record}) async {
    //Add
    record.isSynced = 1;
    //Update Record
    int recId = await OrgEquipment().updateRecord(model: record);

    debugPrint("$recId");
  }
}
