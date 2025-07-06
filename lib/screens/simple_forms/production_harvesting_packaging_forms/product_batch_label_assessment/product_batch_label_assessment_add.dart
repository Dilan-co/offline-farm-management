import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment_model.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment/product_batch_label_assessment_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_label_sample.dart';
import 'package:farm_management/widgets/form_signature.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductBatchLabelAssessmentAdd extends StatefulWidget {
  final bool isUpdate;
  final ProductionBatchLabelAssessmentModel? data;
  const ProductBatchLabelAssessmentAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<ProductBatchLabelAssessmentAdd> createState() =>
      _ProductBatchLabelAssessmentAddState();
}

class _ProductBatchLabelAssessmentAddState
    extends State<ProductBatchLabelAssessmentAdd> {
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
          productionBatchNumber = widget.data!.productionBatchNumber;
          variety = widget.data!.variety;
          packDate = widget.data!.packDate;
          startTime = widget.data!.startTime;
          endTime = widget.data!.endTime;
          correctiveAction = widget.data!.correctiveAction;
          comment = widget.data!.comment;
          labelSampleOnePackDate = widget.data!.packDateOne;
          labelSampleOneBestBeforeDate = widget.data!.bestBeforeDateOne;
          labelSampleOneLabelPosition = widget.data!.labelPositionOne;
          labelSampleOneLabelLegible = widget.data!.labelLegibleOne;
          labelSampleTwoPackDate = widget.data!.packDateTwo;
          labelSampleTwoBestBeforeDate = widget.data!.bestBeforeDateTwo;
          labelSampleTwoLabelPosition = widget.data!.labelPositionTwo;
          labelSampleTwoLabelLegible = widget.data!.labelLegibleTwo;
          signatureName = null;
          fileNameOfLabelSampleOne = widget.data!.labelSampleOne;
          fileNameOfLabelSampleTwo = widget.data!.labelSampleTwo;
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
  String? productionBatchNumber;
  String? variety;
  String? packDate;
  String? startTime;
  String? endTime;
  String? correctiveAction;
  String? comment;
  String? labelSampleOnePackDate;
  String? labelSampleOneBestBeforeDate;
  int? labelSampleOneLabelPosition;
  int? labelSampleOneLabelLegible;
  String? labelSampleTwoPackDate;
  String? labelSampleTwoBestBeforeDate;
  int? labelSampleTwoLabelPosition;
  int? labelSampleTwoLabelLegible;
  String? signatureName;

  //---- File Names ----
  String? fileNameOfLabelSampleOne;
  String? fileNameOfLabelSampleTwo;
  //---- File Paths ----
  String? filePathOfLabelSampleOne;
  String? filePathOfLabelSampleTwo;

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

  onChangedProductionBatchNumber(String? output) {
    setState(() {
      productionBatchNumber = output;
    });
    debugPrint(productionBatchNumber);
  }

  onChangedVariety(String? output) {
    setState(() {
      variety = output;
    });
    debugPrint(variety);
  }

  onChangedPackDate(String? output) {
    setState(() {
      packDate = output;
    });
    debugPrint(packDate);
  }

  onChangedStartTime(String? output) {
    setState(() {
      startTime = output;
    });
    debugPrint(startTime);
  }

  onChangedEndTime(String? output) {
    setState(() {
      endTime = output;
    });
    debugPrint(endTime);
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

  onChangedLabelSampleOnePackDate(String? output) {
    setState(() {
      labelSampleOnePackDate = output;
    });
    debugPrint(labelSampleOnePackDate);
  }

  onChangedLabelSampleOneBestBeforeDate(String? output) {
    setState(() {
      labelSampleOneBestBeforeDate = output;
    });
    debugPrint(labelSampleOneBestBeforeDate);
  }

  onChangedLabelSampleOneLabelPosition(bool? output) {
    setState(() {
      if (output == true) {
        labelSampleOneLabelPosition = 1;
      } else {
        labelSampleOneLabelPosition = 0;
      }
    });
    debugPrint("$output");
  }

  onChangedLabelSampleOneLabelLegible(bool? output) {
    setState(() {
      if (output == true) {
        labelSampleOneLabelLegible = 1;
      } else {
        labelSampleOneLabelLegible = 0;
      }
    });
    debugPrint("$output");
  }

  onChangedLabelSampleTwoPackDate(String? output) {
    setState(() {
      labelSampleTwoPackDate = output;
    });
    debugPrint(labelSampleTwoPackDate);
  }

  onChangedLabelSampleTwoBestBeforeDate(String? output) {
    setState(() {
      labelSampleTwoBestBeforeDate = output;
    });
    debugPrint(labelSampleTwoBestBeforeDate);
  }

  onChangedLabelSampleTwoLabelPosition(bool? output) {
    setState(() {
      if (output == true) {
        labelSampleTwoLabelPosition = 1;
      } else {
        labelSampleTwoLabelPosition = 0;
      }
    });
    debugPrint("$output");
  }

  onChangedLabelSampleTwoLabelLegible(bool? output) {
    setState(() {
      if (output == true) {
        labelSampleTwoLabelLegible = 1;
      } else {
        labelSampleTwoLabelLegible = 0;
      }
    });
    debugPrint("$output");
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

  onFileSelectLabelSampleOne(String? filePath) {
    setState(() {
      filePathOfLabelSampleOne = filePath;
    });
    debugPrint(filePath);
  }

  onFileSelectLabelSampleTwo(String? filePath) {
    setState(() {
      filePathOfLabelSampleTwo = filePath;
    });
    debugPrint(filePath);
  }

  saveSelectedFiles() async {
    //LABEL SAMPLE 01
    if (filePathOfLabelSampleOne != null) {
      bool isFileSaved = await saveImageToDocuments(filePathOfLabelSampleOne!);
      if (isFileSaved == true) {
        setState(() {
          fileNameOfLabelSampleOne = basename(filePathOfLabelSampleOne!);
        });
      }
    }
    //LABEL SAMPLE 02
    if (filePathOfLabelSampleTwo != null) {
      bool isFileSaved = await saveImageToDocuments(filePathOfLabelSampleTwo!);
      if (isFileSaved == true) {
        setState(() {
          fileNameOfLabelSampleTwo = basename(filePathOfLabelSampleTwo!);
        });
      }
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
        DateTime now = DateTime.now();
        String signatureFileName =
            "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}.png";
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
      // "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
      debugPrint(createdAt);
      ProductionBatchLabelAssessmentModel dataModel =
          ProductionBatchLabelAssessmentModel(
        productionBatchLabelAssessmentId: null,
        client: client!,
        farm: farm!,
        crop: crop!,
        productionBatchNumber: productionBatchNumber!,
        variety: variety,
        packDate: packDate!,
        startTime: startTime,
        endTime: endTime,
        labelSampleOne: fileNameOfLabelSampleOne,
        packDateOne: labelSampleOnePackDate,
        bestBeforeDateOne: labelSampleOneBestBeforeDate,
        labelPositionOne: labelSampleOneLabelPosition ?? 0,
        labelLegibleOne: labelSampleOneLabelLegible ?? 0,
        labelSampleTwo: fileNameOfLabelSampleTwo,
        packDateTwo: labelSampleTwoPackDate,
        bestBeforeDateTwo: labelSampleTwoBestBeforeDate,
        labelPositionTwo: labelSampleTwoLabelPosition ?? 0,
        labelLegibleTwo: labelSampleTwoLabelLegible ?? 0,
        correctiveAction: correctiveAction,
        comment: comment,
        userId: null,
        createdAt: createdAt, //2024-06-15 11:39:12
        updatedAt: null,
        createdBy: null,
        updatedBy: null,
        signature: signatureName,
        isSynced: 0,
      );
      int recordId =
          await ProductionBatchLabelAssessment().createRecord(model: dataModel);
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
      // "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
      debugPrint(updatedAt);
      ProductionBatchLabelAssessmentModel dataModel =
          ProductionBatchLabelAssessmentModel(
        productionBatchLabelAssessmentId:
            widget.data!.productionBatchLabelAssessmentId,
        client: client!,
        farm: farm!,
        crop: crop!,
        productionBatchNumber: productionBatchNumber!,
        variety: variety,
        packDate: packDate!,
        startTime: startTime,
        endTime: endTime,
        labelSampleOne: fileNameOfLabelSampleOne,
        packDateOne: labelSampleOnePackDate,
        bestBeforeDateOne: labelSampleOneBestBeforeDate,
        labelPositionOne: labelSampleOneLabelPosition,
        labelLegibleOne: labelSampleOneLabelLegible,
        labelSampleTwo: fileNameOfLabelSampleTwo,
        packDateTwo: labelSampleTwoPackDate,
        bestBeforeDateTwo: labelSampleTwoBestBeforeDate,
        labelPositionTwo: labelSampleTwoLabelPosition,
        labelLegibleTwo: labelSampleTwoLabelLegible,
        correctiveAction: correctiveAction,
        comment: comment,
        userId: null,
        createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
        updatedAt: updatedAt,
        createdBy: widget.data!.createdBy,
        updatedBy: null,
        signature: signatureName,
        isSynced: 0,
      );
      int recordId =
          await ProductionBatchLabelAssessment().updateRecord(model: dataModel);
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
        productionBatchNumber != null &&
        packDate != null &&
        startTime != null &&
        endTime != null) {
      await requestPermission(Permission.storage);
      await saveSelectedFiles();
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
        Get.to(() => const ProductBatchLabelAssessmentMainTileView());
      } else {
        Get.back(result: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Get.back(result: true);
        debugPrint("Pop");
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(
            title: "Production Batch Label Assessments",
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
                    label: "Production batch number",
                    hintText: "Type here",
                    isRequired: true,
                    initialData: productionBatchNumber,
                    onChangedText: onChangedProductionBatchNumber,
                  ),
                  FormTextField(
                    isUpdate: widget.isUpdate,
                    label: "Variety",
                    hintText: "Type here",
                    isRequired: false,
                    initialData: variety,
                    onChangedText: onChangedVariety,
                  ),

                  //add date picker here
                  FormDatePicker(
                    isUpdate: widget.isUpdate,
                    initialData: packDate,
                    label: "Pack date",
                    hintText: "Tap to pick a date",
                    isRequired: true,
                    onChangedDate: onChangedPackDate,
                  ),

                  FormTextField(
                    isUpdate: widget.isUpdate,
                    label: "Start time",
                    hintText: "HH:mm",
                    isRequired: true,
                    initialData: startTime,
                    onChangedText: onChangedStartTime,
                  ),

                  FormTextField(
                    isUpdate: widget.isUpdate,
                    label: "End time",
                    hintText: "HH:mm",
                    isRequired: true,
                    initialData: endTime,
                    onChangedText: onChangedEndTime,
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

                  // Divider(color: CFGColor.lightGrey, height: 0),

                  //Label Sample 01
                  FormLabelSample(
                    isUpdate: widget.isUpdate,
                    initialFileName: fileNameOfLabelSampleOne,
                    initialPackDate: labelSampleOnePackDate,
                    initialBestBeforeDate: labelSampleOneBestBeforeDate,
                    initialLabelPosition: labelSampleOneLabelPosition,
                    initialLabelLegible: labelSampleOneLabelLegible,
                    label: "LABEL SAMPLE 01",
                    onChangedPackDate: onChangedLabelSampleOnePackDate,
                    onChangedBestBeforeDate:
                        onChangedLabelSampleOneBestBeforeDate,
                    onChangedSwitchLabelPosition:
                        onChangedLabelSampleOneLabelPosition,
                    onChangedSwitchLabelLegible:
                        onChangedLabelSampleOneLabelLegible,
                    selectedFilePath: onFileSelectLabelSampleOne,
                  ),

                  // Divider(color: CFGColor.lightGrey, height: 0),

                  //Label Sample 02
                  FormLabelSample(
                    isUpdate: widget.isUpdate,
                    initialFileName: fileNameOfLabelSampleTwo,
                    initialPackDate: labelSampleTwoPackDate,
                    initialBestBeforeDate: labelSampleTwoBestBeforeDate,
                    initialLabelPosition: labelSampleTwoLabelPosition,
                    initialLabelLegible: labelSampleTwoLabelLegible,
                    label: "LABEL SAMPLE 02",
                    onChangedPackDate: onChangedLabelSampleTwoPackDate,
                    onChangedBestBeforeDate:
                        onChangedLabelSampleTwoBestBeforeDate,
                    onChangedSwitchLabelPosition:
                        onChangedLabelSampleTwoLabelPosition,
                    onChangedSwitchLabelLegible:
                        onChangedLabelSampleTwoLabelLegible,
                    selectedFilePath: onFileSelectLabelSampleTwo,
                  ),

                  //Add Signature widget here
                  FormSignature(onChangedSignaturePngData: onChangedSignature),

                  //
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
      )),
    );
  }
}
