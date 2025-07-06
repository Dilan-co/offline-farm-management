import 'package:farm_management/services/api_data_services/task/task_data_service.dart';
import 'package:flutter/material.dart';
import 'package:farm_management/services/api_data_services/crop/crop_client_crop_data_service.dart';
import 'package:farm_management/services/api_data_services/crop/crop_client_crop_variety_data_service.dart';
import 'package:farm_management/services/api_data_services/org/org_equipment_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/equipment_related_forms/equipment_calibration_log_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/equipment_related_forms/equipment_maintenance_log_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/in_house_label_printing_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/plu_sticker_record_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/water_source_treatment_forms/water_source_inspection_log_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/water_source_treatment_forms/water_treatment_log_data_service.dart';
import 'package:farm_management/services/api_data_services/user/user_data_service.dart';
import 'package:farm_management/services/api_data_services/crop/crop_crop_data_service.dart';
import 'package:farm_management/services/api_data_services/org/org_chemical_product_data_service.dart';
import 'package:farm_management/services/api_data_services/org/org_client_data_service.dart';
import 'package:farm_management/services/api_data_services/org/org_client_farm_data_service.dart';
import 'package:farm_management/services/api_data_services/org/org_equipment_manufacturer_data_service.dart';
import 'package:farm_management/services/api_data_services/org/org_equipment_type_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/daily_scale_check_record_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check_data_service.dart';
import 'package:farm_management/services/api_data_services/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment_data_service.dart';

class ApiDataService {
  //Add all API GET methods here
  Future<bool> superAdminLoginFetchApiData() async {
    bool isUserSuccess = await UserDataService().getData();
    bool isClientSuccess = await OrgClientDataService().getData();
    bool isCropSuccess = await CropCropDataService().getData();
    bool isCropClientCropSuccess = await CropClientCropDataService().getData();
    bool isCropClientCropVarietySuccess =
        await CropClientCropVarietyDataService().getData();
    bool isClientFarmSuccess = await OrgClientFarmDataService().getData();
    bool isChemicalProductSuccess =
        await OrgChemicalProductDataService().getData();
    bool isOrgEquipmentSuccess = await OrgEquipmentDataService().getData();
    bool isEquipmentTypeSuccess = await OrgEquipmentTypeDataService().getData();
    bool isEquipmentManufacturerSuccess =
        await OrgEquipmentManufacturerDataService().getData();
    bool isTask = await TaskDataService().getData();

    List<bool> values = [
      isUserSuccess,
      isClientSuccess,
      isCropSuccess,
      isCropClientCropSuccess,
      isCropClientCropVarietySuccess,
      isClientFarmSuccess,
      isChemicalProductSuccess,
      isOrgEquipmentSuccess,
      isEquipmentTypeSuccess,
      isEquipmentManufacturerSuccess,
      isTask,
    ];

    if (values.every((value) => value)) {
      debugPrint("All request are successful.");
      return true;
    } else {
      debugPrint("At least one request failed.");
      return false;
    }
  }

  //Add all API POST methods here
  Future<bool> syncPushApiData() async {
    //In OrgEquipmentDataService "getData" will ensure that the "isSynced = 0" data is synced
    //Before pulling all the records from the backend
    //To resolve conflicts with the local database
    bool isOrgEquipmentSuccess = await OrgEquipmentDataService().getData();

    bool isTask = await TaskDataService().getData();

    bool isProductBatchLabelAssessmentSuccess =
        await ProductBatchLabelAssessmentDataService().postData();
    bool isHarvestRiskAssessmentSuccess =
        await HarvestRiskAssessmentDataService().postData();
    bool isDailyScaleCheckRecordSuccess =
        await DailyScaleCheckRecordDataService().postData();
    bool isPackagingTareWeightCheckSuccess =
        await PackagingTareWeightCheckDataService().postData();
    bool isPluStickerRecordSuccess =
        await PluStickerRecordDataService().postData();
    bool isInHouseLabelPrintingSuccess =
        await InHouseLabelPrintingDataService().postData();
    bool isEquipmentMaintenanceLogSuccess =
        await EquipmentMaintenanceLogDataService().postData();
    bool isEquipmentCalibrationLogSuccess =
        await EquipmentCalibrationLogDataService().postData();
    bool isWaterSourceInspectionLogSuccess =
        await WaterSourceInspectionLogDataService().postData();
    bool isWaterTreatmentLogSuccess =
        await WaterTreatmentLogDataService().postData();
    bool isFinishedProductWeightCheckFifteenMinutesSuccess =
        await FinishedProductWeightCheckFifteenMinutesDataService().postData();
    bool isFinishedProductWeightCheckHourlySuccess =
        await FinishedProductWeightCheckHourlyDataService().postData();
    bool isFinishedProductSizeCheckHourlySuccess =
        await FinishedProductSizeCheckHourlyDataService().postData();

    List<bool> values = [
      isOrgEquipmentSuccess,
      isTask,
      isProductBatchLabelAssessmentSuccess,
      isHarvestRiskAssessmentSuccess,
      isDailyScaleCheckRecordSuccess,
      isPackagingTareWeightCheckSuccess,
      isPluStickerRecordSuccess,
      isInHouseLabelPrintingSuccess,
      isEquipmentMaintenanceLogSuccess,
      isEquipmentCalibrationLogSuccess,
      isWaterSourceInspectionLogSuccess,
      isWaterTreatmentLogSuccess,
      isFinishedProductWeightCheckFifteenMinutesSuccess,
      isFinishedProductWeightCheckHourlySuccess,
      isFinishedProductSizeCheckHourlySuccess,
    ];

    if (values.every((value) => value)) {
      debugPrint("All request are successful.");
      return true;
    } else {
      debugPrint("At least one request failed.");
      return false;
    }
  }
}
