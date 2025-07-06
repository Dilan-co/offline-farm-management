import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/user/user.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';

class UserDataService {
  final StateController stateController = Get.find();

  String get dataUrl => '${stateController.baseUrl}/user';

  Future<bool> getData() async {
    try {
      final response = await http.get(
        Uri.parse(dataUrl),
        headers: {
          'Authorization': 'Bearer ${stateController.getAccessToken()}',
        },
      );
      debugPrint(
          "Response status code from getData request -->> ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseDecoded = await json.decode(response.body);
        debugPrint("Response from getData Decoded -->> $responseDecoded");
        List<UserModel> dataList = List<UserModel>.from(
            responseDecoded.map((data) => UserModel.fromJson(data)));
        // Attempt batch insert/update
        try {
          if (dataList.isNotEmpty) {
            await User().createRecordsBatch(models: dataList);
          }
        } catch (e) {
          debugPrint("Error during batch insert: $e");
          return false;
        }
        return true;
      } else {
        debugPrint("GET User_user Data Sync Failed");
        return false;
      }
    } catch (e) {
      debugPrint("GET User_user Error : $e");
      return false;
    }
  }
}
