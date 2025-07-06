import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly_model.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';

class FinishedProductWeightCheckHourlyMainTileView extends StatefulWidget {
  const FinishedProductWeightCheckHourlyMainTileView({super.key});

  @override
  State<FinishedProductWeightCheckHourlyMainTileView> createState() =>
      _FinishedProductWeightCheckHourlyMainTileViewState();
}

class _FinishedProductWeightCheckHourlyMainTileViewState
    extends State<FinishedProductWeightCheckHourlyMainTileView> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  List<FinishedProductWeightCheckHourlyModel>? recordList;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      recordList = await FinishedProductWeightCheckHourly().fetchAllRecords();
      debugPrint(recordList!.isEmpty
          ? "Empty List"
          : "${recordList?[0].finishedProductWeightCheckHourlyId}");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  Future<bool> deleteRecord(
      FinishedProductWeightCheckHourlyModel dataObject) async {
    try {
      int recordId = await FinishedProductWeightCheckHourly()
          .deleteRecord(model: dataObject);
      debugPrint("Deleted Record from table where id = $recordId");
      return true;
    } catch (error) {
      debugPrint('Error updating record: $error');
      // Return an appropriate value or rethrow the exception if needed
      rethrow;
    }
  }

  onDelete(bool delete, dynamic dataObject) async {
    if (delete == true) {
      await deleteRecord(dataObject);
      setState(() {
        loadingFuture = loadRecords();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(
            title: "Finished Product Weight Check (Hourly)", isMainTile: true),
        //
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding:
              EdgeInsets.only(bottom: 20, right: CFGTheme.bodyLRPadding - 15),
          child: SB(
            width: 60 * stateController.getDeviceAppBarMultiplier() as double,
            height: 60 * stateController.getDeviceAppBarMultiplier() as double,
            child: FloatingActionButton(
              onPressed: () async {
                dynamic result = await Get.toNamed(
                    NavRoute.finishedProductWeightCheckHourlyAdd);
                if (result == true) {
                  // The route was popped with a true value
                  setState(() {
                    loadingFuture = loadRecords();
                  });
                }
              },
              backgroundColor: CFGTheme.button,
              hoverColor: CFGTheme.buttonOverlay,
              shape: const CircleBorder(),
              child: Icon(
                Icons.add_rounded,
                size:
                    32 * stateController.getDeviceAppBarMultiplier() as double,
                color: CFGColor.white,
              ),
            ),
          ),
        ),

        //
        body: FutureBuilder<Object>(
            future: loadingFuture,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(
                  left: CFGTheme.bodyLRPadding,
                  right: CFGTheme.bodyLRPadding,
                  // top: CFGTheme.bodyTBPadding,
                  bottom: CFGTheme.bodyTBPadding,
                ),
                child: ListView.builder(
                    // physics: BouncingScrollPhysics(),
                    // padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemCount: recordList?.length ?? 0,
                    itemBuilder: (context, index) {
                      String? clientName;
                      String? farmName;
                      String? cropName;

                      Future<bool> loadRecordData() async {
                        try {
                          clientName = getValueForKey(recordList![index].client,
                              stateController.clientList);
                          farmName = getValueForKey(recordList![index].farm,
                              stateController.farmList);
                          cropName = getValueForKey(recordList![index].crop,
                              stateController.cropList);
                          debugPrint('$clientName');
                          debugPrint('$farmName');
                          debugPrint('$cropName');
                          return true;
                        } catch (e) {
                          debugPrint('Error loading data: $e');
                          return false;
                        }
                      }

                      //Load Data from IDs
                      loadRecordData();

                      return GestureDetector(
                        child: SimpleFormsTileViewCard(
                          dataObject: recordList?[index],
                          onDelete: onDelete,
                          viewRouter:
                              NavRoute.finishedProductWeightCheckHourlyView,
                          updateRouter:
                              NavRoute.finishedProductWeightCheckHourlyUpdate,
                          lastModifiedDate: recordList?[index].updatedAt ??
                              recordList?[index].createdAt ??
                              "",
                          textFieldOneLabel: "Client",
                          textFieldOneData: clientName ?? "",
                          textFieldTwoLabel: "Farm",
                          textFieldTwoData: farmName ?? "",
                          textFieldThreeLabel: "Crop",
                          textFieldThreeData: cropName ?? "",
                          textFieldFourLabel: "Date",
                          textFieldFourData: recordList?[index].date ?? "",
                        ),
                        onTap: () {
                          //open view
                          // Get.to(() => ProductBatchLabelAssessmentView());
                        },
                      );
                    }),
              );
            }),
      ),
    );
  }
}
