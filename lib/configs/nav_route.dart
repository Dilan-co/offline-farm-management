import 'package:farm_management/screens/task/task_add.dart';
import 'package:farm_management/screens/task/task_main_tile_view.dart';
import 'package:farm_management/screens/task/task_view.dart';
import 'package:get/get.dart';
import 'package:farm_management/screens/dashboard.dart';
import 'package:farm_management/screens/signin.dart';
import 'package:farm_management/screens/simple_forms/(not_using)simple_forms_delete.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/asset_type/asset_type_add.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/asset_type/asset_type_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/asset_type/asset_type_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_calibration_log/equipment_calibration_log_add.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_calibration_log/equipment_calibration_log_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_calibration_log/equipment_calibration_log_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_list/equipment_list_add.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_list/equipment_list_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_list/equipment_list_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_maintenance_log/equipment_maintenance_log_add.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_maintenance_log/equipment_maintenance_log_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_maintenance_log/equipment_maintenance_log_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_supplier/equipment_supplier_add.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_supplier/equipment_supplier_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_supplier/equipment_supplier_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/daily_scale_check_record/daily_scale_check_record_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/daily_scale_check_record/daily_scale_check_record_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/daily_scale_check_record/daily_scale_check_record_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly/finished_product_size_check_hourly_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly/finished_product_size_check_hourly_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly/finished_product_size_check_hourly_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes/finished_product_weight_check_fifteen_minutes_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes/finished_product_weight_check_fifteen_minutes_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes/finished_product_weight_check_fifteen_minutes_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly/finished_product_weight_check_hourly_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly/finished_product_weight_check_hourly_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly/finished_product_weight_check_hourly_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment/harvest_risk_assessment_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment/harvest_risk_assessment_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment/harvest_risk_assessment_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/in_house_label_printing/in_house_label_printing_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/in_house_label_printing/in_house_label_printing_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/in_house_label_printing/in_house_label_printing_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check/packaging_tare_weight_check_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check/packaging_tare_weight_check_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check/packaging_tare_weight_check_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/plu_sticker_record/plu_sticker_record_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/plu_sticker_record/plu_sticker_record_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/plu_sticker_record/plu_sticker_record_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment/product_batch_label_assessment_add.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment/product_batch_label_assessment_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment/product_batch_label_assessment_view.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_source_inspection_log/water_source_inspection_log_add.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_source_inspection_log/water_source_inspection_log_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_source_inspection_log/water_source_inspection_log_view.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_treatment_log/water_treatment_log_add.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_treatment_log/water_treatment_log_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_treatment_log/water_treatment_log_view.dart';
import 'package:farm_management/screens/splash_screen.dart';

class NavRoute {
  static String splashScreen = "/splashScreen";
  static String signIn = "/signIn";
  static String dashboard = "/dashboard";
  static String taskAllocation = "/taskAllocation";

  //================== TASK ALLOCATION ==================
  static String taskMainTileView = "/taskMainTileView";
  static String taskAdd = "/taskAdd";
  static String taskView = "/taskView";
  static String taskUpdate = "/taskUpdate";
  static String taskDelete = "/taskDelete";

  //================== SIMPLE FORMS ==================

  //------------ Production/ Harvesting/ Packing Related Forms ------------

  //Product Batch Label Assessment
  static String productBatchLabelAssessmentMainTileView =
      "/productBatchLabelAssessmentMainTileView";
  static String productBatchLabelAssessmentAdd =
      "/productBatchLabelAssessmentAdd";
  static String productBatchLabelAssessmentView =
      "/productBatchLabelAssessmentView";
  static String productBatchLabelAssessmentUpdate =
      "/productBatchLabelAssessmentUpdate";
  static String productBatchLabelAssessmentDelete =
      "/productBatchLabelAssessmentDelete";

  //Harvest Risk Assessment
  static String harvestRiskAssessmentMainTileView =
      "/harvestRiskAssessmentMainTileView";
  static String harvestRiskAssessmentAdd = "/harvestRiskAssessmentAdd";
  static String harvestRiskAssessmentView = "/harvestRiskAssessmentView";
  static String harvestRiskAssessmentUpdate = "/harvestRiskAssessmentUpdate";
  static String harvestRiskAssessmentDelete = "/harvestRiskAssessmentDelete";

