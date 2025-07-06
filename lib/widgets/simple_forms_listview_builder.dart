import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/asset_type/asset_type_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_calibration_log/equipment_calibration_log_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_list/equipment_list_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_maintenance_log/equipment_maintenance_log_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_supplier/equipment_supplier_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/daily_scale_check_record/daily_scale_check_record_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly/finished_product_size_check_hourly_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes/finished_product_weight_check_fifteen_minutes_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly/finished_product_weight_check_hourly_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment/harvest_risk_assessment_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/in_house_label_printing/in_house_label_printing_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check/packaging_tare_weight_check_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/plu_sticker_record/plu_sticker_record_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment/product_batch_label_assessment_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_source_inspection_log/water_source_inspection_log_main_tile_view.dart';
import 'package:farm_management/screens/simple_forms/water_source_treatment_forms/water_treatment_log/water_treatment_log_main_tile_view.dart';

class SimpleFormsListViewBuilder extends StatelessWidget {
  final String simpleFormsSubCategory;
  final dynamic simpleFormsSubCategoryList;
  const SimpleFormsListViewBuilder({
    super.key,
    required this.simpleFormsSubCategory,
    required this.simpleFormsSubCategoryList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          // physics: BouncingScrollPhysics(),
          // padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemCount: simpleFormsSubCategoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: TextButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                    backgroundColor: WidgetStatePropertyAll(CFGColor.lightGrey),
                    overlayColor: WidgetStatePropertyAll(CFGColor.midGrey),
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.only(top: 15, bottom: 15)),
                  ),
                  child: Text(simpleFormsSubCategoryList.elementAt(index),
                      style: TextStyle(
                        height: 0,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                  onPressed: () {
                    //open view
                    debugPrint(simpleFormsSubCategory);
                    if (simpleFormsSubCategory ==
                        "SimpleFormsSubCategory().productionHarvestingPackagingForms") {
                      if (index == 0) {
                        Get.to(() =>
                            const ProductBatchLabelAssessmentMainTileView());
                      } else if (index == 1) {
                        Get.to(() => const HarvestRiskAssessmentMainTileView());
                      } else if (index == 2) {
                        Get.to(() =>
                            const FinishedProductWeightCheckFifteenMinutesMainTileView());
                      } else if (index == 3) {
                        Get.to(() =>
                            const FinishedProductWeightCheckHourlyMainTileView());
                      } else if (index == 4) {
                        Get.to(() => const DailyScaleCheckRecordMainTileView());
                      } else if (index == 5) {
                        Get.to(
                            () => const PackagingTareWeightCheckMainTileView());
                      } else if (index == 6) {
                        Get.to(() => const PLUStickerRecordMainTileView());
                      } else if (index == 7) {
                        Get.to(() => const InHouseLabelPrintingMainTileView());
                      } else if (index == 8) {
                        Get.to(() =>
                            const FinishedProductSizeCheckHourlyMainTileView());
                      }
                    } else if (simpleFormsSubCategory ==
                        "SimpleFormsSubCategory().equipmentRelatedForms") {
                      if (index == 0) {
                        Get.to(() => const AssetTypeMainTileView());
                      } else if (index == 1) {
                        Get.to(() => const EquipmentSupplierMainTileView());
                      } else if (index == 2) {
                        Get.to(() => const EquipmentListMainTileView());
                      } else if (index == 3) {
                        Get.to(
                            () => const EquipmentMaintenanceLogMainTileView());
                      } else if (index == 4) {
                        Get.to(
                            () => const EquipmentCalibrationLogMainTileView());
                      }
                    } else if (simpleFormsSubCategory ==
                        "SimpleFormsSubCategory().waterSourceTreatmentForms") {
                      if (index == 0) {
                        Get.to(
                            () => const WaterSourceInspectionLogMainTileView());
                      } else if (index == 1) {
                        Get.to(() => const WaterTreatmentLogMainTileView());
                      }
                    }
                  }),
            );
          }),
    );
  }
}
