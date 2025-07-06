import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/org/org_equipment.dart';
import 'package:farm_management/models/table_models/org/org_equipment_model.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class EquipmentListMainTileView extends StatefulWidget {
  const EquipmentListMainTileView({super.key});

  @override
  State<EquipmentListMainTileView> createState() =>
      _EquipmentListMainTileViewState();
}

class _EquipmentListMainTileViewState extends State<EquipmentListMainTileView> {
  final StateController stateController = Get.find();

  late Future<bool> loadingFuture;
  List<OrgEquipmentModel>? recordList;

  //"file" is to be the one to save into DB
  File? file;
  String fileName = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      recordList = await OrgEquipment()
          .fetchAllReadOnlyOrNotRecords(isReadOnlyRecords: false);
      debugPrint(
          recordList!.isEmpty ? "Empty List" : "${recordList?[0].equipmentId}");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  Future<bool> deleteRecord(OrgEquipmentModel dataObject) async {
    try {
      int recordId = await OrgEquipment().deleteRecord(model: dataObject);
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

  //Save Files
  Future<bool> saveFileToDocuments(String filePath) async {
    try {
      // Construct the destination path
      String destinationPath =
          '${stateController.getDocumentsDirectoryPath()}/${basename(filePath)}';

      // Copy the selected image to the documents directory
      await File(filePath).copy(destinationPath);

      debugPrint('File saved to documents directory: $destinationPath');
      return true;
    } catch (e) {
      debugPrint('Error saving file: $e');
      return false;
    }
  }

  //Saving CSV File
  onUpload() async {
    if (file != null) {
      await requestPermission(Permission.storage);
      await saveFileToDocuments(file!.path);
      //Add save File data to DB here
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(title: "Equipment List", isMainTile: true),
        //
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //
            // Padding(
            //   padding: EdgeInsets.only(
            //       bottom: 20, right: CFGTheme.bodyLRPadding - 15),
            //   child: SB(
            //     width:
            //         60 * stateController.getDeviceAppBarMultiplier() as double,
            //     height:
            //         60 * stateController.getDeviceAppBarMultiplier() as double,
            //     child: FloatingActionButton(
            //       //Give unique hero tag to avoid runtime errors
            //       heroTag: "hero1",
            //       onPressed: () {
            //         //Reset File & fileName
            //         file = File('');
            //         fileName = "";

            //         showDialog(
            //           barrierDismissible: false,
            //           useSafeArea: true,
            //           context: context,
            //           builder: (BuildContext context) {
            //             //StatefulBuilder to update text inside AlertDialog
            //             return StatefulBuilder(builder: (context, setState) {
            //               return AlertDialog(
            //                 surfaceTintColor: CFGTheme.bgColorScreen,
            //                 backgroundColor: CFGTheme.bgColorScreen,
            //                 insetPadding: EdgeInsets.only(
            //                   left: CFGTheme.bodyLRPadding,
            //                   right: CFGTheme.bodyLRPadding,
            //                 ),
            //                 title: Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     //
            //                     Text('Upload CSV File',
            //                         softWrap: true,
            //                         style: TextStyle(
            //                           overflow: TextOverflow.clip,
            //                           fontSize: CFGFont.smallTitleFontSize,
            //                           fontWeight: CFGFont.mediumFontWeight,
            //                           color: CFGFont.defaultFontColor,
            //                         )),

            //                     //
            //                     Builder(builder: (context) {
            //                       return IconButton.filled(
            //                           style: ButtonStyle(
            //                             overlayColor: WidgetStatePropertyAll(
            //                                 CFGTheme.buttonOverlay),
            //                             backgroundColor: WidgetStatePropertyAll(
            //                                 CFGTheme.button),
            //                             // iconColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
            //                           ),
            //                           onPressed: () {
            //                             Get.back();
            //                           },
            //                           icon: Icon(
            //                             Icons.close_rounded,
            //                             color: CFGTheme.appBarButtonImg,
            //                             size: 24,
            //                           ));
            //                     }),
            //                   ],
            //                 ),
            //                 content: Container(
            //                   color: CFGTheme.bgColorScreen,
            //                   width: mediaQuerySize.width,
            //                   height: 120,
            //                   child: Column(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceAround,
            //                     children: [
            //                       //
            //                       Center(
            //                         child: Text(fileName,
            //                             style: TextStyle(
            //                               fontSize: CFGFont.defaultFontSize,
            //                               fontWeight: CFGFont.regularFontWeight,
            //                               color: CFGFont.defaultFontColor,
            //                             )),
            //                       ),

            //                       //Select File Button
            //                       TextButton(
            //                         style: ButtonStyle(
            //                           fixedSize: const WidgetStatePropertyAll(
            //                               Size(130, 44)),
            //                           backgroundColor: WidgetStatePropertyAll(
            //                               CFGTheme.logoColorsGreen),
            //                           overlayColor: WidgetStatePropertyAll(
            //                               CFGTheme.buttonOverlay),
            //                           shape: WidgetStatePropertyAll(
            //                               RoundedRectangleBorder(
            //                                   borderRadius:
            //                                       BorderRadius.circular(
            //                                           CFGTheme.buttonRadius))),
            //                         ),
            //                         onPressed: () async {
            //                           //storage permission check & request
            //                           await requestPermission(
            //                               Permission.storage);

            //                           //open file explorer
            //                           FilePickerResult? result =
            //                               await FilePicker.platform.pickFiles(
            //                             type: FileType.any,
            //                           );

            //                           if (result != null) {
            //                             setState(() {
            //                               file = File(result.files.single.path
            //                                   .toString());
            //                               fileName = result.files.first.name;
            //                             });
            //                             debugPrint(fileName);
            //                           } else {
            //                             // User canceled the picker
            //                           }
            //                         },
            //                         child: Text("Select File",
            //                             style: TextStyle(
            //                               fontSize: CFGFont.subTitleFontSize,
            //                               fontWeight: CFGFont.regularFontWeight,
            //                               color: CFGFont.whiteFontColor,
            //                             )),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 actionsAlignment: MainAxisAlignment.spaceAround,
            //                 actions: <Widget>[
            //                   //Upload Button
            //                   TextButton(
            //                     style: ButtonStyle(
            //                       fixedSize: const WidgetStatePropertyAll(
            //                           Size(130, 44)),
            //                       backgroundColor:
            //                           WidgetStatePropertyAll(CFGTheme.button),
            //                       overlayColor: WidgetStatePropertyAll(
            //                           CFGTheme.buttonOverlay),
            //                       shape: WidgetStatePropertyAll(
            //                           RoundedRectangleBorder(
            //                               borderRadius: BorderRadius.circular(
            //                                   CFGTheme.buttonRadius))),
            //                     ),
            //                     onPressed: () async {
            //                       //Saving Selected File
            //                       await onUpload();
            //                       Get.back();
            //                     },
            //                     child: Text("Upload",
            //                         style: TextStyle(
            //                           height: 0,
            //                           fontSize: CFGFont.subTitleFontSize,
            //                           fontWeight: CFGFont.regularFontWeight,
            //                           color: CFGFont.whiteFontColor,
            //                         )),
            //                   ),
            //                 ],
            //               );
            //             });
            //           },
            //         );
            //       },
            //       backgroundColor: CFGTheme.logoColorsGreen,
            //       hoverColor: CFGTheme.buttonOverlay,
            //       shape: const CircleBorder(),
            //       child: Icon(
            //         Icons.post_add_rounded,
            //         size: 32,
            //         color: CFGColor.white,
            //       ),
            //     ),
            //   ),
            // ),

            //
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20, right: CFGTheme.bodyLRPadding - 15),
              child: SB(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  //Give unique hero tag to avoid runtime errors
                  heroTag: "hero2",
                  onPressed: () async {
                    dynamic result =
                        await Get.toNamed(NavRoute.equipmentListAdd);
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
                    size: 32 * stateController.getDeviceAppBarMultiplier()
                        as double,
                    color: CFGColor.white,
                  ),
                ),
              ),
            ),
          ],
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
                      String? equipmentManufacturerName;
                      String? assetType;

                      Future<bool> loadRecordData() async {
                        try {
                          clientName = getValueForKey(recordList![index].client,
                              stateController.clientList);
                          equipmentManufacturerName = getValueForKey(
                              recordList![index].equipmentManufacturerId,
                              stateController.equipmentManufacturerNameList);
                          assetType = getValueForKey(
                              recordList![index].equipmentTypeId,
                              stateController.assetTypeList);
                          debugPrint('$clientName');
                          debugPrint('$equipmentManufacturerName');
                          debugPrint('$assetType');
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
                          viewRouter: NavRoute.equipmentListView,
                          updateRouter: NavRoute.equipmentListUpdate,
                          lastModifiedDate: recordList?[index].updatedAt ??
                              recordList?[index].createdAt ??
                              "",
                          textFieldOneLabel: "Client",
                          textFieldOneData: clientName ?? "",
                          textFieldTwoLabel: "Asset Type",
                          textFieldTwoData: assetType ?? "",
                          textFieldThreeLabel: "Equipment Supplier",
                          textFieldThreeData: equipmentManufacturerName ?? "",
                          textFieldFourLabel: "Asset Name",
                          textFieldFourData: recordList?[index].name ?? "",
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