  //Harvest Hygiene Assessment
  static String harvestHygieneAssessmentMainTileView =
      "/harvestHygieneAssessmentMainTileView";
  static String harvestHygieneAssessmentAdd = "/harvestHygieneAssessmentAdd";
  static String harvestHygieneAssessmentView = "/harvestHygieneAssessmentView";
  static String harvestHygieneAssessmentUpdate =
      "/harvestHygieneAssessmentUpdate";
  static String harvestHygieneAssessmentDelete =
      "/harvestHygieneAssessmentDelete";

  //Receival Assessment
  static String receivalAssessmentMainTileView =
      "/receivalAssessmentMainTileView";
  static String receivalAssessmentAdd = "/receivalAssessmentAdd";
  static String receivalAssessmentView = "/receivalAssessmentView";
  static String receivalAssessmentUpdate = "/receivalAssessmentUpdate";
  static String receivalAssessmentDelete = "/receivalAssessmentDelete";

  //Finished Product Assessment Record
  static String finishedProductAssessmentRecordMainTileView =
      "/finishedProductAssessmentRecordMainTileView";
  static String finishedProductAssessmentRecordAdd =
      "/finishedProductAssessmentRecordAdd";
  static String finishedProductAssessmentRecordView =
      "/finishedProductAssessmentRecordView";
  static String finishedProductAssessmentRecordUpdate =
      "/finishedProductAssessmentRecordUpdate";
  static String finishedProductAssessmentRecordDelete =
      "/finishedProductAssessmentRecordDelete";

  //Finished Product Weight Check (Fifteen Minutes)
  static String finishedProductWeightCheckFifteenMinutesMainTileView =
      "/finishedProductWeightCheckFifteenMinutesMainTileView";
  static String finishedProductWeightCheckFifteenMinutesAdd =
      "/finishedProductWeightCheckFifteenMinutesAdd";
  static String finishedProductWeightCheckFifteenMinutesView =
      "/finishedProductWeightCheckFifteenMinutesView";
  static String finishedProductWeightCheckFifteenMinutesUpdate =
      "/finishedProductWeightCheckFifteenMinutesUpdate";
  static String finishedProductWeightCheckFifteenMinutesDelete =
      "/finishedProductWeightCheckFifteenMinutesDelete";

  //Finished Product Weight Check (Hourly)
  static String finishedProductWeightCheckHourlyMainTileView =
      "/finishedProductWeightCheckHourlyMainTileView";
  static String finishedProductWeightCheckHourlyAdd =
      "/finishedProductWeightCheckHourlyAdd";
  static String finishedProductWeightCheckHourlyView =
      "/finishedProductWeightCheckHourlyView";
  static String finishedProductWeightCheckHourlyUpdate =
      "/finishedProductWeightCheckHourlyUpdate";
  static String finishedProductWeightCheckHourlyDelete =
      "/finishedProductWeightCheckHourlyDelete";

  //Daily Scale Check Record
  static String dailyScaleCheckRecordMainTileView =
      "/dailyScaleCheckRecordMainTileView";
  static String dailyScaleCheckRecordAdd = "/dailyScaleCheckRecordAdd";
  static String dailyScaleCheckRecordView = "/dailyScaleCheckRecordView";
  static String dailyScaleCheckRecordUpdate = "/dailyScaleCheckRecordUpdate";
  static String dailyScaleCheckRecordDelete = "/dailyScaleCheckRecordDelete";

  //Packaging Tare Weight Check
  static String packagingTareWeightCheckMainTileView =
      "/packagingTareWeightCheckMainTileView";
  static String packagingTareWeightCheckAdd = "/packagingTareWeightCheckAdd";
  static String packagingTareWeightCheckView = "/packagingTareWeightCheckView";
  static String packagingTareWeightCheckUpdate =
      "/packagingTareWeightCheckUpdate";
  static String packagingTareWeightCheckDelete =
      "/packagingTareWeightCheckDelete";

  //Daily Inspections (Packing Shed)
  static String dailyInspectionsPackingShedMainTileView =
      "/dailyInspectionsPackingShedMainTileView";
  static String dailyInspectionsPackingShedAdd =
      "/dailyInspectionsPackingShedAdd";
  static String dailyInspectionsPackingShedView =
      "/dailyInspectionsPackingShedView";
  static String dailyInspectionsPackingShedUpdate =
      "/dailyInspectionsPackingShedUpdate";
  static String dailyInspectionsPackingShedDelete =
      "/dailyInspectionsPackingShedDelete";

