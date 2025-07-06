import 'dart:convert';

import 'package:farm_management/database/tables/task/task.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';

class TaskDataService {
  final StateController stateController = Get.find();

  String get formDataUrl => '${stateController.baseUrl}/task';
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
        List<TaskModel> dataList = List<TaskModel>.from(
            responseDecoded.map((data) => TaskModel.fromJson(data)));
        // Attempt batch insert/update
        try {
          if (dataList.isNotEmpty) {
            await Task().createRecordsBatch(models: dataList);
          }
        } catch (e) {
          debugPrint("Error during batch insert: $e");
          return false;
        }
        return true;
      } else {
        debugPrint("GET TASK_task Data Sync Failed");
        return false;
      }
    } catch (e) {
      debugPrint("GET TASK_task Error : $e");
      return false;
    }
  }

  Future<bool> _postData() async {
    String bearerToken = stateController.getAccessToken();
    List<TaskModel> recordList = await Task().fetchNotSyncedRecords();

    //Delete "delete_date" Expired Records
    // Task().deleteExpiredRecords();

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
            // Map<String, dynamic> responseDecoded = jsonDecode(response.body);

            // Mark is_synced 1
            updateSync(record: record);
          } else {
            debugPrint(
                'POST TASK_task Data Sync Failed: ${response.statusCode} - ${response.body}');
            return false;
          }
        } catch (e) {
          debugPrint('POST TASK_task Error: $e');
          return false;
        }
      }
      // Refresh local records after sync
      getData();
      // If all records are successfully processed
      return true;
    } else {
      return true;
    }
  }

  updateSync({required TaskModel record}) async {
    //Add
    record.isSynced = 1;
    //Update Record
    int recId = await Task().updateRecord(model: record);

    debugPrint("$recId");
  }
}
