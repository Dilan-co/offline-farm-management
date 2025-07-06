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
import 'package:farm_management/database/tables/simple_forms/equipment_related_forms/equipment_maintenance_log.dart';
import 'package:farm_management/models/table_models/simple_forms/equipment_related_forms/equipment_maintenance_log_model.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_maintenance_log/equipment_maintenance_log_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_signature.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class EquipmentMaintenanceLogAdd extends StatefulWidget {
  final bool isUpdate;
  final EquipmentMaintenanceLogModel? data;
  const EquipmentMaintenanceLogAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<EquipmentMaintenanceLogAdd> createState() =>
      _EquipmentMaintenanceLogAddState();
}

class _EquipmentMaintenanceLogAddState
    extends State<EquipmentMaintenanceLogAdd> {
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
          equipment = widget.data!.equipmentId;
          problem = widget.data!.problem;
          priority = widget.data!.priority;
          dateIdentified = widget.data!.dateIdentified;
          dateMaintenance = widget.data!.dateMaintenance;
          actionTaken = widget.data!.actionTaken;
          externalContractor = widget.data!.externalContractor;
          externalContractorDetails = widget.data!.externalContractorDetails;
          dateCompleted = widget.data!.dateCompleted;
          equipmentCleaned = widget.data!.equipmentCleaned;
          areaReleasedBy = widget.data!.areaReleasedBy;
          correctiveAction = widget.data!.correctiveAction;
          comment = widget.data!.comment;
          fileName = widget.data!.media ?? "";
          signatureName = null;
        });
        //Dropdown initial values
        clientName = getValueForKey(client!, stateController.clientList);
        equipmentName =
            getValueForKey(equipment!, stateController.equipmentNameList);
        debugPrint(clientName);
        debugPrint(equipmentName);
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
  String? equipmentName;

  Uint8List? signatureData;
  //"file" is to be the one to save into DB
  File? file;
  String fileName = "";
  int? client;
  int? equipment;
  String? problem;
  String? priority;
  String? dateIdentified;
  String? dateMaintenance;
  String? actionTaken;
  String? externalContractor;
  String? externalContractorDetails;
  String? dateCompleted;
  String? equipmentCleaned;
  String? areaReleasedBy;
  String? correctiveAction;
  String? comment;
  String? signatureName;

  onChangedDropdownClient(int? output) {
    setState(() {
      client = output;
    });
    debugPrint("$output");
  }

  onChangedDropdownEquipment(int? output) {
    setState(() {
      equipment = output;
    });
    debugPrint("$output");
  }

  onChangedProblem(String output) {
    setState(() {
      problem = output;
    });
    debugPrint(problem);
  }

  onChangedDropdownPriority(int? output) {
    setState(() {
      priority = getValueForKey(output!, stateController.priorityList);
    });
    debugPrint("$output");
  }

  onChangedDateIdentified(String output) {
    setState(() {
      dateIdentified = output;
    });
    debugPrint(dateIdentified);
  }

  onChangedDateMaintenance(String output) {
    setState(() {
      dateMaintenance = output;
    });
    debugPrint(dateMaintenance);
  }

  onChangedActionTaken(String output) {
    setState(() {
      actionTaken = output;
    });
    debugPrint(actionTaken);
  }

  onChangedExternalContractor(String output) {
    setState(() {
      externalContractor = output;
    });
    debugPrint(externalContractor);
  }

  onChangedExternalContractorDetails(String output) {
    setState(() {
      externalContractorDetails = output;
    });
    debugPrint(externalContractorDetails);
  }

  onChangedDateCompleted(String output) {
    setState(() {
      dateCompleted = output;
    });
    debugPrint(dateCompleted);
  }

  onChangedEquipmentCleaned(String output) {
    setState(() {
      equipmentCleaned = output;
    });
    debugPrint(equipmentCleaned);
  }

  onChangedAreaReleasedBy(String output) {
    setState(() {
      areaReleasedBy = output;
    });
    debugPrint(areaReleasedBy);
  }

  onChangedCorrectiveAction(String? output) {
    setState(() {
      correctiveAction = output;
    });
    debugPrint(correctiveAction);
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
      EquipmentMaintenanceLogModel dataModel = EquipmentMaintenanceLogModel(
          equipmentMaintenanceLogId: null,
          equipmentId: equipment!,
          client: client!,
          problem: problem,
          priority: priority,
          dateIdentified: dateIdentified,
          dateMaintenance: dateMaintenance,
          media: fileName == "" ? null : fileName,
          actionTaken: actionTaken,
          externalContractor: externalContractor,
          externalContractorDetails: externalContractorDetails,
          dateCompleted: dateCompleted,
          equipmentCleaned: equipmentCleaned,
          areaReleasedBy: areaReleasedBy,
          correctiveAction: correctiveAction,
          comment: comment,
          createdAt: createdAt, //2024-06-15 11:39:12
          updatedAt: null,
          createdBy: null,
          updatedBy: null,
          createdBySignature: null,
          signature: signatureName,
          deleted: 0,
          isSynced: 0);
      int recordId =
          await EquipmentMaintenanceLog().createRecord(model: dataModel);
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
      EquipmentMaintenanceLogModel dataModel = EquipmentMaintenanceLogModel(
          equipmentMaintenanceLogId: widget.data!.equipmentMaintenanceLogId,
          equipmentId: equipment!,
          client: client!,
          problem: problem,
          priority: priority,
          dateIdentified: dateIdentified,
          dateMaintenance: dateMaintenance,
          media: fileName == "" ? null : fileName,
          actionTaken: actionTaken,
          externalContractor: externalContractor,
          externalContractorDetails: externalContractorDetails,
          dateCompleted: dateCompleted,
          equipmentCleaned: equipmentCleaned,
          areaReleasedBy: areaReleasedBy,
          correctiveAction: correctiveAction,
          comment: comment,
          createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
          updatedAt: updatedAt,
          createdBy: widget.data!.createdBy,
          updatedBy: null,
          createdBySignature: null,
          signature: signatureName,
          deleted: 0,
          isSynced: 0);
      int recordId =
          await EquipmentMaintenanceLog().updateRecord(model: dataModel);
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
        equipment != null &&
        priority != null &&
        dateMaintenance != null) {
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
        Get.to(() => const EquipmentMaintenanceLogMainTileView());
      } else {
        Get.back(result: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: CFGTheme.bgColorScreen,
      drawerEnableOpenDragGesture: false,
      appBar: SimpleFormsAppBar(
          title: "Equipment Maintenance Log", isUpdate: widget.isUpdate),
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
                  dropdownList: stateController.equipmentNameList,
                  label: "Equipment id",
                  dropdownHintText: "Please select an equipment",
                  isRequired: true,
                  initialData: equipmentName,
                  onChangedDropdown: onChangedDropdownEquipment,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Problem",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: problem,
                  onChangedText: onChangedProblem,
                ),

                FormDropdown(
                  isUpdate: widget.isUpdate,
                  dropdownList: stateController.priorityList,
                  label: "Priority",
                  dropdownHintText: "Please select a priority",
                  isRequired: true,
                  initialData: priority,
                  onChangedDropdown: onChangedDropdownPriority,
                ),

                //Priority Info
                Text("PRIORITY",
                    style: TextStyle(
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                      decoration: TextDecoration.underline,
                    )),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      SB(
                        width: mediaQuerySize.width * 0.14,
                        child: Text("CRITICAL",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text("-",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Flexible(
                        child: Text(
                            "Will compromise the safety of product. Stop production and fix immediately.",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.smallFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      SB(
                        width: mediaQuerySize.width * 0.14,
                        child: Text("MAJOR",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text("-",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Flexible(
                        child: Text(
                            "Significant issue that may lead to the safety of the product being compromised. Fix within 2 working days, or sooner if it becomes critical.",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.smallFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      SB(
                        width: mediaQuerySize.width * 0.14,
                        child: Text("MINOR",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text("-",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Flexible(
                        child: Text(
                            "If not repaired may develop into a major issue. Fix within 2 weeks.",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.smallFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      SB(
                        width: mediaQuerySize.width * 0.14,
                        child: Text("LOW",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text("-",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),

                      Flexible(
                        child: Text(
                            "Issue that should be repaired to ensure the ongoing suitability of the equipment or premises. Repair within 3 months.",
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.smallFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.redFontColor,
                            )),
                      ),
                    ],
                  ),
                ),

                const SB(height: 10),

                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Date identified",
                  hintText: "Tap to pick a date",
                  isRequired: false,
                  initialData: dateIdentified,
                  onChangedDate: onChangedDateIdentified,
                ),
                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Date maintenance",
                  hintText: "Tap to pick a date",
                  isRequired: true,
                  initialData: dateMaintenance,
                  onChangedDate: onChangedDateMaintenance,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Action taken",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: actionTaken,
                  onChangedText: onChangedActionTaken,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "External contractor",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: externalContractor,
                  onChangedText: onChangedExternalContractor,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "External contractor details",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: externalContractorDetails,
                  onChangedText: onChangedExternalContractorDetails,
                ),

                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Date completed",
                  hintText: "Tap to pick a date",
                  isRequired: false,
                  initialData: dateCompleted,
                  onChangedDate: onChangedDateCompleted,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Equipment cleaned",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: equipmentCleaned,
                  onChangedText: onChangedEquipmentCleaned,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Area released by",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: areaReleasedBy,
                  onChangedText: onChangedAreaReleasedBy,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Corrective action",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: correctiveAction,
                  onChangedText: onChangedCorrectiveAction,
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
