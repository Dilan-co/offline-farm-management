import 'package:farm_management/database/tables/user/user.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/crop/crop_crop.dart';
import 'package:farm_management/database/tables/org/org_client.dart';
import 'package:farm_management/database/tables/org/org_client_farm.dart';
import 'package:farm_management/database/tables/org/org_equipment.dart';
import 'package:farm_management/database/tables/org/org_equipment_manufacturer.dart';
import 'package:farm_management/database/tables/org/org_equipment_type.dart';
import 'package:farm_management/models/table_models/crop/crop_client_crop_variety_model.dart';
import 'package:farm_management/models/table_models/crop/crop_crop_model.dart';
import 'package:farm_management/models/table_models/org/org_client_farm_model.dart';
import 'package:farm_management/models/table_models/org/org_client_model.dart';
import 'package:farm_management/models/table_models/org/org_equipment_manufacturer_model.dart';
import 'package:farm_management/models/table_models/org/org_equipment_model.dart';
import 'package:farm_management/models/table_models/org/org_equipment_type_model.dart';

class DropdownList {
  final StateController stateController = Get.find();

  void generateDropdownLists() async {
    clientListGenerate();
    farmListGenerate();
    cropListGenerate();
    equipmentNameListGenerate();
    assetTypeListGenerate();
    equipmentManufacturerNameListGenerate();
    workerListGenerate();
  }

  clientListGenerate() async {
    List<OrgClientModel> data = await OrgClient().fetchAllRecords();
    stateController.clientList.clear();
    for (var values in data) {
      stateController.clientList.add({values.clientId!: '${values.name}'});
    }
    debugPrint("clientList ${stateController.clientList}");
  }

  farmListGenerate() async {
    List<OrgClientFarmModel> data = await OrgClientFarm().fetchAllRecords();
    stateController.farmList.clear();
    for (var values in data) {
      stateController.farmList.add({values.clientFarmId!: values.name});
    }
    debugPrint("farmList ${stateController.farmList}");
  }

  cropListGenerate() async {
    List<CropCropModel> data = await CropCrop().fetchAllRecords();
    stateController.cropList.clear();
    for (var values in data) {
      stateController.cropList.add({values.cropId!: values.name});
    }
    debugPrint("cropList ${stateController.cropList}");
  }

  Future<List<Map<int, String>>> varietyListGenerate(
      {required List<CropClientCropVarietyModel> dataList}) async {
    List<Map<int, String>> list = [];
    for (var values in dataList) {
      list.add({values.clientCropVarietyId!: values.name});
    }
    debugPrint("varietyList $list");
    return list;
  }

  equipmentNameListGenerate() async {
    List<OrgEquipmentModel> data = await OrgEquipment().fetchAllRecords();
    stateController.equipmentNameList.clear();
    for (var values in data) {
      stateController.equipmentNameList.add({values.equipmentId!: values.name});
    }
    debugPrint("equipmentNameList ${stateController.equipmentNameList}");
  }

  assetTypeListGenerate() async {
    List<OrgEquipmentTypeModel> data =
        await OrgEquipmentType().fetchAllRecords();
    stateController.assetTypeList.clear();
    for (var values in data) {
      stateController.assetTypeList.add({values.equipmentTypeId!: values.name});
    }
    debugPrint("assetTypeList ${stateController.assetTypeList}");
  }

  equipmentManufacturerNameListGenerate() async {
    List<OrgEquipmentManufacturerModel> data =
        await OrgEquipmentManufacturer().fetchAllRecords();
    stateController.equipmentManufacturerNameList.clear();
    for (var values in data) {
      stateController.equipmentManufacturerNameList
          .add({values.equipmentManufacturerId!: values.name});
    }
    debugPrint(
        "equipmentManufacturerNameList ${stateController.equipmentManufacturerNameList}");
  }

  workerListGenerate() async {
    List<UserModel> data = await User().fetchAllRecords();
    stateController.workerList.clear();
    for (var values in data) {
      if (values.userType.toLowerCase() == "worker") {
        stateController.workerList.add({values.userId!: values.displayName});
      }
    }
    debugPrint("workerList ${stateController.workerList}");
  }
}


  // farmList() async {
  //   List<OrgClientFarmModel> data = await OrgClientFarm().fetchAllRecords();
  //   stateController.rawFarmList = data;
  //   debugPrint("clientList ${stateController.rawFarmList}");
  // }

  // sortFarmListByClient({required clientId}) {
  //   List<OrgClientFarmModel> sortedFarmListByClient = stateController
  //       .rawFarmList
  //       .where((item) => item.clientId == clientId)
  //       .toList();
  //   for (var values in sortedFarmListByClient) {
  //     stateController.farmList.add({values.clientFarmId!: values.name});
  //   }
  //   debugPrint("farmList ${stateController.farmList}");
  // }