  //PLU Sticker Record
  static String pluStickerRecordMainTileView = "/pluStickerRecordMainTileView";
  static String pluStickerRecordAdd = "/pluStickerRecordAdd";
  static String pluStickerRecordView = "/pluStickerRecordView";
  static String pluStickerRecordUpdate = "/pluStickerRecordUpdate";
  static String pluStickerRecordDelete = "/pluStickerRecordDelete";

  //In-house Label Printing - Label Check Sheet
  static String inHouseLabelPrintingMainTileView =
      "/inHouseLabelPrintingMainTileView";
  static String inHouseLabelPrintingAdd = "/inHouseLabelPrintingAdd";
  static String inHouseLabelPrintingView = "/inHouseLabelPrintingView";
  static String inHouseLabelPrintingUpdate = "/inHouseLabelPrintingUpdate";
  static String inHouseLabelPrintingDelete = "/inHouseLabelPrintingDelete";

  //Finished Product Size Check (Hourly)
  static String finishedProductSizeCheckHourlyMainTileView =
      "/finishedProductSizeCheckHourlyMainTileView";
  static String finishedProductSizeCheckHourlyAdd =
      "/finishedProductSizeCheckHourlyAdd";
  static String finishedProductSizeCheckHourlyView =
      "/finishedProductSizeCheckHourlyView";
  static String finishedProductSizeCheckHourlyUpdate =
      "/finishedProductSizeCheckHourlyUpdate";
  static String finishedProductSizeCheckHourlyDelete =
      "/finishedProductSizeCheckHourlyDelete";

  //

  //------------ Equipment Related Forms ------------

  //Asset Types
  static String assetTypesMainTileView = "/assetTypesMainTileView";
  static String assetTypesAdd = "/assetTypesAdd";
  static String assetTypesView = "/assetTypesView";
  static String assetTypesUpdate = "/assetTypesUpdate";
  static String assetTypesDelete = "/assetTypesDelete";

  //Equipment Suppliers
  static String equipmentSuppliersMainTileView =
      "/equipmentSuppliersMainTileView";
  static String equipmentSuppliersAdd = "/equipmentSuppliersAdd";
  static String equipmentSuppliersView = "/equipmentSuppliersView";
  static String equipmentSuppliersUpdate = "/equipmentSuppliersUpdate";
  static String equipmentSuppliersDelete = "/equipmentSuppliersDelete";

  //Equipment List
  static String equipmentListMainTileView = "/equipmentListMainTileView";
  static String equipmentListAdd = "/equipmentListAdd";
  static String equipmentListView = "/equipmentListView";
  static String equipmentListUpdate = "/equipmentListUpdate";
  static String equipmentListDelete = "/equipmentListDelete";

  //Equipment Maintenance Log
  static String equipmentMaintenanceLogMainTileView =
      "/equipmentMaintenanceLogMainTileView";
  static String equipmentMaintenanceLogAdd = "/equipmentMaintenanceLogAdd";
  static String equipmentMaintenanceLogView = "/equipmentMaintenanceLogView";
  static String equipmentMaintenanceLogUpdate =
      "/equipmentMaintenanceLogUpdate";
  static String equipmentMaintenanceLogDelete =
      "/equipmentMaintenanceLogDelete";

  //Equipment Calibration Log
  static String equipmentCalibrationLogMainTileView =
      "/equipmentCalibrationLogMainTileView";
  static String equipmentCalibrationLogAdd = "/equipmentCalibrationLogAdd";
  static String equipmentCalibrationLogView = "/equipmentCalibrationLogView";
  static String equipmentCalibrationLogUpdate =
      "/equipmentCalibrationLogUpdate";
  static String equipmentCalibrationLogDelete =
      "/equipmentCalibrationLogDelete";

  //

  //------------ Chemical Product Related Forms ------------

  //Chemical Products
  static String chemicalProductMainTileView = "/chemicalProductMainTileView";
  static String chemicalProductAdd = "/chemicalProductAdd";
  static String chemicalProductView = "/chemicalProductView";
  static String chemicalProductUpdate = "/chemicalProductUpdate";
  static String chemicalProductDelete = "/chemicalProductDelete";

