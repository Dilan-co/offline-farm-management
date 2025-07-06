import 'package:farm_management/database/tables/crop/crop_client_crop.dart';
import 'package:farm_management/database/tables/crop/crop_client_crop_variety.dart';
import 'package:farm_management/database/tables/crop/crop_crop.dart';
import 'package:farm_management/database/tables/org/org_chemical_product.dart';
import 'package:farm_management/database/tables/org/org_client.dart';
import 'package:farm_management/database/tables/org/org_client_farm.dart';
import 'package:farm_management/database/tables/org/org_equipment.dart';
import 'package:farm_management/database/tables/org/org_equipment_manufacturer.dart';
import 'package:farm_management/database/tables/org/org_equipment_type.dart';
import 'package:farm_management/database/tables/simple_forms/equipment_related_forms/equipment_calibration_log.dart';
import 'package:farm_management/database/tables/simple_forms/equipment_related_forms/equipment_maintenance_log.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/daily_scale_check_record.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/in_house_label_printing.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/plu_sticker_record.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment.dart';
import 'package:farm_management/database/tables/simple_forms/water_source_treatment_forms/water_source_inspection_log.dart';
import 'package:farm_management/database/tables/simple_forms/water_source_treatment_forms/water_treatment_log.dart';
import 'package:farm_management/database/tables/task/task.dart';
import 'package:farm_management/database/tables/user/user.dart';
import 'package:sqflite/sqflite.dart';

class FarmManagementDB {
  //Creating tables for forms
  Future<void> createTables({required Database database}) async {
    //Add all tables for Forms here
    CropClientCropVariety().createTable(database);
    CropClientCrop().createTable(database);
    CropCrop().createTable(database);
    OrgChemicalProduct().createTable(database);
    OrgClientFarm().createTable(database);
    OrgClient().createTable(database);
    OrgEquipmentManufacturer().createTable(database);
    OrgEquipmentType().createTable(database);
    OrgEquipment().createTable(database);
    EquipmentCalibrationLog().createTable(database);
    EquipmentMaintenanceLog().createTable(database);
    DailyScaleCheck().createTable(database);
    FinishedProductSizeCheckHourly().createTable(database);
    FinishedProductWeightCheckFifteenMinutes().createTable(database);
    FinishedProductWeightCheckHourly().createTable(database);
    HarvestRiskAssessment().createTable(database);
    InHouseLabelPrinting().createTable(database);
    PackagingTareWeightCheck().createTable(database);
    PluStickerRecord().createTable(database);
    ProductionBatchLabelAssessment().createTable(database);
    WaterSourceInspectionLog().createTable(database);
    WaterTreatmentLog().createTable(database);
    User().createTable(database);
    Task().createTable(database);
    // TestTable().createTable(database);
  }

  /////Using updateRecord to Delete

  // Future<int> deleteRecord({
  //   required String tableName,
  //   required String idColumnName,
  //   required int id,
  // }) async {
  //   final database = await DatabaseService().database;

  //   int recordId = await database
  //       .delete(tableName, where: "$idColumnName = ?", whereArgs: [id]);

  //   debugPrint("deleteRecord Done");
  //   return recordId;
  // }

  //

  /////Adding new Column to an existing Table

  // Future<void> addNewColumn({
  //   required String tableName,
  //   required String columnName,
  //   required String columnDataType,
  // }) async {
  //   final database = await DatabaseService().database;
  //   //add new column
  //   await database.execute(
  //       """ALTER TABLE $tableName ADD COLUMN "$columnName" $columnDataType""");

  //   debugPrint("addNewColumn Done");
  // }

  // created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  // updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
}
