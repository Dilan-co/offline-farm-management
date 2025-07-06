import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/org/org_equipment.dart';
import 'package:farm_management/models/table_models/org/org_equipment_model.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_list/equipment_list_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_signature.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:farm_management/widgets/form_toggle_switch_button.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class EquipmentListAdd extends StatefulWidget {
  final bool isUpdate;
  final OrgEquipmentModel? data;
  const EquipmentListAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<EquipmentListAdd> createState() => _EquipmentListAddState();
}

class _EquipmentListAddState extends State<EquipmentListAdd> {
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
          assetType = widget.data!.equipmentTypeId;
          equipmentManufacturer = widget.data!.equipmentManufacturerId;
          model = widget.data!.model;
          serialNumber = widget.data!.serialNumber;
          assetName = widget.data!.name;
          label = widget.data!.label;
          description = widget.data!.description;
          manufactureYear = widget.data!.manufactureYear;
          dateOfPurchase = widget.data!.dateOfPurchase;
          personResponsible = widget.data!.personResponsible;
          status = widget.data!.status;
          comment = widget.data!.comment;
          fileName = widget.data!.media ?? "";
          signatureName = null;
        });
        //Dropdown initial values
        clientName = getValueForKey(client!, stateController.clientList);
        assetTypeName =
            getValueForKey(assetType!, stateController.assetTypeList);
        equipmentManufacturerName = getValueForKey(equipmentManufacturer!,
            stateController.equipmentManufacturerNameList);
        debugPrint(clientName);
        debugPrint(assetTypeName);
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
  String? assetTypeName;
  String? equipmentManufacturerName;

  Uint8List? signatureData;
  //"file" is to be the one to save into DB
  File? file;
  String fileName = "";
  int? client;
  int? assetType;
  int? equipmentManufacturer;
  String? model;
  String? serialNumber;
  String? assetName;
  String? label;
  String? description;
  String? manufactureYear;
  String? dateOfPurchase;
  String? personResponsible;
  int? status;
  String? comment;
  String? signatureName;

  onChangedDropdownClient(int? output) {
    setState(() {
      client = output;
    });
    debugPrint("$output");
  }

  onChangedDropdownAssetType(int? output) {
    setState(() {
      assetType = output;
    });
    debugPrint("$output");
  }

  onChangedDropdownEquipmentManufacturer(int? output) {
    setState(() {
      equipmentManufacturer = output;
    });
    debugPrint("$output");
  }

  onChangedModel(String output) {
    setState(() {
      model = output;
    });
    debugPrint(model);
  }

  onChangedSerialNumber(String output) {
    setState(() {
      serialNumber = output;
    });
    debugPrint(serialNumber);
  }

  onChangedAssetName(String output) {
    setState(() {
      assetName = output;
    });
    debugPrint(assetName);
  }

  onChangedLabel(String output) {
    setState(() {
      label = output;
    });
    debugPrint(label);
  }

  onChangedDescription(String output) {
    setState(() {
      description = output;
    });
    debugPrint(description);
  }

  onChangedManufactureYear(String output) {
    setState(() {
      manufactureYear = output;
    });
    debugPrint(manufactureYear);
  }

  onChangedDateOfPurchase(String output) {
    setState(() {
      dateOfPurchase = output;
    });
    debugPrint(dateOfPurchase);
  }

  onChangedPersonResponsible(String output) {
    setState(() {
      personResponsible = output;
    });
    debugPrint(personResponsible);
  }

  onChangedStatus(bool? output) {
    setState(() {
      if (output == true) {
        status = 1;
      } else {
        status = 0;
      }
    });
    debugPrint("$status");
  }

  onChangedComment(String? output) {
    setState(() {
      comment = output;
    });
    debugPrint(comment);
  }

  //Save Files
  Future<bool> saveImageToDocuments(String imagePath) async {
    try {
      // Construct the destination path
      String destinationPath =
          '${stateController.getDocumentsDirectoryPath()}/${basename(imagePath)}';

      // Copy the selected image to the documents directory
      await File(imagePath).copy(destinationPath);

      debugPrint('Image saved to documents directory: $destinationPath');
      return true;
    } catch (e) {
      debugPrint('Error saving image: $e');
      return false;
    }
  }

  saveMedia() async {
    if (file != null) {
      await saveImageToDocuments(file!.path);
    }
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
      OrgEquipmentModel dataModel = OrgEquipmentModel(
          equipmentId: null,
          client: client!,
          equipmentTypeId: assetType!,
          equipmentManufacturerId: equipmentManufacturer!,
          model: model,
          serialNumber: serialNumber,
          name: assetName!,
          label: label!,
          description: description,
          manufactureYear: manufactureYear,
          dateOfPurchase: dateOfPurchase,
          personResponsible: personResponsible,
          media: fileName == "" ? null : fileName,
          status: status ?? 0,
          comment: comment,
          createdAt: createdAt, //2024-06-15 11:39:12
          updatedAt: null,
          createdBy: null,
          updatedBy: null,
          createdBySignature: null,
          signature: signatureName,
          deleted: 0,
          isSynced: 0,
          readOnly: 0);
      int recordId = await OrgEquipment().createRecord(model: dataModel);
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
      OrgEquipmentModel dataModel = OrgEquipmentModel(
          equipmentId: widget.data!.equipmentId,
          client: client!,
          equipmentTypeId: assetType!,
          equipmentManufacturerId: equipmentManufacturer!,
          model: model,
          serialNumber: serialNumber,
          name: assetName!,
          label: label!,
          description: description,
          manufactureYear: manufactureYear,
          dateOfPurchase: dateOfPurchase,
          personResponsible: personResponsible,
          media: fileName == "" ? null : fileName,
          status: status ?? 0,
          comment: comment,
          createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
          updatedAt: updatedAt,
          createdBy: widget.data!.createdBy,
          updatedBy: null,
          createdBySignature: null,
          signature: signatureName,
          deleted: 0,
          isSynced: 0,
          readOnly: 0);
      int recordId = await OrgEquipment().updateRecord(model: dataModel);
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
        assetType != null &&
        equipmentManufacturer != null &&
        assetName != null &&
        label != null) {
      await requestPermission(Permission.storage);
      await saveMedia();
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
        Get.to(() => const EquipmentListMainTileView());
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
      appBar: SimpleFormsAppBar(title: "Equipment", isUpdate: widget.isUpdate),
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
                  dropdownList: stateController.assetTypeList,
                  label: "Asset type id",
                  dropdownHintText: "Please select a type",
                  isRequired: true,
                  initialData: assetTypeName,
                  onChangedDropdown: onChangedDropdownAssetType,
                ),
                FormDropdown(
                  isUpdate: widget.isUpdate,
                  dropdownList: stateController.equipmentManufacturerNameList,
                  label: "Equipment manufacturer id",
                  dropdownHintText: "Please select a manufacturer",
                  isRequired: true,
                  initialData: equipmentManufacturerName,
                  onChangedDropdown: onChangedDropdownEquipmentManufacturer,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Model",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: model,
                  onChangedText: onChangedModel,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Serial number",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: serialNumber,
                  onChangedText: onChangedSerialNumber,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Asset name",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: assetName,
                  onChangedText: onChangedAssetName,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Label",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: label,
                  onChangedText: onChangedLabel,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Description",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: description,
                  onChangedText: onChangedDescription,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Manufacture year",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: manufactureYear,
                  onChangedText: onChangedManufactureYear,
                ),

                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Date of purchase",
                  hintText: "Tap to pick a date",
                  isRequired: false,
                  initialData: dateOfPurchase,
                  onChangedDate: onChangedDateOfPurchase,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Person responsible",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: personResponsible,
                  onChangedText: onChangedPersonResponsible,
                ),

                //toggle button
                FormToggleSwitchButton(
                  label: "Status",
                  trueLabel: "Active",
                  falseLabel: "Inactive",
                  initialSwitchValue: status,
                  onChangedSwitch: onChangedStatus,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Comment",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: comment,
                  onChangedText: onChangedComment,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    children: [
                      //
                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(140, 38)),
                          minimumSize:
                              const WidgetStatePropertyAll(Size(140, 38)),
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.button),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  CFGTheme.buttonRadius))),
                          // padding: const WidgetStatePropertyAll(
                          //     EdgeInsets.only(left: 40, right: 40)),
                        ),
                        onPressed: () async {
                          //storage permission check & request
                          await requestPermission(Permission.storage);

                          //open file explorer
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.any,
                          );

                          if (result != null) {
                            setState(() {
                              file = File(result.files.single.path.toString());
                              fileName = result.files.first.name;
                            });
                            debugPrint(fileName);
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Text("Media",
                            style: TextStyle(
                              height: 0,
                              letterSpacing: 0.5,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.whiteFontColor,
                            )),
                      ),

                      // const SB(width: 20),

                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 1,
                            color: CFGColor.lightGrey,
                          ))),
                          child: Text(
                            fileName,
                            style: TextStyle(
                              letterSpacing: 0.5,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.defaultFontColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
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
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
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
