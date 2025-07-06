import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/crop/crop_client_crop_variety.dart';
import 'package:farm_management/models/table_models/crop/crop_client_crop_variety_model.dart';

class CropClientCropVarietyDataService {
  final StateController stateController = Get.find();

  String get dataUrl => '${stateController.baseUrl}/client-crop-variety';

  Future<bool> getData() async {
    try {
      final response = await http.get(
        Uri.parse(dataUrl),
        headers: {
          'Authorization': 'Bearer ${stateController.getAccessToken()}',
        },
      );
      debugPrint(
          "Response status code from getData post -->> ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseDecoded = await json.decode(response.body);
        debugPrint("Response from getData Decoded -->> $responseDecoded");
        List<CropClientCropVarietyModel> dataList =
            List<CropClientCropVarietyModel>.from(responseDecoded
                .map((data) => CropClientCropVarietyModel.fromJson(data)));
        // Attempt batch insert/update
        try {
          if (dataList.isNotEmpty) {
            await CropClientCropVariety().createRecordsBatch(models: dataList);
          }
        } catch (e) {
          debugPrint("Error during batch insert: $e");
          return false;
        }
        return true;
      } else {
        debugPrint("GET CROP_client_crop_variety Data Sync Failed");
        return false;
      }
    } catch (e) {
      debugPrint("GET CROP_client_crop_variety Error : $e");
      return false;
    }
  }
}
