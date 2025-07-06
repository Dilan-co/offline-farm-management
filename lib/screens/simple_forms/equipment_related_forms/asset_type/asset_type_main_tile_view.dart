import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/org/org_equipment_type.dart';
import 'package:farm_management/models/table_models/org/org_equipment_type_model.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';

class AssetTypeMainTileView extends StatefulWidget {
  const AssetTypeMainTileView({super.key});

  @override
  State<AssetTypeMainTileView> createState() => _AssetTypeMainTileViewState();
}

class _AssetTypeMainTileViewState extends State<AssetTypeMainTileView> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  List<OrgEquipmentTypeModel>? recordList;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      recordList = await OrgEquipmentType().fetchAllRecords();
      debugPrint(recordList!.isEmpty ? "Empty List" : "${recordList?[0].name}");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  Future<bool> deleteRecord(OrgEquipmentTypeModel dataObject) async {
    try {
      int recordId = await OrgEquipmentType().deleteRecord(model: dataObject);
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
        appBar: SimpleFormsAppBar(title: "Asset Type", isMainTile: true),
        //
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: Padding(
        //   padding:
        //       EdgeInsets.only(bottom: 20, right: CFGTheme.bodyLRPadding - 15),
        //   child: SB(
        //     width: 60 * stateController.getDeviceAppBarMultiplier() as double,
        //     height: 60 * stateController.getDeviceAppBarMultiplier() as double,
        //     child: FloatingActionButton(
        //       onPressed: () async {
        //         dynamic result = await Get.toNamed(NavRoute.assetTypesAdd);
        //         if (result == true) {
        //           // The route was popped with a true value
        //           setState(() {
        //             loadingFuture = loadRecords();
        //           });
        //         }
        //       },
        //       backgroundColor: CFGTheme.button,
        //       hoverColor: CFGTheme.buttonOverlay,
        //       shape: const CircleBorder(),
        //       child: Icon(
        //         Icons.add_rounded,
        //         size:
        //             32 * stateController.getDeviceAppBarMultiplier() as double,
        //         color: CFGColor.white,
        //       ),
        //     ),
        //   ),
        // ),

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
                      return GestureDetector(
                        child: SimpleFormsTileViewCard(
                          editButtonHidden: true,
                          deleteButtonHidden: true,
                          dataObject: recordList?[index],
                          onDelete: onDelete,
                          viewRouter: NavRoute.assetTypesView,
                          updateRouter: NavRoute.assetTypesUpdate,
                          lastModifiedDate: "",
                          lastModifiedDateHidden: true,
                          textFieldOneLabel: "Asset Type",
                          textFieldOneData: recordList?[index].name ?? "",
                          textFieldTwoLabel: "Status",
                          textFieldTwoData: recordList?[index].status == 1
                              ? "Active"
                              : "Inactive",
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