  //Fertilizer And Soil Amendment Log
  static String fertilizerAndSoilAmendmentLogMainTileView =
      "/fertilizerAndSoilAmendmentLogMainTileView";
  static String fertilizerAndSoilAmendmentLogAdd =
      "/fertilizerAndSoilAmendmentLogAdd";
  static String fertilizerAndSoilAmendmentLogView =
      "/fertilizerAndSoilAmendmentLogView";
  static String fertilizerAndSoilAmendmentLogUpdate =
      "/fertilizerAndSoilAmendmentLogUpdate";
  static String fertilizerAndSoilAmendmentLogDelete =
      "/fertilizerAndSoilAmendmentLogDelete";

  //--------------------------------------------------------------------
  //Sub Menu ---->>>  Chemical Products
  static String fertilizerAndSoilAmendmentLogChemicalProductAdd =
      "/fertilizerAndSoilAmendmentLogChemicalProductAdd";
  static String fertilizerAndSoilAmendmentLogChemicalProductView =
      "/fertilizerAndSoilAmendmentLogChemicalProductView";
  static String fertilizerAndSoilAmendmentLogChemicalProductUpdate =
      "/fertilizerAndSoilAmendmentLogChemicalProductUpdate";
  //--------------------------------------------------------------------

  //Pest Control Record
  static String pestControlRecordMainTileView =
      "/pestControlRecordMainTileView";
  static String pestControlRecordAdd = "/pestControlRecordAdd";
  static String pestControlRecordView = "/pestControlRecordView";
  static String pestControlRecordUpdate = "/pestControlRecordUpdate";
  static String pestControlRecordDelete = "/pestControlRecordDelete";

  //--------------------------------------------------------------------
  //Sub Menu ---->>>  Chemical Products
  static String pestControlRecordChemicalProductAdd =
      "/pestControlRecordChemicalProductAdd";
  static String pestControlRecordChemicalProductView =
      "/pestControlRecordChemicalProductView";
  static String pestControlRecordChemicalProductUpdate =
      "/pestControlRecordChemicalProductUpdate";
  //--------------------------------------------------------------------

  //Pre Harvest Chemical Application Log
  static String preHarvestChemicalApplicationLogMainTileView =
      "/preHarvestChemicalApplicationLogMainTileView";
  static String preHarvestChemicalApplicationLogAdd =
      "/preHarvestChemicalApplicationLogAdd";
  static String preHarvestChemicalApplicationLogView =
      "/preHarvestChemicalApplicationLogView";
  static String preHarvestChemicalApplicationLogUpdate =
      "/preHarvestChemicalApplicationLogUpdate";
  static String preHarvestChemicalApplicationLogDelete =
      "/preHarvestChemicalApplicationLogDelete";

  //--------------------------------------------------------------------
  //Sub Menu ---->>>  Chemical Products
  static String preHarvestChemicalApplicationLogChemicalProductAdd =
      "/preHarvestChemicalApplicationLogChemicalProductAdd";
  static String preHarvestChemicalApplicationLogChemicalProductView =
      "/preHarvestChemicalApplicationLogChemicalProductView";
  static String preHarvestChemicalApplicationLogChemicalProductUpdate =
      "/preHarvestChemicalApplicationLogChemicalProductUpdate";
  //--------------------------------------------------------------------

  //Post Harvest Chemical Treatment Log
  static String postHarvestChemicalTreatmentLogMainTileView =
      "/postHarvestChemicalTreatmentLogMainTileView";
  static String postHarvestChemicalTreatmentLogAdd =
      "/postHarvestChemicalTreatmentLogAdd";
  static String postHarvestChemicalTreatmentLogView =
      "/postHarvestChemicalTreatmentLogView";
  static String postHarvestChemicalTreatmentLogUpdate =
      "/postHarvestChemicalTreatmentLogUpdate";
  static String postHarvestChemicalTreatmentLogDelete =
      "/postHarvestChemicalTreatmentLogDelete";

  //--------------------------------------------------------------------
  //Sub Menu ---->>>  Chemical Products
  static String postHarvestChemicalTreatmentLogChemicalProductAdd =
      "/postHarvestChemicalTreatmentLogChemicalProductAdd";
  static String postHarvestChemicalTreatmentLogChemicalProductView =
      "/postHarvestChemicalTreatmentLogChemicalProductView";
  static String postHarvestChemicalTreatmentLogChemicalProductUpdate =
      "/postHarvestChemicalTreatmentLogChemicalProductUpdate";
  //--------------------------------------------------------------------

