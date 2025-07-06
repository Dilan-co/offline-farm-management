import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment_model.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/harvest_risk_assessment/harvest_risk_assessment_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_signature.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:farm_management/widgets/form_toggle_switch_button.dart';
import 'package:permission_handler/permission_handler.dart';

class HarvestRiskAssessmentAdd extends StatefulWidget {
  final bool isUpdate;
  final HarvestRiskAssessmentModel? data;
  const HarvestRiskAssessmentAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<HarvestRiskAssessmentAdd> createState() =>
      _HarvestRiskAssessmentAddState();
}

class _HarvestRiskAssessmentAddState extends State<HarvestRiskAssessmentAdd> {
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
          harvestDate = widget.data!.harvestDate;
          lastSprayDate = widget.data!.lastSprayDateTime;
          safeDateToHarvest = widget.data!.safeDateToHarvest;
          blockRange = widget.data!.blockRange;
          sprayedWith = widget.data!.sprayedWith;
          harvestAuthorizedBy = widget.data!.harvestAuthorizedBy;
          comment = widget.data!.comment;
          withholdPeriodObserved = widget.data!.withholdPeriodApplied;
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
  String? harvestDate;
  String? lastSprayDate;
  String? safeDateToHarvest;
  String? blockRange;
  String? sprayedWith;
  String? harvestAuthorizedBy;
  String? comment;
  String? withholdPeriodObserved;
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

  onChangedHarvestDate(String? output) {
    setState(() {
      harvestDate = output;
    });
    debugPrint(harvestDate);
  }

  onChangedLastSprayDate(String? output) {
    setState(() {
      lastSprayDate = output;
    });
    debugPrint(lastSprayDate);
  }

  onChangedSafeDateToHarvest(String? output) {
    setState(() {
      safeDateToHarvest = output;
    });
    debugPrint(safeDateToHarvest);
  }

  onChangedBlockRange(String? output) {
    setState(() {
      blockRange = output;
    });
    debugPrint(blockRange);
  }

  onChangedSprayedWith(String? output) {
    setState(() {
      sprayedWith = output;
    });
    debugPrint(sprayedWith);
  }

  onChangedHarvestAuthorizedBy(String? output) {
    setState(() {
      harvestAuthorizedBy = output;
    });
    debugPrint(harvestAuthorizedBy);
  }

  onChangedComment(String? output) {
    setState(() {
      comment = output;
    });
    debugPrint(comment);
  }

  onChangedWithholdPeriodObserved(bool? output) {
    setState(() {
      if (output == true) {
        withholdPeriodObserved = "YES";
      } else {
        withholdPeriodObserved = "NO";
      }
    });
    debugPrint("$withholdPeriodObserved");
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
      HarvestRiskAssessmentModel dataModel = HarvestRiskAssessmentModel(
          harvestRiskAssessmentId: null,
          client: client!,
          farm: farm!,
          crop: crop!,
          blockRange: blockRange,
          harvestDate: harvestDate!,
          lastSprayDateTime: lastSprayDate,
          sprayedWith: sprayedWith,
          withholdPeriodApplied: withholdPeriodObserved ?? "NO",
          safeDateToHarvest: safeDateToHarvest,
          harvestAuthorizedBy: harvestAuthorizedBy,
          comment: comment,
          userId: 0,
          createdAt: createdAt, //2024-06-15 11:39:12
          updatedAt: null,
          createdBy: 0,
          updatedBy: null,
          signature: signatureName,
          isSynced: 0);
      int recordId =
          await HarvestRiskAssessment().createRecord(model: dataModel);
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
      HarvestRiskAssessmentModel dataModel = HarvestRiskAssessmentModel(
          harvestRiskAssessmentId: widget.data!.harvestRiskAssessmentId,
          client: client!,
          farm: farm!,
          crop: crop!,
          blockRange: blockRange,
          harvestDate: harvestDate!,
          lastSprayDateTime: lastSprayDate,
          sprayedWith: sprayedWith,
          withholdPeriodApplied: withholdPeriodObserved ?? "NO",
          safeDateToHarvest: safeDateToHarvest,
          harvestAuthorizedBy: harvestAuthorizedBy,
          comment: comment,
          userId: 0,
          createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
          updatedAt: updatedAt,
          createdBy: widget.data!.createdBy,
          updatedBy: null,
          signature: signatureName,
          isSynced: 0);
      int recordId =
          await HarvestRiskAssessment().updateRecord(model: dataModel);
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
    if (client != null && farm != null && crop != null && harvestDate != null) {
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
        Get.to(() => const HarvestRiskAssessmentMainTileView());
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
          title: "Harvest Risk Assessments includes WHP Observation",
          isUpdate: widget.isUpdate),
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
                  label: "Block range",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: blockRange,
                  onChangedText: onChangedBlockRange,
                ),

                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Harvest date",
                  hintText: "Tap to pick a date",
                  isRequired: true,
                  initialData: harvestDate,
                  onChangedDate: onChangedHarvestDate,
                ),
                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Last spray date",
                  hintText: "Tap to pick a date",
                  isRequired: false,
                  initialData: lastSprayDate,
                  onChangedDate: onChangedLastSprayDate,
                ),
                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Safe date to harvest",
                  hintText: "Tap to pick a date",
                  isRequired: false,
                  initialData: safeDateToHarvest,
                  onChangedDate: onChangedSafeDateToHarvest,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Sprayed with (chemical + whp)",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: sprayedWith,
                  onChangedText: onChangedSprayedWith,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Harvest authorized by",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: harvestAuthorizedBy,
                  onChangedText: onChangedHarvestAuthorizedBy,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Comment",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: comment,
                  onChangedText: onChangedComment,
                ),

                // Divider(color: CFGColor.lightGrey, height: 0),

                //toggle button
                FormToggleSwitchButton(
                  label: "Withhold period observed",
                  initialSwitchValue: withholdPeriodObserved == "YES" ? 1 : 0,
                  onChangedSwitch: onChangedWithholdPeriodObserved,
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
