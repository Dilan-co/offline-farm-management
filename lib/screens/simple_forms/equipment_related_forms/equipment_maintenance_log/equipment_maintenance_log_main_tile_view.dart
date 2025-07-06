import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/equipment_related_forms/equipment_maintenance_log.dart';
import 'package:farm_management/models/table_models/simple_forms/equipment_related_forms/equipment_maintenance_log_model.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';

class EquipmentMaintenanceLogMainTileView extends StatefulWidget {
  const EquipmentMaintenanceLogMainTileView({super.key});

  @override
  State<EquipmentMaintenanceLogMainTileView> createState() =>
      _EquipmentMaintenanceLogMainTileViewState();
}

class _EquipmentMaintenanceLogMainTileViewState
    extends State<EquipmentMaintenanceLogMainTileView> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  List<EquipmentMaintenanceLogModel>? recordList;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      recordList = await EquipmentMaintenanceLog().fetchAllRecords();
      debugPrint(recordList!.isEmpty
          ? "Empty List"
          : "${recordList?[0].equipmentMaintenanceLogId}");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  Future<bool> deleteRecord(EquipmentMaintenanceLogModel dataObject) async {
    try {
      int recordId =
          await EquipmentMaintenanceLog().deleteRecord(model: dataObject);
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
            title: "Equipment Maintenance Log", isMainTile: true),
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
                dynamic result =
                    await Get.toNamed(NavRoute.equipmentMaintenanceLogAdd);
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
                      String? equipmentName;

                      Future<bool> loadRecordData() async {
                        try {
                          clientName = getValueForKey(recordList![index].client,
                              stateController.clientList);
                          equipmentName = getValueForKey(
                              recordList![index].equipmentId,
                              stateController.equipmentNameList);
                          debugPrint('$clientName');
                          debugPrint('$equipmentName');
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
                          viewRouter: NavRoute.equipmentMaintenanceLogView,
                          updateRouter: NavRoute.equipmentMaintenanceLogUpdate,
                          lastModifiedDate: recordList?[index].updatedAt ??
                              recordList?[index].createdAt ??
                              "",
                          textFieldOneLabel: "Client",
                          textFieldOneData: clientName ?? "",
                          textFieldTwoLabel: "Equipment ID",
                          textFieldTwoData: equipmentName ?? "",
                          textFieldThreeLabel: "Priority",
                          textFieldThreeData: recordList?[index].priority ?? "",
                          textFieldFourLabel: "Date Maintenance",
                          textFieldFourData:
                              recordList?[index].dateMaintenance ?? "",
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
