import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes_model.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_fifteen_minutes/finished_product_weight_check_fifteen_minutes_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_signature.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:farm_management/widgets/form_time_slot_table_row.dart';
import 'package:permission_handler/permission_handler.dart';

class FinishedProductWeightCheckFifteenMinutesAdd extends StatefulWidget {
  final bool isUpdate;
  final FinishedProductWeightCheckFifteenMinutesModel? data;
  const FinishedProductWeightCheckFifteenMinutesAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<FinishedProductWeightCheckFifteenMinutesAdd> createState() =>
      _FinishedProductWeightCheckFifteenMinutesAddState();
}

class _FinishedProductWeightCheckFifteenMinutesAddState
    extends State<FinishedProductWeightCheckFifteenMinutesAdd> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;

  Uint8List? signatureData;

  @override
  void initState() {
    super.initState();
    //Creating variable maps
    timeSlotVariableGenerator();
    setState(() {
      loadingFuture = loadRecordData();
    });
  }

  // Map<int, String?> grossWeightVariableMap = {};
  // Map<int, String?> correctiveActionVariableMap = {};
  // Map<int, String?> commentVariableMap = {};

  Map<String?, Map<String, String?>> variableMap = {
    'grossWeight': {},
    'correctiveAction': {},
    'comment': {},
  };

  timeSlotVariableGenerator() {
    for (int index = 0;
        index < stateController.timeSlotsFifteenMinutes.length;
        index++) {
      //grossWeight
      variableMap['grossWeight']
          ?[stateController.timeSlotsFifteenMinutes[index]] = "";
      //correctiveAction
      variableMap['correctiveAction']
          ?[stateController.timeSlotsFifteenMinutes[index]] = "";
      //comment
      variableMap['comment']?[stateController.timeSlotsFifteenMinutes[index]] =
          "";
    }
    //print map
    debugPrint(variableMap.toString());
  }

  Future<bool> loadRecordData() async {
    if (widget.data != null) {
      try {
        final fifteenMinWeightCheckMap =
            jsonDecode(widget.data!.fifteenMinWeightCheck ?? "");
        debugPrint("$fifteenMinWeightCheckMap");
        for (var data in fifteenMinWeightCheckMap.entries) {
          // debugPrint("${data.value['id']}");
          setState(() {
            variableMap['grossWeight']![data.value['id']] =
                data.value['weight'];
            variableMap['correctiveAction']![data.value['id']] =
                data.value['corrective_action'];
            variableMap['comment']![data.value['id']] = data.value['comment'];
          });
        }
        debugPrint("$variableMap");
        setState(() {
          client = widget.data!.client;
          farm = widget.data!.farm;
          crop = widget.data!.crop;
          date = widget.data!.date;
          netWeight = widget.data!.netWeight;
          packagingTareWeight = widget.data!.packagingTareWeight;
          minimumGrossWeight = widget.data!.minimumGrossWeight;
          packingLine = widget.data!.packingLine;
          signatureName = null;
        });
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

  int? client;
  int? farm;
  int? crop;
  String? date;
  String? fifteenMinWeightCheck;
  String? netWeight;
  String? packagingTareWeight;
  String? minimumGrossWeight;
  String? packingLine;
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

  onChangedDate(String? output) {
    setState(() {
      date = output;
    });
    debugPrint(date);
  }

  onChangedNetWeight(String? output) {
    setState(() {
      netWeight = output;
    });
    debugPrint(netWeight);
  }

  onChangedPackagingTareWeight(String? output) {
    setState(() {
      packagingTareWeight = output;
    });
    debugPrint(packagingTareWeight);
  }

  onChangedMinimumGrossWeight(String? output) {
    setState(() {
      minimumGrossWeight = output;
    });
    debugPrint(minimumGrossWeight);
  }

  onChangedPackingLine(String? output) {
    setState(() {
      packingLine = output;
    });
    debugPrint(packingLine);
  }

  onChangedTimeSlotGrossWeight(String? output, int index) {
    setState(() {
      variableMap['grossWeight']
          ?[stateController.timeSlotsFifteenMinutes[index]] = output;
    });
    debugPrint(output);
  }

  onChangedTimeSlotCorrectiveAction(String? output, int index) {
    setState(() {
      variableMap['correctiveAction']
          ?[stateController.timeSlotsFifteenMinutes[index]] = output;
    });
    debugPrint(output);
  }

  onChangedTimeSlotComment(String? output, int index) {
    setState(() {
      variableMap['comment']?[stateController.timeSlotsFifteenMinutes[index]] =
          output;
    });
    debugPrint(output);
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

  mapCreateFifteenMinWeightCheck(
      {required Map<String, Map<String, dynamic>> map}) {
    try {
      for (int index = 0;
          index < stateController.timeSlotsFifteenMinutes.length;
          index++) {
        map[stateController.timeSlotsFifteenMinutes[index]] = {
          "id": stateController.timeSlotsFifteenMinutes[index],
          "start_time":
              stateController.timeSlotsFifteenMinutes[index].split('-').first,
          "end_time":
              stateController.timeSlotsFifteenMinutes[index].split('-').last,
          "weight": variableMap['grossWeight']
              ?[stateController.timeSlotsFifteenMinutes[index]],
          "corrective_action": variableMap['correctiveAction']
              ?[stateController.timeSlotsFifteenMinutes[index]],
          "comment": variableMap['comment']
              ?[stateController.timeSlotsFifteenMinutes[index]]
        };
      }
      debugPrint("$variableMap");
    } catch (e) {
      debugPrint("Error creating data map : $e");
    }
  }

  Future<int> createRecord() async {
    try {
      DateTime now = DateTime.now();
      String createdAt =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      //Generating Weight Check JsonString
      Map<String, Map<String, dynamic>> map = {};
      await mapCreateFifteenMinWeightCheck(map: map);
      fifteenMinWeightCheck = jsonEncode(map);
      debugPrint(fifteenMinWeightCheck);

      FinishedProductWeightCheckFifteenMinutesModel dataModel =
          FinishedProductWeightCheckFifteenMinutesModel(
              finishedProductWeightCheckFifteenMinId: null,
              client: client!,
              farm: farm!,
              crop: crop!,
              date: date!,
              fifteenMinWeightCheck: fifteenMinWeightCheck,
              netWeight: netWeight,
              correctiveAction: null,
              packagingTareWeight: packagingTareWeight,
              minimumGrossWeight: minimumGrossWeight,
              packingLine: packingLine,
              comment: null,
              userId: 0,
              createdAt: createdAt, //2024-06-15 11:39:12
              updatedAt: null,
              createdBy: null,
              updatedBy: null,
              signature: signatureName,
              isSynced: 0);
      int recordId = await FinishedProductWeightCheckFifteenMinutes()
          .createRecord(model: dataModel);
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
      //Generating Weight Check JsonString
      Map<String, Map<String, dynamic>> map = {};
      await mapCreateFifteenMinWeightCheck(map: map);
      fifteenMinWeightCheck = jsonEncode(map);
      debugPrint(fifteenMinWeightCheck);

      FinishedProductWeightCheckFifteenMinutesModel dataModel =
          FinishedProductWeightCheckFifteenMinutesModel(
              finishedProductWeightCheckFifteenMinId:
                  widget.data!.finishedProductWeightCheckFifteenMinId,
              client: client!,
              farm: farm!,
              crop: crop!,
              date: date!,
              fifteenMinWeightCheck: fifteenMinWeightCheck,
              netWeight: netWeight,
              correctiveAction: null,
              packagingTareWeight: packagingTareWeight,
              minimumGrossWeight: minimumGrossWeight,
              packingLine: packingLine,
              comment: null,
              userId: 0,
              createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
              updatedAt: updatedAt,
              createdBy: widget.data!.createdBy,
              updatedBy: null,
              signature: signatureName,
              isSynced: 0);
      int recordId = await FinishedProductWeightCheckFifteenMinutes()
          .updateRecord(model: dataModel);
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
    if (client != null && farm != null && crop != null && date != null) {
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
        Get.to(() => const FinishedProductWeightCheckFifteenMinutesMainTileView());
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
          title: "Finished Product Weight Check (Fifteen Min.)",
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

                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Date",
                  hintText: "Tap to pick a date",
                  isRequired: true,
                  initialData: date,
                  onChangedDate: onChangedDate,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Net weight",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: netWeight,
                  onChangedText: onChangedNetWeight,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Packaging tare weight",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: packagingTareWeight,
                  onChangedText: onChangedPackagingTareWeight,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Minimum gross weight",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: minimumGrossWeight,
                  onChangedText: onChangedMinimumGrossWeight,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Packing line",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: packingLine,
                  onChangedText: onChangedPackingLine,
                ),

                const SB(height: 5),

                //Time Slot Table
                ListView.builder(
                    itemCount: stateController.timeSlotsFifteenMinutes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          //
                          const SB(height: 5),

                          Divider(color: CFGColor.lightGrey, height: 0),

                          const SB(height: 5),

                          FormTimeSlotTableRow(
                            isUpdate: widget.isUpdate,
                            timeSlot:
                                stateController.timeSlotsFifteenMinutes[index],
                            firstFormFieldLabel: "Gross Weight",
                            firstFormFieldInitialData:
                                variableMap['grossWeight']?[stateController
                                    .timeSlotsFifteenMinutes[index]],
                            secondFormFieldLabel: "Corrective Action",
                            secondFormFieldInitialData:
                                variableMap['correctiveAction']?[stateController
                                    .timeSlotsFifteenMinutes[index]],
                            thirdFormFieldLabel: "Comment",
                            thirdFormFieldInitialData: variableMap['comment']?[
                                stateController.timeSlotsFifteenMinutes[index]],
                            onChangedTextFieldOne: (string) {
                              onChangedTimeSlotGrossWeight(string, index);
                            },
                            onChangedTextFieldTwo: (string) {
                              onChangedTimeSlotCorrectiveAction(string, index);
                            },
                            onChangedTextFieldThree: (string) {
                              onChangedTimeSlotComment(string, index);
                            },
                          ),
                        ],
                      );
                    }),

                const SB(height: 5),

                // Divider(color: CFGColor.lightGrey, height: 0),

                // const SB(height: 20),

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
