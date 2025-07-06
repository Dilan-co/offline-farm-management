import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check_model.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/packaging_tare_weight_check/packaging_tare_weight_check_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_signature.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:farm_management/widgets/form_toggle_switch_button.dart';
import 'package:permission_handler/permission_handler.dart';

class PackagingTareWeightCheckAdd extends StatefulWidget {
  final bool isUpdate;
  final PackagingTareWeightCheckModel? data;
  const PackagingTareWeightCheckAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<PackagingTareWeightCheckAdd> createState() =>
      _PackagingTareWeightCheckAddState();
}

class _PackagingTareWeightCheckAddState
    extends State<PackagingTareWeightCheckAdd> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecordData();
    });
  }

  Future<bool> loadRecordData() async {
    if (widget.data != null) {
      try {
        setState(() {
          client = widget.data!.client;
          farm = widget.data!.farm;
          crop = widget.data!.crop;
          packagingFormat = widget.data!.packagingFormat;
          grossWeightOfFinishedProduct =
              widget.data!.grossWeightOfFinishedProduct;
          weightOfOuterPackaging = widget.data!.weightOfOuterPackaging;
          weightOfLiner = widget.data!.weightOfLiner;
          weightOfPrimaryPackaging = widget.data!.weightOfPrimaryPackaging;
          totalWeightOfPackaging = widget.data!.totalWeightOfPackaging;
          netWeightOfProduct = widget.data!.netWeightOfProduct;
          weightClaimedOnLabelOrPackaging =
              widget.data!.weightClaimedOnLabelOrPackaging;
          checkWeightAgain = widget.data!.checkWeightAgain;
          comment = widget.data!.comment;
          signatureName = null;
        });
        //Dropdown initial values
        clientName = getValueForKey(client!, stateController.clientList);
        farmName = getValueForKey(farm!, stateController.farmList);
        cropName = getValueForKey(crop!, stateController.cropList);
        debugPrint(clientName);
        debugPrint(farmName);
        debugPrint(cropName);
        return true;
      } catch (e) {
        debugPrint('Error loading data: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  //For initialData
  String? clientName;
  String? farmName;
  String? cropName;

  Uint8List? signatureData;

  int? client;
  int? farm;
  int? crop;
  String? packagingFormat;
  String? grossWeightOfFinishedProduct;
  String? weightOfOuterPackaging;
  String? weightOfLiner;
  String? weightOfPrimaryPackaging;
  String? totalWeightOfPackaging;
  String? netWeightOfProduct;
  String? weightClaimedOnLabelOrPackaging;
  int? checkWeightAgain;
  String? comment;
  String? signatureName;

  onChangedDropdownClient(int? output) {
    setState(() {
      client = output;
    });
    debugPrint("$output");
  }

  onChangedDropdownFarm(int? output) {
    setState(() {
      farm = output;
    });
    debugPrint("$output");
  }

  onChangedDropdownCrop(int? output) {
    setState(() {
      crop = output;
    });
    debugPrint("$output");
  }

  onChangedPackagingFormat(String? output) {
    setState(() {
      packagingFormat = output;
    });
    debugPrint(packagingFormat);
  }

  onChangedGrossWeightOfFinishedProduct(String? output) {
    setState(() {
      grossWeightOfFinishedProduct = output;
    });
    debugPrint(grossWeightOfFinishedProduct);
  }

  onChangedWeightOfOuterPackaging(String? output) {
    setState(() {
      weightOfOuterPackaging = output;
    });
    debugPrint(weightOfOuterPackaging);
  }

  onChangedWeightOfLiner(String? output) {
    setState(() {
      weightOfLiner = output;
    });
    debugPrint(weightOfLiner);
  }

  onChangedWeightOfPrimaryPackaging(String? output) {
    setState(() {
      weightOfPrimaryPackaging = output;
    });
    debugPrint(weightOfPrimaryPackaging);
  }

  onChangedTotalWeightOfPackaging(String? output) {
    setState(() {
      totalWeightOfPackaging = output;
    });
    debugPrint(totalWeightOfPackaging);
  }

  onChangedNetWeightOfProduct(String? output) {
    setState(() {
      netWeightOfProduct = output;
    });
    debugPrint(netWeightOfProduct);
  }

  onChangedWeightClaimedOnLabelOrPackaging(String? output) {
    setState(() {
      weightClaimedOnLabelOrPackaging = output;
    });
    debugPrint(weightClaimedOnLabelOrPackaging);
  }

  onChangedCheckWeightAgain(bool? output) {
    setState(() {
      if (output == true) {
        checkWeightAgain = 1;
      } else {
        checkWeightAgain = 0;
      }
    });
    debugPrint("$checkWeightAgain");
  }

  onChangedComment(String? output) {
    setState(() {
      comment = output;
    });
    debugPrint(comment);
  }

  onChangedSignature(Uint8List? output) {
    setState(() {
      signatureData = output;
    });
    debugPrint("$output");
  }

  //Save Signature as a PNG
  Future<String?> saveSignatureImageToStorage(Uint8List? signatureData) async {
    if (signatureData != null) {
      try {
        DateTime today = DateTime.now();
        String signatureFileName =
            "${today.year}${today.month}${today.day}${today.hour}${today.minute}${today.second}.png";
        String signatureSubfolderPath =
            '${stateController.getDocumentsDirectoryPath()}/${CFGString().signatureSubfolderName}';
        String filePath = '$signatureSubfolderPath/$signatureFileName';

        await File(filePath).writeAsBytes(signatureData);

        debugPrint('Signature saved to local storage: $filePath');
        return signatureFileName;
      } catch (e) {
        debugPrint('Error saving signature: $e');
        return null;
      }
    }
    return null;
  }

  Future<int> createRecord() async {
    try {
      DateTime now = DateTime.now();
      String createdAt =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      PackagingTareWeightCheckModel dataModel = PackagingTareWeightCheckModel(
          packagingTareWeightCheckId: null,
          client: client!,
          farm: farm!,
          crop: crop!,
          packagingFormat: packagingFormat!,
          grossWeightOfFinishedProduct: grossWeightOfFinishedProduct!,
          weightOfOuterPackaging: weightOfOuterPackaging,
          weightOfLiner: weightOfLiner,
          weightOfPrimaryPackaging: weightOfPrimaryPackaging,
          totalWeightOfPackaging: totalWeightOfPackaging!,
          netWeightOfProduct: netWeightOfProduct!,
          weightClaimedOnLabelOrPackaging: weightClaimedOnLabelOrPackaging,
          checkWeightAgain: checkWeightAgain ?? 0,
          comment: comment,
          userId: null,
          createdAt: createdAt, //2024-06-15 11:39:12
          updatedAt: null,
          createdBy: null,
          updatedBy: null,
          signature: signatureName,
          isSynced: 0);
      int recordId =
          await PackagingTareWeightCheck().createRecord(model: dataModel);
      debugPrint("------- Record ID -------");
      debugPrint("$recordId");
      return recordId;
    } catch (error) {
      debugPrint('Error creating record: $error');
      // Return an appropriate value or rethrow the exception if needed
      rethrow;
    }
  }

  Future<int> updateRecord() async {
    //Remember to add Bind ID to update the record. Don't keep it "null"
    try {
      DateTime now = DateTime.now();
      String updatedAt =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      PackagingTareWeightCheckModel dataModel = PackagingTareWeightCheckModel(
          packagingTareWeightCheckId: widget.data!.packagingTareWeightCheckId,
          client: client!,
          farm: farm!,
          crop: crop!,
          packagingFormat: packagingFormat!,
          grossWeightOfFinishedProduct: grossWeightOfFinishedProduct!,
          weightOfOuterPackaging: weightOfOuterPackaging,
          weightOfLiner: weightOfLiner,
          weightOfPrimaryPackaging: weightOfPrimaryPackaging,
          totalWeightOfPackaging: totalWeightOfPackaging!,
          netWeightOfProduct: netWeightOfProduct!,
          weightClaimedOnLabelOrPackaging: weightClaimedOnLabelOrPackaging,
          checkWeightAgain: checkWeightAgain ?? 0,
          comment: comment,
          userId: null,
          createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
          updatedAt: updatedAt,
          createdBy: widget.data!.createdBy,
          updatedBy: null,
          signature: signatureName,
          isSynced: 0);
      int recordId =
          await PackagingTareWeightCheck().updateRecord(model: dataModel);
      debugPrint("------- Record ID -------");
      debugPrint("$recordId");
      return recordId;
    } catch (error) {
      debugPrint('Error updating record: $error');
      // Return an appropriate value or rethrow the exception if needed
      rethrow;
    }
  }

  //Saving Form Data
  onSave() async {
    //Check if required fields are filled to "Save" Form.
    if (client != null &&
        farm != null &&
        crop != null &&
        packagingFormat != null &&
        grossWeightOfFinishedProduct != null &&
        totalWeightOfPackaging != null &&
        netWeightOfProduct != null) {
      await requestPermission(Permission.storage);
      signatureName = await saveSignatureImageToStorage(signatureData);
      //Add save Form data to DB here
      if (widget.isUpdate == true) {
        if (widget.data != null) {
          await updateRecord();
        }
      } else {
        await createRecord();
      }

      //Dismiss Keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      if (widget.isUpdate) {
        Get.close(2);
        Get.to(() => const PackagingTareWeightCheckMainTileView());
      } else {
        Get.back(result: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: CFGTheme.bgColorScreen,
      drawerEnableOpenDragGesture: false,
      appBar: SimpleFormsAppBar(
          title: "Packaging Tare Weight Check", isUpdate: widget.isUpdate),
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
              child: ListView(children: [
                //
                FormDropdown(
                  isUpdate: widget.isUpdate,
                  dropdownList: stateController.clientList,
                  label: "Client",
                  dropdownHintText: "Please select a client",
                  isRequired: true,
                  initialData: clientName,
                  onChangedDropdown: onChangedDropdownClient,
                ),
                FormDropdown(
                  isUpdate: widget.isUpdate,
                  dropdownList: stateController.farmList,
                  label: "Farm",
                  dropdownHintText: "Please select a farm",
                  isRequired: true,
                  initialData: farmName,
                  onChangedDropdown: onChangedDropdownFarm,
                ),
                FormDropdown(
                  isUpdate: widget.isUpdate,
                  dropdownList: stateController.cropList,
                  label: "Crop",
                  dropdownHintText: "Please select a crop",
                  isRequired: true,
                  initialData: cropName,
                  onChangedDropdown: onChangedDropdownCrop,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Packaging format",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: packagingFormat,
                  onChangedText: onChangedPackagingFormat,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Gross weight of finished product",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: grossWeightOfFinishedProduct,
                  onChangedText: onChangedGrossWeightOfFinishedProduct,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Weight of outer packaging",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: weightOfOuterPackaging,
                  onChangedText: onChangedWeightOfOuterPackaging,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Weight of liner",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: weightOfLiner,
                  onChangedText: onChangedWeightOfLiner,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Weight of primary packaging",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: weightOfPrimaryPackaging,
                  onChangedText: onChangedWeightOfPrimaryPackaging,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Total weight of packaging",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: totalWeightOfPackaging,
                  onChangedText: onChangedTotalWeightOfPackaging,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Net weight of product",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: netWeightOfProduct,
                  onChangedText: onChangedNetWeightOfProduct,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Weight claimed on label or packaging",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: weightClaimedOnLabelOrPackaging,
                  onChangedText: onChangedWeightClaimedOnLabelOrPackaging,
                ),

                //toggle button
                FormToggleSwitchButton(
                  label: "Check weight again",
                  initialSwitchValue: checkWeightAgain,
                  onChangedSwitch: onChangedCheckWeightAgain,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Comment",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: comment,
                  onChangedText: onChangedComment,
                ),

                //Add Signature widget here
                FormSignature(onChangedSignaturePngData: onChangedSignature),

                Container(
                  color: CFGTheme.bgColorScreen,
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Cancel Button
                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(130, 44)),
                          backgroundColor:
                              WidgetStatePropertyAll(CFGColor.lightGrey),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      CFGTheme.buttonRadius))),
                        ),
                        onPressed: () {
                          //Dismiss Keyboard
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.back(result: true);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                              height: 0,
                              fontSize: CFGFont.subTitleFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),

                      //Save Button
                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(130, 44)),
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.button),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      CFGTheme.buttonRadius))),
                        ),
                        onPressed: () async {
                          await onSave();
                        },
                        child: Text("Save",
                            style: TextStyle(
                              height: 0,
                              fontSize: CFGFont.subTitleFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.whiteFontColor,
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }),
    ));
  }
}
