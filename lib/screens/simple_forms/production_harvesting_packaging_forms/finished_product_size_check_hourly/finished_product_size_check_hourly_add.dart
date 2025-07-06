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
import 'package:farm_management/database/tables/crop/crop_client_crop.dart';
import 'package:farm_management/database/tables/crop/crop_client_crop_variety.dart';
import 'package:farm_management/database/tables/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly.dart';
import 'package:farm_management/lists/dropdown_list.dart';
import 'package:farm_management/models/table_models/crop/crop_client_crop_model.dart';
import 'package:farm_management/models/table_models/crop/crop_client_crop_variety_model.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly_model.dart';
import 'package:farm_management/screens/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly/finished_product_size_check_hourly_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/form_box_time_slot_table_row.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_signature.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:permission_handler/permission_handler.dart';

class FinishedProductSizeCheckHourlyAdd extends StatefulWidget {
  final bool isUpdate;
  final FinishedProductSizeCheckHourlyModel? data;
  const FinishedProductSizeCheckHourlyAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<FinishedProductSizeCheckHourlyAdd> createState() =>
      _FinishedProductSizeCheckHourlyAddState();
}

class _FinishedProductSizeCheckHourlyAddState
    extends State<FinishedProductSizeCheckHourlyAdd>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  late TabController tabController;
  int selectedIndex = 0;

  // GlobalKey _childKey = GlobalKey();
  // double _childHeight = 0.0;

  @override
  void initState() {
    super.initState();

    sizeCheckVariableGenerator();
    boxLabelVariableGenerator();
    setState(() {
      loadingFuture = loadRecordData();
    });

    tabController = TabController(
      initialIndex: selectedIndex,
      length: 6,
      vsync: this,
    );

    // // Add a post-frame callback to measure the child's height after layout.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final RenderBox renderBox =
    //       _childKey.currentContext?.findRenderObject() as RenderBox;
    //   setState(() {
    //     _childHeight = renderBox.size.height;
    //     print(_childHeight);
    //   });
    // });
  }

  Future<bool> loadRecordData() async {
    if (widget.data != null) {
      try {
        final hourlySizeCheckMap =
            jsonDecode(widget.data!.hourlySizeCheck ?? "");
        debugPrint("$hourlySizeCheckMap");
        for (var data in hourlySizeCheckMap.entries) {
          // debugPrint("${data.value['id']}");
          if (data.key == "boxes") {
            debugPrint("Boxes --> $data");
            for (int i = 0; i < 6; i++) {
              setState(() {
                boxLabelMap[i] = data.value[i];
              });
            }
            debugPrint('$boxLabelMap');
          } else {
            debugPrint("Time Slots --> $data");
            for (int index = 0; index < 6; index++) {
              // debugPrint("${data.value['id']}");
              for (int i = 0; i < 6; i++) {
                variableMap['box#${index + 1}']?[data.value['id']]?[i] =
                    data.value['$index'][i];
                debugPrint("${data.value['id']}");
                debugPrint("${data.value['$index'][i]}");
              }
            }
          }
        }
        debugPrint("$variableMap");
        setState(() {
          client = widget.data!.client;
          farm = widget.data!.farm;
          crop = widget.data!.crop;
          variety = widget.data!.variety;
          date = widget.data!.date;
          hourlySizeCheckData = widget.data!.hourlySizeCheck;
          measurementUnit = widget.data!.measurementUnit;
          comment = widget.data!.comment;
          signatureName = null;
        });
        //Load Variety List
        onSelectCropLoadVarietyData(cropId: widget.data!.crop);
        //Dropdown initial values
        CropClientCropVarietyModel varietyData = await CropClientCropVariety()
            .fetchByVarietyId(varietyId: widget.data!.variety);
        setState(() {
          varietyName = varietyData.name;
        });
        debugPrint(varietyName);
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
  String? varietyName;

  Uint8List? signatureData;

  int? client;
  int? farm;
  int? crop;
  int? variety;
  String? date;
  String? hourlySizeCheckData;
  String? measurementUnit;
  String? comment;
  String? signatureName;
  List<Map<int, String>> varietyList = [];
  Map<int, String?> boxLabelMap = {};
  Map<String?, Map<String?, Map<int, String?>>> variableMap = {};

  onSelectCropLoadVarietyData({required int cropId}) async {
    //Load Variety Data
    CropClientCropModel? clientCropData =
        await CropClientCrop().fetchByCropId(cropId: cropId);

    if (clientCropData != null) {
      debugPrint("Client Crop Data $clientCropData");
      List<CropClientCropVarietyModel> varietyDataList =
          await CropClientCropVariety()
              .fetchByClientCropId(clientCropId: clientCropData.clientCropId!);
      debugPrint("Client Crop Variety List$varietyDataList");
      final list =
          await DropdownList().varietyListGenerate(dataList: varietyDataList);
      setState(() {
        varietyList = list;
      });
    } else {
      setState(() {
        varietyList = [];
        variety = null;
      });
    }
  }

  sizeCheckVariableGenerator() {
    for (int index = 0; index < 6; index++) {
      variableMap['box#${index + 1}'] = {};
      for (int slotIndex = 0;
          slotIndex < stateController.boxTimeSlotsHourly.length;
          slotIndex++) {
        variableMap['box#${index + 1}']
            ?[stateController.boxTimeSlotsHourly[slotIndex]] = {};
        for (int i = 0; i < 6; i++) {
          variableMap['box#${index + 1}']
              ?[stateController.boxTimeSlotsHourly[slotIndex]]?[i] = "";
        }
      }
    }
    //print map
    debugPrint(variableMap.toString());
  }

  boxLabelVariableGenerator() {
    for (int index = 0; index < 6; index++) {
      boxLabelMap[index] = "";
    }
    //print map
    debugPrint(boxLabelMap.toString());
  }

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
    if (output != null) {
      onSelectCropLoadVarietyData(cropId: output);
      setState(() {
        varietyName = null;
      });
    }
    setState(() {
      crop = output;
    });
    debugPrint("$output");
  }

  onChangedDropdownVariety(int? output) {
    setState(() {
      variety = output;
    });
    debugPrint("$output");
  }

  onChangedDate(String? output) {
    setState(() {
      date = output;
    });
    debugPrint(date);
  }

  onChangedMeasurementUnit(String? output) {
    setState(() {
      measurementUnit = output;
    });
    debugPrint(measurementUnit);
  }

  onChangedComment(String? output) {
    setState(() {
      comment = output;
    });
    debugPrint(comment);
  }

  onChangedBoxOneLabel(String? output) {
    setState(() {
      boxLabelMap[0] = output;
    });
    debugPrint(boxLabelMap[0]);
  }

  onChangedBoxTwoLabel(String? output) {
    setState(() {
      boxLabelMap[1] = output;
    });
    debugPrint(boxLabelMap[1]);
  }

  onChangedBoxThreeLabel(String? output) {
    setState(() {
      boxLabelMap[2] = output;
    });
    debugPrint(boxLabelMap[2]);
  }

  onChangedBoxFourLabel(String? output) {
    setState(() {
      boxLabelMap[3] = output;
    });
    debugPrint(boxLabelMap[3]);
  }

  onChangedBoxFiveLabel(String? output) {
    setState(() {
      boxLabelMap[4] = output;
    });
    debugPrint(boxLabelMap[4]);
  }

  onChangedBoxSixLabel(String? output) {
    setState(() {
      boxLabelMap[5] = output;
    });
    debugPrint(boxLabelMap[5]);
  }

  //------ BOX #1 ------
  onChangedBoxOneTimeSlotTextFieldOne(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 1) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 2) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 3) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 4) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 5) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      }
    });
    debugPrint(output);
    debugPrint("$variableMap");
  }

  onChangedBoxOneTimeSlotTextFieldTwo(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 1) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 2) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 3) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 4) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 5) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxOneTimeSlotTextFieldThree(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 1) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 2) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 3) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 4) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 5) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxOneTimeSlotTextFieldFour(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 1) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 2) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 3) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 4) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 5) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxOneTimeSlotTextFieldFive(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 1) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 2) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 3) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 4) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 5) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxOneTimeSlotTextFieldSix(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 1) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 2) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 3) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 4) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 5) {
        variableMap['box#1']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      }
    });
    debugPrint(output);
  }

  //------ BOX #2 ------
  onChangedBoxTwoTimeSlotTextFieldOne(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 1) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 2) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 3) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 4) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 5) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      }
    });
    debugPrint(output);
    debugPrint("$variableMap");
  }

  onChangedBoxTwoTimeSlotTextFieldTwo(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 1) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 2) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 3) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 4) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 5) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxTwoTimeSlotTextFieldThree(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 1) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 2) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 3) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 4) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 5) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxTwoTimeSlotTextFieldFour(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 1) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 2) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 3) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 4) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 5) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxTwoTimeSlotTextFieldFive(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 1) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 2) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 3) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 4) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 5) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxTwoTimeSlotTextFieldSix(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 1) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 2) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 3) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 4) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 5) {
        variableMap['box#2']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      }
    });
    debugPrint(output);
  }

  //------ BOX #3 ------
  onChangedBoxThreeTimeSlotTextFieldOne(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 1) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 2) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 3) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 4) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 5) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxThreeTimeSlotTextFieldTwo(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 1) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 2) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 3) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 4) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 5) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxThreeTimeSlotTextFieldThree(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 1) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 2) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 3) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 4) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 5) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxThreeTimeSlotTextFieldFour(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 1) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 2) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 3) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 4) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 5) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxThreeTimeSlotTextFieldFive(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 1) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 2) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 3) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 4) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 5) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxThreeTimeSlotTextFieldSix(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 1) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 2) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 3) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 4) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 5) {
        variableMap['box#3']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      }
    });
    debugPrint(output);
  }

  //------ BOX #4 ------
  onChangedBoxFourTimeSlotTextFieldOne(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 1) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 2) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 3) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 4) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 5) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFourTimeSlotTextFieldTwo(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 1) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 2) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 3) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 4) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 5) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFourTimeSlotTextFieldThree(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 1) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 2) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 3) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 4) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 5) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFourTimeSlotTextFieldFour(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 1) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 2) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 3) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 4) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 5) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFourTimeSlotTextFieldFive(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 1) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 2) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 3) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 4) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 5) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFourTimeSlotTextFieldSix(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 1) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 2) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 3) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 4) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 5) {
        variableMap['box#4']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      }
    });
    debugPrint(output);
  }

  //------ BOX #5 ------
  onChangedBoxFiveTimeSlotTextFieldOne(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 1) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 2) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 3) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 4) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 5) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFiveTimeSlotTextFieldTwo(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 1) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 2) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 3) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 4) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 5) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFiveTimeSlotTextFieldThree(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 1) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 2) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 3) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 4) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 5) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFiveTimeSlotTextFieldFour(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 1) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 2) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 3) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 4) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 5) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFiveTimeSlotTextFieldFive(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 1) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 2) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 3) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 4) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 5) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxFiveTimeSlotTextFieldSix(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 1) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 2) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 3) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 4) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 5) {
        variableMap['box#5']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      }
    });
    debugPrint(output);
  }

  //------ BOX #6 ------
  onChangedBoxSixTimeSlotTextFieldOne(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 1) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 2) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 3) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 4) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      } else if (index == 5) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[0] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxSixTimeSlotTextFieldTwo(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 1) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 2) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 3) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 4) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      } else if (index == 5) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[1] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxSixTimeSlotTextFieldThree(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 1) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 2) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 3) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 4) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      } else if (index == 5) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[2] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxSixTimeSlotTextFieldFour(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 1) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 2) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 3) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 4) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      } else if (index == 5) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[3] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxSixTimeSlotTextFieldFive(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 1) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 2) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 3) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 4) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      } else if (index == 5) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[4] =
            output;
      }
    });
    debugPrint(output);
  }

  onChangedBoxSixTimeSlotTextFieldSix(String output, int index) {
    setState(() {
      if (index == 0) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 1) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 2) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 3) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 4) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      } else if (index == 5) {
        variableMap['box#6']?[stateController.boxTimeSlotsHourly[index]]?[5] =
            output;
      }
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

  mapCreateHourlySizeCheck({required Map<String, Map<String, dynamic>> map}) {
    try {
      List boxNameList = [];
      for (int i = 0; i < 6; i++) {
        boxNameList.add(boxLabelMap[i]);
        debugPrint("$boxNameList");
      }
      for (int index = 0;
          index < stateController.boxTimeSlotsHourly.length;
          index++) {
        List boxOne = [];
        List boxTwo = [];
        List boxThree = [];
        List boxFour = [];
        List boxFive = [];
        List boxSix = [];
        for (int i = 0; i < 6; i++) {
          boxOne.add(variableMap['box#1']
              ?[stateController.boxTimeSlotsHourly[index]]?[i]);
          boxTwo.add(variableMap['box#2']
              ?[stateController.boxTimeSlotsHourly[index]]?[i]);
          boxThree.add(variableMap['box#3']
              ?[stateController.boxTimeSlotsHourly[index]]?[i]);
          boxFour.add(variableMap['box#4']
              ?[stateController.boxTimeSlotsHourly[index]]?[i]);
          boxFive.add(variableMap['box#5']
              ?[stateController.boxTimeSlotsHourly[index]]?[i]);
          boxSix.add(variableMap['box#6']
              ?[stateController.boxTimeSlotsHourly[index]]?[i]);
          debugPrint("$boxOne");
          debugPrint("$boxTwo");
          debugPrint("$boxThree");
          debugPrint("$boxFour");
          debugPrint("$boxFive");
          debugPrint("$boxSix");
        }
        map[stateController.boxTimeSlotsHourly[index]] = {
          "boxes": boxNameList,
          "id": stateController.boxTimeSlotsHourly[index],
          "start_time":
              stateController.boxTimeSlotsHourly[index].split('-').first,
          "end_time": stateController.boxTimeSlotsHourly[index].split('-').last,
          "0": boxOne,
          "1": boxTwo,
          "2": boxThree,
          "3": boxFour,
          "4": boxFive,
          "5": boxSix,
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
      await mapCreateHourlySizeCheck(map: map);
      hourlySizeCheckData = jsonEncode(map);
      debugPrint("$map");
      debugPrint(hourlySizeCheckData);

      FinishedProductSizeCheckHourlyModel dataModel =
          FinishedProductSizeCheckHourlyModel(
              finishedProductSizeCheckHourlyId: null,
              client: client!,
              farm: farm!,
              crop: crop!,
              variety: variety!,
              date: date!,
              hourlySizeCheck: hourlySizeCheckData,
              measurementUnit: measurementUnit!,
              comment: comment,
              userId: 0,
              createdAt: createdAt, //2024-06-15 11:39:12
              updatedAt: null,
              createdBy: null,
              updatedBy: null,
              signature: signatureName,
              isSynced: 0);
      int recordId =
          await FinishedProductSizeCheckHourly().createRecord(model: dataModel);
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
      await mapCreateHourlySizeCheck(map: map);
      hourlySizeCheckData = jsonEncode(map);
      debugPrint("$map");
      debugPrint(hourlySizeCheckData);

      FinishedProductSizeCheckHourlyModel dataModel =
          FinishedProductSizeCheckHourlyModel(
              finishedProductSizeCheckHourlyId:
                  widget.data!.finishedProductSizeCheckHourlyId,
              client: client!,
              farm: farm!,
              crop: crop!,
              variety: variety!,
              date: date!,
              hourlySizeCheck: hourlySizeCheckData,
              measurementUnit: measurementUnit!,
              comment: comment,
              userId: 0,
              createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
              updatedAt: updatedAt,
              createdBy: widget.data!.createdBy,
              updatedBy: null,
              signature: signatureName,
              isSynced: 0);
      int recordId =
          await FinishedProductSizeCheckHourly().updateRecord(model: dataModel);
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
        variety != null &&
        date != null &&
        measurementUnit != null) {
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
        Get.to(() => const FinishedProductSizeCheckHourlyMainTileView());
      } else {
        Get.back(result: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
        child: DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(
            title: "Finished Product Size Check (Hourly)",
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
                  FormDropdown(
                    isDropDownIndexReset: true,
                    isUpdate: widget.isUpdate,
                    dropdownList: varietyList,
                    label: "Variety",
                    dropdownHintText: "Please select a variety",
                    isRequired: true,
                    initialData: varietyName,
                    onChangedDropdown: onChangedDropdownVariety,
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
                    label: "Measurement unit",
                    hintText: "Type here",
                    isRequired: true,
                    initialData: measurementUnit,
                    onChangedText: onChangedMeasurementUnit,
                  ),
                  FormTextField(
                    isUpdate: widget.isUpdate,
                    label: "Comment",
                    hintText: "Type here",
                    isRequired: false,
                    initialData: comment,
                    onChangedText: onChangedComment,
                  ),

                  //------------------- Box Time Slot Table -------------------

                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text("Select the BOX and fill data",
                        style: TextStyle(
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),
                  ),

                  Divider(color: CFGColor.lightGrey, height: 0),

                  TabBar(
                    controller: tabController,
                    onTap: (int index) {
                      if (index != selectedIndex) {
                        //Dismiss Keyboard on Tab switching
                        FocusScope.of(context).unfocus();
                      }
                      setState(() {
                        selectedIndex = index;
                        tabController.animateTo(index);
                      });
                    },
                    indicator: BoxDecoration(
                        color: CFGTheme.buttonLightGrey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: CFGTheme.button,
                          width: 2.0,
                        )),
                    indicatorWeight: 5,
                    dividerColor: CFGColor.lightGrey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: CFGTheme.button,
                    labelColor: CFGFont.defaultFontColor,
                    labelPadding: EdgeInsets.zero,
                    unselectedLabelColor: CFGFont.greyFontColor,
                    overlayColor:
                        WidgetStatePropertyAll(CFGTheme.buttonLightGrey),
                    labelStyle: TextStyle(
                      fontFamily: 'Oswald',
                      // letterSpacing: 0.5,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.mediumFontWeight,
                      color: CFGFont.defaultFontColor,
                    ),
                    tabs: const [
                      Tab(text: 'BOX #1'),
                      Tab(text: 'BOX #2'),
                      Tab(text: 'BOX #3'),
                      Tab(text: 'BOX #4'),
                      Tab(text: 'BOX #5'),
                      Tab(text: 'BOX #6'),
                    ],
                  ),

                  SB(
                    height: (153 * stateController.boxTimeSlotsHourly.length)
                        .toDouble(),
                    child: TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //Box 1
                        Column(
                          children: [
                            //
                            FormTextField(
                              isUpdate: widget.isUpdate,
                              label: "",
                              hintText: "Type here",
                              textAlign: TextAlign.center,
                              hintTextSize: CFGFont.defaultFontSize,
                              inputTextSize: CFGFont.subTitleFontSize,
                              isRequired: false,
                              initialData: boxLabelMap[0],
                              onChangedText: onChangedBoxOneLabel,
                            ),

                            const SB(height: 10),

                            ListView.builder(
                                itemCount:
                                    stateController.boxTimeSlotsHourly.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      //
                                      const SB(height: 5),

                                      FormBoxTimeSlotTableRow(
                                        isUpdate: widget.isUpdate,
                                        timeSlot: stateController
                                            .boxTimeSlotsHourly[index],
                                        initialDataTextFieldOne: variableMap[
                                                'box#1']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[0],
                                        initialDataTextFieldTwo: variableMap[
                                                'box#1']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[1],
                                        initialDataTextFieldThree: variableMap[
                                                'box#1']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[2],
                                        initialDataTextFieldFour: variableMap[
                                                'box#1']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[3],
                                        initialDataTextFieldFive: variableMap[
                                                'box#1']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[4],
                                        initialDataTextFieldSix: variableMap[
                                                'box#1']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[5],
                                        onChangedTextFieldOne: (string) {
                                          onChangedBoxOneTimeSlotTextFieldOne(
                                              string, index);
                                        },
                                        // index == 0
                                        //     ? onChangedBoxOneTimeSlotOneTextFieldOne
                                        //     : index == 1
                                        //         ? onChangedBoxOneTimeSlotTwoTextFieldOne
                                        //         : index == 2
                                        //             ? onChangedBoxOneTimeSlotThreeTextFieldOne
                                        //             : index == 3
                                        //                 ? onChangedBoxOneTimeSlotFourTextFieldOne
                                        //                 : index == 4
                                        //                     ? onChangedBoxOneTimeSlotFiveTextFieldOne
                                        //                     : index == 5
                                        //                         ? onChangedBoxOneTimeSlotSixTextFieldOne
                                        //                         : (val) {},
                                        onChangedTextFieldTwo: (string) {
                                          onChangedBoxOneTimeSlotTextFieldTwo(
                                              string, index);
                                        },
                                        onChangedTextFieldThree: (string) {
                                          onChangedBoxOneTimeSlotTextFieldThree(
                                              string, index);
                                        },
                                        onChangedTextFieldFour: (string) {
                                          onChangedBoxOneTimeSlotTextFieldFour(
                                              string, index);
                                        },
                                        onChangedTextFieldFive: (string) {
                                          onChangedBoxOneTimeSlotTextFieldFive(
                                              string, index);
                                        },
                                        onChangedTextFieldSix: (string) {
                                          onChangedBoxOneTimeSlotTextFieldSix(
                                              string, index);
                                        },
                                      ),

                                      const SB(height: 5),

                                      Divider(
                                          color: CFGColor.lightGrey, height: 0),
                                    ],
                                  );
                                }),
                          ],
                        ),

                        //Box 2
                        Column(
                          children: [
                            //
                            FormTextField(
                              isUpdate: widget.isUpdate,
                              label: "",
                              hintText: "Type here",
                              textAlign: TextAlign.center,
                              hintTextSize: CFGFont.defaultFontSize,
                              inputTextSize: CFGFont.subTitleFontSize,
                              isRequired: false,
                              initialData: boxLabelMap[1],
                              onChangedText: onChangedBoxTwoLabel,
                            ),

                            const SB(height: 10),

                            ListView.builder(
                                itemCount:
                                    stateController.boxTimeSlotsHourly.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      //
                                      const SB(height: 5),

                                      FormBoxTimeSlotTableRow(
                                        isUpdate: widget.isUpdate,
                                        timeSlot: stateController
                                            .boxTimeSlotsHourly[index],
                                        initialDataTextFieldOne: variableMap[
                                                'box#2']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[0],
                                        initialDataTextFieldTwo: variableMap[
                                                'box#2']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[1],
                                        initialDataTextFieldThree: variableMap[
                                                'box#2']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[2],
                                        initialDataTextFieldFour: variableMap[
                                                'box#2']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[3],
                                        initialDataTextFieldFive: variableMap[
                                                'box#2']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[4],
                                        initialDataTextFieldSix: variableMap[
                                                'box#2']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[5],
                                        onChangedTextFieldOne: (string) {
                                          onChangedBoxTwoTimeSlotTextFieldOne(
                                              string, index);
                                        },
                                        onChangedTextFieldTwo: (string) {
                                          onChangedBoxTwoTimeSlotTextFieldTwo(
                                              string, index);
                                        },
                                        onChangedTextFieldThree: (string) {
                                          onChangedBoxTwoTimeSlotTextFieldThree(
                                              string, index);
                                        },
                                        onChangedTextFieldFour: (string) {
                                          onChangedBoxTwoTimeSlotTextFieldFour(
                                              string, index);
                                        },
                                        onChangedTextFieldFive: (string) {
                                          onChangedBoxTwoTimeSlotTextFieldFive(
                                              string, index);
                                        },
                                        onChangedTextFieldSix: (string) {
                                          onChangedBoxTwoTimeSlotTextFieldSix(
                                              string, index);
                                        },
                                      ),

                                      const SB(height: 5),

                                      Divider(
                                          color: CFGColor.lightGrey, height: 0),
                                    ],
                                  );
                                }),
                          ],
                        ),

                        //Box 3
                        Column(
                          children: [
                            //
                            FormTextField(
                              isUpdate: widget.isUpdate,
                              label: "",
                              hintText: "Type here",
                              textAlign: TextAlign.center,
                              hintTextSize: CFGFont.defaultFontSize,
                              inputTextSize: CFGFont.subTitleFontSize,
                              isRequired: false,
                              initialData: boxLabelMap[2],
                              onChangedText: onChangedBoxThreeLabel,
                            ),

                            const SB(height: 10),

                            ListView.builder(
                                itemCount:
                                    stateController.boxTimeSlotsHourly.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      //
                                      const SB(height: 5),

                                      FormBoxTimeSlotTableRow(
                                        isUpdate: widget.isUpdate,
                                        timeSlot: stateController
                                            .boxTimeSlotsHourly[index],
                                        initialDataTextFieldOne: variableMap[
                                                'box#3']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[0],
                                        initialDataTextFieldTwo: variableMap[
                                                'box#3']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[1],
                                        initialDataTextFieldThree: variableMap[
                                                'box#3']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[2],
                                        initialDataTextFieldFour: variableMap[
                                                'box#3']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[3],
                                        initialDataTextFieldFive: variableMap[
                                                'box#3']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[4],
                                        initialDataTextFieldSix: variableMap[
                                                'box#3']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[5],
                                        onChangedTextFieldOne: (string) {
                                          onChangedBoxThreeTimeSlotTextFieldOne(
                                              string, index);
                                        },
                                        onChangedTextFieldTwo: (string) {
                                          onChangedBoxThreeTimeSlotTextFieldTwo(
                                              string, index);
                                        },
                                        onChangedTextFieldThree: (string) {
                                          onChangedBoxThreeTimeSlotTextFieldThree(
                                              string, index);
                                        },
                                        onChangedTextFieldFour: (string) {
                                          onChangedBoxThreeTimeSlotTextFieldFour(
                                              string, index);
                                        },
                                        onChangedTextFieldFive: (string) {
                                          onChangedBoxThreeTimeSlotTextFieldFive(
                                              string, index);
                                        },
                                        onChangedTextFieldSix: (string) {
                                          onChangedBoxThreeTimeSlotTextFieldSix(
                                              string, index);
                                        },
                                      ),

                                      const SB(height: 5),

                                      Divider(
                                          color: CFGColor.lightGrey, height: 0),
                                    ],
                                  );
                                }),
                          ],
                        ),

                        //Box 4
                        Column(
                          children: [
                            //
                            FormTextField(
                              isUpdate: widget.isUpdate,
                              label: "",
                              hintText: "Type here",
                              textAlign: TextAlign.center,
                              hintTextSize: CFGFont.defaultFontSize,
                              inputTextSize: CFGFont.subTitleFontSize,
                              isRequired: false,
                              initialData: boxLabelMap[3],
                              onChangedText: onChangedBoxFourLabel,
                            ),

                            const SB(height: 10),

                            ListView.builder(
                                itemCount:
                                    stateController.boxTimeSlotsHourly.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      //
                                      const SB(height: 5),

                                      FormBoxTimeSlotTableRow(
                                        isUpdate: widget.isUpdate,
                                        timeSlot: stateController
                                            .boxTimeSlotsHourly[index],
                                        initialDataTextFieldOne: variableMap[
                                                'box#4']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[0],
                                        initialDataTextFieldTwo: variableMap[
                                                'box#4']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[1],
                                        initialDataTextFieldThree: variableMap[
                                                'box#4']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[2],
                                        initialDataTextFieldFour: variableMap[
                                                'box#4']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[3],
                                        initialDataTextFieldFive: variableMap[
                                                'box#4']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[4],
                                        initialDataTextFieldSix: variableMap[
                                                'box#4']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[5],
                                        onChangedTextFieldOne: (string) {
                                          onChangedBoxFourTimeSlotTextFieldOne(
                                              string, index);
                                        },
                                        onChangedTextFieldTwo: (string) {
                                          onChangedBoxFourTimeSlotTextFieldTwo(
                                              string, index);
                                        },
                                        onChangedTextFieldThree: (string) {
                                          onChangedBoxFourTimeSlotTextFieldThree(
                                              string, index);
                                        },
                                        onChangedTextFieldFour: (string) {
                                          onChangedBoxFourTimeSlotTextFieldFour(
                                              string, index);
                                        },
                                        onChangedTextFieldFive: (string) {
                                          onChangedBoxFourTimeSlotTextFieldFive(
                                              string, index);
                                        },
                                        onChangedTextFieldSix: (string) {
                                          onChangedBoxFourTimeSlotTextFieldSix(
                                              string, index);
                                        },
                                      ),

                                      const SB(height: 5),

                                      Divider(
                                          color: CFGColor.lightGrey, height: 0),
                                    ],
                                  );
                                }),
                          ],
                        ),

                        //Box 5
                        Column(
                          children: [
                            //
                            FormTextField(
                              isUpdate: widget.isUpdate,
                              label: "",
                              hintText: "Type here",
                              textAlign: TextAlign.center,
                              hintTextSize: CFGFont.defaultFontSize,
                              inputTextSize: CFGFont.subTitleFontSize,
                              isRequired: false,
                              initialData: boxLabelMap[4],
                              onChangedText: onChangedBoxFiveLabel,
                            ),

                            const SB(height: 10),

                            ListView.builder(
                                itemCount:
                                    stateController.boxTimeSlotsHourly.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      //
                                      const SB(height: 5),

                                      FormBoxTimeSlotTableRow(
                                        isUpdate: widget.isUpdate,
                                        timeSlot: stateController
                                            .boxTimeSlotsHourly[index],
                                        initialDataTextFieldOne: variableMap[
                                                'box#5']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[0],
                                        initialDataTextFieldTwo: variableMap[
                                                'box#5']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[1],
                                        initialDataTextFieldThree: variableMap[
                                                'box#5']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[2],
                                        initialDataTextFieldFour: variableMap[
                                                'box#5']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[3],
                                        initialDataTextFieldFive: variableMap[
                                                'box#5']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[4],
                                        initialDataTextFieldSix: variableMap[
                                                'box#5']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[5],
                                        onChangedTextFieldOne: (string) {
                                          onChangedBoxFiveTimeSlotTextFieldOne(
                                              string, index);
                                        },
                                        onChangedTextFieldTwo: (string) {
                                          onChangedBoxFiveTimeSlotTextFieldTwo(
                                              string, index);
                                        },
                                        onChangedTextFieldThree: (string) {
                                          onChangedBoxFiveTimeSlotTextFieldThree(
                                              string, index);
                                        },
                                        onChangedTextFieldFour: (string) {
                                          onChangedBoxFiveTimeSlotTextFieldFour(
                                              string, index);
                                        },
                                        onChangedTextFieldFive: (string) {
                                          onChangedBoxFiveTimeSlotTextFieldFive(
                                              string, index);
                                        },
                                        onChangedTextFieldSix: (string) {
                                          onChangedBoxFiveTimeSlotTextFieldSix(
                                              string, index);
                                        },
                                      ),

                                      const SB(height: 5),

                                      Divider(
                                          color: CFGColor.lightGrey, height: 0),
                                    ],
                                  );
                                }),
                          ],
                        ),

                        //Box 6
                        Column(
                          children: [
                            //
                            FormTextField(
                              isUpdate: widget.isUpdate,
                              label: "",
                              hintText: "Type here",
                              textAlign: TextAlign.center,
                              hintTextSize: CFGFont.defaultFontSize,
                              inputTextSize: CFGFont.subTitleFontSize,
                              isRequired: false,
                              initialData: boxLabelMap[5],
                              onChangedText: onChangedBoxSixLabel,
                            ),

                            const SB(height: 10),

                            ListView.builder(
                                itemCount:
                                    stateController.boxTimeSlotsHourly.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      //
                                      const SB(height: 5),

                                      FormBoxTimeSlotTableRow(
                                        isUpdate: widget.isUpdate,
                                        timeSlot: stateController
                                            .boxTimeSlotsHourly[index],
                                        initialDataTextFieldOne: variableMap[
                                                'box#6']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[0],
                                        initialDataTextFieldTwo: variableMap[
                                                'box#6']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[1],
                                        initialDataTextFieldThree: variableMap[
                                                'box#6']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[2],
                                        initialDataTextFieldFour: variableMap[
                                                'box#6']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[3],
                                        initialDataTextFieldFive: variableMap[
                                                'box#6']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[4],
                                        initialDataTextFieldSix: variableMap[
                                                'box#6']?[
                                            stateController
                                                .boxTimeSlotsHourly[index]]?[5],
                                        onChangedTextFieldOne: (string) {
                                          onChangedBoxSixTimeSlotTextFieldOne(
                                              string, index);
                                        },
                                        onChangedTextFieldTwo: (string) {
                                          onChangedBoxSixTimeSlotTextFieldTwo(
                                              string, index);
                                        },
                                        onChangedTextFieldThree: (string) {
                                          onChangedBoxSixTimeSlotTextFieldThree(
                                              string, index);
                                        },
                                        onChangedTextFieldFour: (string) {
                                          onChangedBoxSixTimeSlotTextFieldFour(
                                              string, index);
                                        },
                                        onChangedTextFieldFive: (string) {
                                          onChangedBoxSixTimeSlotTextFieldFive(
                                              string, index);
                                        },
                                        onChangedTextFieldSix: (string) {
                                          onChangedBoxSixTimeSlotTextFieldSix(
                                              string, index);
                                        },
                                      ),

                                      const SB(height: 5),

                                      Divider(
                                          color: CFGColor.lightGrey, height: 0),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),

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
      ),
    ));
  }
}
