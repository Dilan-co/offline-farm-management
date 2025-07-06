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
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/plu_sticker_record.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/plu_sticker_record_model.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/plu_sticker_record/plu_sticker_record_main_tile_view.dart';
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

class PLUStickerRecordAdd extends StatefulWidget {
  final bool isUpdate;
  final PluStickerRecordModel? data;
  const PLUStickerRecordAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<PLUStickerRecordAdd> createState() => _PLUStickerRecordAddState();
}

class _PLUStickerRecordAddState extends State<PLUStickerRecordAdd> {
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
          date = widget.data!.date;
          time = widget.data!.time;
          cassetteNumber = widget.data!.cassetteNumber;
          lineClearance = widget.data!.lineClearance;
          comment = widget.data!.comment;
          pluOldFileName = widget.data!.pluOld ?? "";
          pluNewFileName = widget.data!.pluNew ?? "";
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

  //"file" is to be the one to save into DB
  File? pluOldFile;
  File? pluNewFile;
  String pluOldFileName = "";
  String pluNewFileName = "";
  int? client;
  int? farm;
  int? crop;
  String? date;
  String? time;
  String? cassetteNumber;
  int? lineClearance;
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

  onChangedDate(String? output) {
    setState(() {
      date = output;
    });
    debugPrint(date);
  }

  onChangedTime(String? output) {
    setState(() {
      time = output;
    });
    debugPrint(time);
  }

  onChangedCassetteNumber(String? output) {
    setState(() {
      cassetteNumber = output;
    });
    debugPrint(cassetteNumber);
  }

  onChangedLineClearance(bool? output) {
    setState(() {
      if (output == true) {
        lineClearance = 1;
      } else {
        lineClearance = 0;
      }
    });
    debugPrint("$lineClearance");
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

  savePluSticker() async {
    if (pluOldFile != null) {
      await saveImageToDocuments(pluOldFile!.path);
    }
    if (pluNewFile != null) {
      await saveImageToDocuments(pluNewFile!.path);
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
      PluStickerRecordModel dataModel = PluStickerRecordModel(
          pluStickerId: null,
          client: client!,
          farm: farm!,
          crop: crop!,
          date: date!,
          time: time,
          cassetteNumber: cassetteNumber,
          lineClearance: lineClearance ?? 1,
          pluNew: pluNewFileName,
          pluOld: pluOldFileName,
          comment: comment,
          userId: null,
          createdAt: createdAt, //2024-06-15 11:39:12
          updatedAt: null,
          createdBy: null,
          updatedBy: null,
          signature: signatureName!,
          isSynced: 0);
      int recordId = await PluStickerRecord().createRecord(model: dataModel);
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
      PluStickerRecordModel dataModel = PluStickerRecordModel(
          pluStickerId: widget.data!.pluStickerId,
          client: client!,
          farm: farm!,
          crop: crop!,
          date: date!,
          time: time,
          cassetteNumber: cassetteNumber,
          lineClearance: lineClearance ?? 1,
          pluNew: pluNewFileName,
          pluOld: pluOldFileName,
          comment: comment,
          userId: null,
          createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
          updatedAt: updatedAt,
          createdBy: widget.data!.createdBy,
          updatedBy: null,
          signature: signatureName!,
          isSynced: 0);
      int recordId = await PluStickerRecord().updateRecord(model: dataModel);
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
        date != null &&
        signatureData != null) {
      await requestPermission(Permission.storage);
      await savePluSticker();
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
        Get.to(() => const PLUStickerRecordMainTileView());
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
          title: "PLU Sticker Record", isUpdate: widget.isUpdate),
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
                  label: "Time",
                  hintText: "HH:mm",
                  isRequired: false,
                  initialData: time,
                  onChangedText: onChangedTime,
                ),

                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Cassette number",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: cassetteNumber,
                  onChangedText: onChangedCassetteNumber,
                ),

                //toggle button
                FormToggleSwitchButton(
                  label: "Line clearance",
                  initialSwitchValue: lineClearance,
                  onChangedSwitch: onChangedLineClearance,
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
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
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
                              pluNewFile =
                                  File(result.files.single.path.toString());
                              pluNewFileName = result.files.first.name;
                            });
                            debugPrint(pluNewFileName);
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Text("PLU New",
                            style: TextStyle(
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
                            pluNewFileName,
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
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
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
                              pluOldFile =
                                  File(result.files.single.path.toString());
                              pluOldFileName = result.files.first.name;
                            });
                            debugPrint(pluOldFileName);
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Text("PLU Old",
                            style: TextStyle(
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
                            pluOldFileName,
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

                Text(signatureData == null ? "Signature Required" : '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: CFGFont.smallFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.redFontColor,
                    )),

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