  //

  //------------ Water Source/Treatment Forms ------------

  //Water Source Inspection Log
  static String waterSourceInspectionLogMainTileView =
      "/waterSourceInspectionLogMainTileView";
  static String waterSourceInspectionLogAdd = "/waterSourceInspectionLogAdd";
  static String waterSourceInspectionLogView = "/waterSourceInspectionLogView";
  static String waterSourceInspectionLogUpdate =
      "/waterSourceInspectionLogUpdate";
  static String waterSourceInspectionLogDelete =
      "/waterSourceInspectionLogDelete";

  //Water Treatment Log
  static String waterTreatmentLogMainTileView =
      "/waterTreatmentLogMainTileView";
  static String waterTreatmentLogAdd = "/waterTreatmentLogAdd";
  static String waterTreatmentLogView = "/waterTreatmentLogView";
  static String waterTreatmentLogUpdate = "/waterTreatmentLogUpdate";
  static String waterTreatmentLogDelete = "/waterTreatmentLogDelete";

  //

  //------------ Other Forms ------------

  //Knife Register
  static String knifeRegisterMainTileView = "/knifeRegisterMainTileView";
  static String knifeRegisterAdd = "/knifeRegisterAdd";
  static String knifeRegisterView = "/knifeRegisterView";
  static String knifeRegisterUpdate = "/knifeRegisterUpdate";
  static String knifeRegisterDelete = "/knifeRegisterDelete";

  //Glass Register
  static String glassRegisterMainTileView = "/glassRegisterMainTileView";
  static String glassRegisterAdd = "/glassRegisterAdd";
  static String glassRegisterView = "/glassRegisterView";
  static String glassRegisterUpdate = "/glassRegisterUpdate";
  static String glassRegisterDelete = "/glassRegisterDelete";

  //Customer And Specification Register
  static String customerAndSpecificationRegisterMainTileView =
      "/customerAndSpecificationRegisterMainTileView";
  static String customerAndSpecificationRegisterAdd =
      "/customerAndSpecificationRegisterAdd";
  static String customerAndSpecificationRegisterView =
      "/customerAndSpecificationRegisterView";
  static String customerAndSpecificationRegisterUpdate =
      "/customerAndSpecificationRegisterUpdate";
  static String customerAndSpecificationRegisterDelete =
      "/customerAndSpecificationRegisterDelete";
}

