import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/org/org_equipment_manufacturer.dart';
import 'package:farm_management/models/table_models/org/org_equipment_manufacturer_model.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';

class EquipmentSupplierMainTileView extends StatefulWidget {
  const EquipmentSupplierMainTileView({super.key});

  @override
  State<EquipmentSupplierMainTileView> createState() =>
      _EquipmentSupplierMainTileViewState();
}

class _EquipmentSupplierMainTileViewState
    extends State<EquipmentSupplierMainTileView> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  List<OrgEquipmentManufacturerModel>? recordList;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      recordList = await OrgEquipmentManufacturer().fetchAllRecords();
      debugPrint(recordList!.isEmpty
          ? "Empty List"
          : "${recordList?[0].equipmentManufacturerId}");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  Future<bool> deleteRecord(OrgEquipmentManufacturerModel dataObject) async {
    try {
      int recordId =
          await OrgEquipmentManufacturer().deleteRecord(model: dataObject);
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
        appBar:
            SimpleFormsAppBar(title: "Equipment Suppliers", isMainTile: true),
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
        //         dynamic result =
        //             await Get.toNamed(NavRoute.equipmentSuppliersAdd);
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
                          viewRouter: NavRoute.equipmentSuppliersView,
                          updateRouter: NavRoute.equipmentSuppliersUpdate,
                          lastModifiedDate: recordList?[index].updatedAt ??
                              recordList?[index].createdAt ??
                              "",
                          textFieldOneLabel: "Equipment Supplier",
                          textFieldOneData: recordList?[index].name ?? "",
                          textFieldTwoLabel: "Contact Number",
                          textFieldTwoData:
                              recordList?[index].phoneMobile ?? "",
                          textFieldThreeLabel: "Email",
                          textFieldThreeData: recordList?[index].email ?? "",
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
