import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/org/org_equipment_manufacturer.dart';
import 'package:farm_management/models/table_models/org/org_equipment_manufacturer_model.dart';

class OrgEquipmentManufacturerDataService {
  final StateController stateController = Get.find();

  String get dataUrl => '${stateController.baseUrl}/sf-equipment-manufacturer';

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
        List<OrgEquipmentManufacturerModel> dataList =
            List<OrgEquipmentManufacturerModel>.from(responseDecoded
                .map((data) => OrgEquipmentManufacturerModel.fromJson(data)));
        // Attempt batch insert/update
        try {
          if (dataList.isNotEmpty) {
            await OrgEquipmentManufacturer()
                .createRecordsBatch(models: dataList);
          }
        } catch (e) {
          debugPrint("Error during batch insert: $e");
          return false;
        }
        return true;
      } else {
        debugPrint("GET ORG_equipment_manufacturer Data Sync Failed");
        return false;
      }
    } catch (e) {
      debugPrint("GET ORG_equipment_manufacturer Error : $e");
      return false;
    }
  }
}