final navRoute = [
  GetPage(
    name: NavRoute.splashScreen,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: NavRoute.signIn,
    page: () => const SignIn(),
  ),
  GetPage(
    name: NavRoute.dashboard,
    page: () => const Dashboard(),
  ),

  //================== TASK ALLOCATION ==================

  GetPage(
    name: NavRoute.taskMainTileView,
    page: () => const TaskMainTileView(),
  ),
  GetPage(
    name: NavRoute.taskAdd,
    page: () => const TaskAdd(),
  ),
  GetPage(
    name: NavRoute.taskView,
    page: () => TaskView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.taskUpdate,
    page: () => TaskAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.taskDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //================== SIMPLE FORMS ==================

  //------------ Production/ Harvesting/ Packing Related Forms ------------

  //Product Batch Label Assessment
  GetPage(
    name: NavRoute.productBatchLabelAssessmentMainTileView,
    page: () => const ProductBatchLabelAssessmentMainTileView(),
  ),
  GetPage(
    name: NavRoute.productBatchLabelAssessmentAdd,
    page: () => const ProductBatchLabelAssessmentAdd(),
  ),
  GetPage(
    name: NavRoute.productBatchLabelAssessmentView,
    page: () => ProductBatchLabelAssessmentView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.productBatchLabelAssessmentUpdate,
    page: () => ProductBatchLabelAssessmentAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.productBatchLabelAssessmentDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Harvest Risk Assessment
  GetPage(
    name: NavRoute.harvestRiskAssessmentMainTileView,
    page: () => const HarvestRiskAssessmentMainTileView(),
  ),
  GetPage(
    name: NavRoute.harvestRiskAssessmentAdd,
    page: () => const HarvestRiskAssessmentAdd(),
  ),
  GetPage(
    name: NavRoute.harvestRiskAssessmentView,
    page: () => HarvestRiskAssessmentView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.harvestRiskAssessmentUpdate,
    page: () => HarvestRiskAssessmentAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.harvestRiskAssessmentDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Finished Product Weight Check (Fifteen Minutes)
  GetPage(
    name: NavRoute.finishedProductWeightCheckFifteenMinutesMainTileView,
    page: () => const FinishedProductWeightCheckFifteenMinutesMainTileView(),
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckFifteenMinutesAdd,
    page: () => const FinishedProductWeightCheckFifteenMinutesAdd(),
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckFifteenMinutesView,
    page: () => FinishedProductWeightCheckFifteenMinutesView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckFifteenMinutesUpdate,
    page: () => FinishedProductWeightCheckFifteenMinutesAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckFifteenMinutesDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Finished Product Weight Check (Hourly)
  GetPage(
    name: NavRoute.finishedProductWeightCheckHourlyMainTileView,
    page: () => const FinishedProductWeightCheckHourlyMainTileView(),
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckHourlyAdd,
    page: () => const FinishedProductWeightCheckHourlyAdd(),
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckHourlyView,
    page: () => FinishedProductWeightCheckHourlyView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckHourlyUpdate,
    page: () => FinishedProductWeightCheckHourlyAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.finishedProductWeightCheckHourlyDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Daily Scale Check Record
  GetPage(
    name: NavRoute.dailyScaleCheckRecordMainTileView,
    page: () => const DailyScaleCheckRecordMainTileView(),
  ),
  GetPage(
    name: NavRoute.dailyScaleCheckRecordAdd,
    page: () => const DailyScaleCheckRecordAdd(),
  ),
  GetPage(
    name: NavRoute.dailyScaleCheckRecordView,
    page: () => DailyScaleCheckRecordView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.dailyScaleCheckRecordUpdate,
    page: () => DailyScaleCheckRecordAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.dailyScaleCheckRecordDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Packaging Tare Weight Check
  GetPage(
    name: NavRoute.packagingTareWeightCheckMainTileView,
    page: () => const PackagingTareWeightCheckMainTileView(),
  ),
  GetPage(
    name: NavRoute.packagingTareWeightCheckAdd,
    page: () => const PackagingTareWeightCheckAdd(),
  ),
  GetPage(
    name: NavRoute.packagingTareWeightCheckView,
    page: () => PackagingTareWeightCheckView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.packagingTareWeightCheckUpdate,
    page: () => PackagingTareWeightCheckAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.packagingTareWeightCheckDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //PLU Sticker Record
  GetPage(
    name: NavRoute.pluStickerRecordMainTileView,
    page: () => const PLUStickerRecordMainTileView(),
  ),
  GetPage(
    name: NavRoute.pluStickerRecordAdd,
    page: () => const PLUStickerRecordAdd(),
  ),
  GetPage(
    name: NavRoute.pluStickerRecordView,
    page: () => PLUStickerRecordView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.pluStickerRecordUpdate,
    page: () => PLUStickerRecordAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.pluStickerRecordDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //In-house Label Printing - Label Check Sheet
  GetPage(
    name: NavRoute.inHouseLabelPrintingMainTileView,
    page: () => const InHouseLabelPrintingMainTileView(),
  ),
  GetPage(
    name: NavRoute.inHouseLabelPrintingAdd,
    page: () => const InHouseLabelPrintingAdd(),
  ),
  GetPage(
    name: NavRoute.inHouseLabelPrintingView,
    page: () => InHouseLabelPrintingView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.inHouseLabelPrintingUpdate,
    page: () => InHouseLabelPrintingAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.inHouseLabelPrintingDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Finished Product Size Check (Hourly)
  GetPage(
    name: NavRoute.finishedProductSizeCheckHourlyMainTileView,
    page: () => const FinishedProductSizeCheckHourlyMainTileView(),
  ),
  GetPage(
    name: NavRoute.finishedProductSizeCheckHourlyAdd,
    page: () => const FinishedProductSizeCheckHourlyAdd(),
  ),
  GetPage(
    name: NavRoute.finishedProductSizeCheckHourlyView,
    page: () => FinishedProductSizeCheckHourlyView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.finishedProductSizeCheckHourlyUpdate,
    page: () => FinishedProductSizeCheckHourlyAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.finishedProductSizeCheckHourlyDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //

  //------------ Equipment Related Forms ------------

  //Asset Types
  GetPage(
    name: NavRoute.assetTypesMainTileView,
    page: () => const AssetTypeMainTileView(),
  ),
  GetPage(
    name: NavRoute.assetTypesAdd,
    page: () => const AssetTypeAdd(),
  ),
  GetPage(
    name: NavRoute.assetTypesView,
    page: () => AssetTypeView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.assetTypesUpdate,
    page: () => AssetTypeAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.assetTypesDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Equipment Suppliers
  GetPage(
    name: NavRoute.equipmentSuppliersMainTileView,
    page: () => const EquipmentSupplierMainTileView(),
  ),
  GetPage(
    name: NavRoute.equipmentSuppliersAdd,
    page: () => const EquipmentSupplierAdd(),
  ),
  GetPage(
    name: NavRoute.equipmentSuppliersView,
    page: () => EquipmentSupplierView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.equipmentSuppliersUpdate,
    page: () => EquipmentSupplierAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.equipmentSuppliersDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Equipment List
  GetPage(
    name: NavRoute.equipmentListMainTileView,
    page: () => const EquipmentListMainTileView(),
  ),
  GetPage(
    name: NavRoute.equipmentListAdd,
    page: () => const EquipmentListAdd(),
  ),
  GetPage(
    name: NavRoute.equipmentListView,
    page: () => EquipmentListView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.equipmentListUpdate,
    page: () => EquipmentListAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.equipmentListDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Equipment Maintenance Log
  GetPage(
    name: NavRoute.equipmentMaintenanceLogMainTileView,
    page: () => const EquipmentMaintenanceLogMainTileView(),
  ),
  GetPage(
    name: NavRoute.equipmentMaintenanceLogAdd,
    page: () => const EquipmentMaintenanceLogAdd(),
  ),
  GetPage(
    name: NavRoute.equipmentMaintenanceLogView,
    page: () => EquipmentMaintenanceLogView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.equipmentMaintenanceLogUpdate,
    page: () => EquipmentMaintenanceLogAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.equipmentMaintenanceLogDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Equipment Calibration Log
  GetPage(
    name: NavRoute.equipmentCalibrationLogMainTileView,
    page: () => const EquipmentCalibrationLogMainTileView(),
  ),
  GetPage(
    name: NavRoute.equipmentCalibrationLogAdd,
    page: () => const EquipmentCalibrationLogAdd(),
  ),
  GetPage(
    name: NavRoute.equipmentCalibrationLogView,
    page: () => EquipmentCalibrationLogView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.equipmentCalibrationLogUpdate,
    page: () => EquipmentCalibrationLogAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.equipmentCalibrationLogDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //

  //------------ Water Source/Treatment Forms ------------

  //Water Source Inspection Log
  GetPage(
    name: NavRoute.waterSourceInspectionLogMainTileView,
    page: () => const WaterSourceInspectionLogMainTileView(),
  ),
  GetPage(
    name: NavRoute.waterSourceInspectionLogAdd,
    page: () => const WaterSourceInspectionLogAdd(),
  ),
  GetPage(
    name: NavRoute.waterSourceInspectionLogView,
    page: () => WaterSourceInspectionLogView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.waterSourceInspectionLogUpdate,
    page: () => WaterSourceInspectionLogAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.waterSourceInspectionLogDelete,
    page: () => const SimpleFormsDelete(),
  ),

  //Water Treatment Log
  GetPage(
    name: NavRoute.waterTreatmentLogMainTileView,
    page: () => const WaterTreatmentLogMainTileView(),
  ),
  GetPage(
    name: NavRoute.waterTreatmentLogAdd,
    page: () => const WaterTreatmentLogAdd(),
  ),
  GetPage(
    name: NavRoute.waterTreatmentLogView,
    page: () => WaterTreatmentLogView(
      updateRouter: Get.parameters["updateRouter"]!,
      onDelete: Get.arguments['onDelete'],
      data: Get.arguments['dataObject'],
    ),
    arguments: const {},
    parameters: const {"updateRouter": ''},
  ),
  GetPage(
    name: NavRoute.waterTreatmentLogUpdate,
    page: () => WaterTreatmentLogAdd(
      isUpdate: true,
      data: Get.arguments,
    ),
    arguments: const {},
  ),
  GetPage(
    name: NavRoute.waterTreatmentLogDelete,
    page: () => const SimpleFormsDelete(),
  ),
];
