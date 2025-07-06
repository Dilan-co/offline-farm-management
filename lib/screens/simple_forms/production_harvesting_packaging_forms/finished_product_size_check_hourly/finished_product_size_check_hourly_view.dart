import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/crop/crop_client_crop_variety.dart';
import 'package:farm_management/models/table_models/crop/crop_client_crop_variety_model.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/finished_product_size_check_hourly_model.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/form_view_box_time_slot_table_row.dart';
import 'package:farm_management/widgets/simple_form_view_signature_row.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class FinishedProductSizeCheckHourlyView extends StatefulWidget {
  final String updateRouter;
  final FinishedProductSizeCheckHourlyModel data;
  final Function(bool, FinishedProductSizeCheckHourlyModel) onDelete;
  const FinishedProductSizeCheckHourlyView({
    super.key,
    required this.updateRouter,
    required this.data,
    required this.onDelete,
  });

  @override
  State<FinishedProductSizeCheckHourlyView> createState() =>
      _FinishedProductSizeCheckHourlyViewState();
}

class _FinishedProductSizeCheckHourlyViewState
    extends State<FinishedProductSizeCheckHourlyView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  final StateController stateController = Get.find();

  Map<int, String?> boxLabelMap = {};
  Map<String?, Map<String?, Map<int, String?>>> variableMap = {};

  String? clientName;
  String? farmName;
  String? cropName;
  String? varietyName;

  @override
  void initState() {
    super.initState();
    sizeCheckVariableGenerator();
    //Load Data from IDs
    loadRecordData();

    tabController = TabController(
      initialIndex: selectedIndex,
      length: 6,
      vsync: this,
    );
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

  Future<bool> loadRecordData() async {
    try {
      final hourlySizeCheckMap = jsonDecode(widget.data.hourlySizeCheck ?? "");
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
      //Load Variety Data
      CropClientCropVarietyModel varietyData = await CropClientCropVariety()
          .fetchByVarietyId(varietyId: widget.data.variety);
      setState(() {
        varietyName = varietyData.name;
      });
      debugPrint(varietyName);

      clientName =
          getValueForKey(widget.data.client, stateController.clientList);
      farmName = getValueForKey(widget.data.farm, stateController.farmList);
      cropName = getValueForKey(widget.data.crop, stateController.cropList);
      debugPrint(clientName);
      debugPrint(farmName);
      debugPrint(cropName);
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  // GlobalKey _childKey = GlobalKey();
  // double _childHeight = 0.0;

  late TabController tabController;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    debugPrint(widget.updateRouter);
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(
            title: "Finished Product Size Check (Hourly)", isView: true),
        //
        body: Padding(
          padding: EdgeInsets.only(
            left: CFGTheme.bodyLRPadding,
            right: CFGTheme.bodyLRPadding,
            // top: CFGTheme.bodyTBPadding,
            bottom: CFGTheme.bodyTBPadding,
          ),
          child: ListView(
            children: [
              //
              const SB(height: 10),

              FormViewTextRow(
                label: "Client",
                data: clientName,
              ),
              FormViewTextRow(
                label: "Farm",
                data: farmName,
              ),
              FormViewTextRow(
                label: "Crop",
                data: cropName,
              ),
              FormViewTextRow(
                label: "Variety",
                data: varietyName,
              ),
              FormViewTextRow(
                label: "Date",
                data: widget.data.date,
              ),
              FormViewTextRow(
                label: "Measurement Unit",
                data: widget.data.measurementUnit,
              ),

              FormViewTextRow(
                label: "Comment",
                data: widget.data.comment,
              ),

              //------------------- Box Time Slot Table -------------------

              const SB(height: 20),

              Divider(color: CFGColor.lightGrey, height: 0),

              TabBar(
                controller: tabController,
                onTap: (int index) {
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
                height: (130 * stateController.boxTimeSlotsHourly.length)
                    .toDouble(),
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //Box 1
                    Column(
                      children: [
                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: mediaQuerySize.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(CFGTheme.cardRadius),
                              border: Border.all(
                                color: CFGColor.midGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(boxLabelMap[0] ?? "",
                                  style: TextStyle(
                                    // height: extendTextHeight ? 2.2 : null,
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.regularFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  )),
                            ),
                          ),
                        ),

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

                                  FormViewBoxTimeSlotTableRow(
                                    timeSlot: stateController
                                        .boxTimeSlotsHourly[index],
                                    //set below data according to "index"
                                    dataOne: variableMap['box#1']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[0],
                                    dataTwo: variableMap['box#1']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[1],
                                    dataThree: variableMap['box#1']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[2],
                                    dataFour: variableMap['box#1']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[3],
                                    dataFive: variableMap['box#1']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[4],
                                    dataSix: variableMap['box#1']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[5],
                                  ),

                                  const SB(height: 5),

                                  Divider(color: CFGColor.lightGrey, height: 0),
                                ],
                              );
                            }),
                      ],
                    ),

                    //Box 2
                    Column(
                      children: [
                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: mediaQuerySize.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(CFGTheme.cardRadius),
                              border: Border.all(
                                color: CFGColor.midGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(boxLabelMap[1] ?? "",
                                  style: TextStyle(
                                    // height: extendTextHeight ? 2.2 : null,
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.regularFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  )),
                            ),
                          ),
                        ),

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

                                  FormViewBoxTimeSlotTableRow(
                                    timeSlot: stateController
                                        .boxTimeSlotsHourly[index],
                                    //set below data according to "index"
                                    dataOne: variableMap['box#2']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[0],
                                    dataTwo: variableMap['box#2']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[1],
                                    dataThree: variableMap['box#2']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[2],
                                    dataFour: variableMap['box#2']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[3],
                                    dataFive: variableMap['box#2']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[4],
                                    dataSix: variableMap['box#2']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[5],
                                  ),

                                  const SB(height: 5),

                                  Divider(color: CFGColor.lightGrey, height: 0),
                                ],
                              );
                            }),
                      ],
                    ),

                    //Box 3
                    Column(
                      children: [
                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: mediaQuerySize.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(CFGTheme.cardRadius),
                              border: Border.all(
                                color: CFGColor.midGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(boxLabelMap[2] ?? "",
                                  style: TextStyle(
                                    // height: extendTextHeight ? 2.2 : null,
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.regularFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  )),
                            ),
                          ),
                        ),

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

                                  FormViewBoxTimeSlotTableRow(
                                    timeSlot: stateController
                                        .boxTimeSlotsHourly[index],
                                    //set below data according to "index"
                                    dataOne: variableMap['box#3']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[0],
                                    dataTwo: variableMap['box#3']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[1],
                                    dataThree: variableMap['box#3']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[2],
                                    dataFour: variableMap['box#3']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[3],
                                    dataFive: variableMap['box#3']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[4],
                                    dataSix: variableMap['box#3']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[5],
                                  ),

                                  const SB(height: 5),

                                  Divider(color: CFGColor.lightGrey, height: 0),
                                ],
                              );
                            }),
                      ],
                    ),

                    //Box 4
                    Column(
                      children: [
                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: mediaQuerySize.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(CFGTheme.cardRadius),
                              border: Border.all(
                                color: CFGColor.midGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(boxLabelMap[3] ?? "",
                                  style: TextStyle(
                                    // height: extendTextHeight ? 2.2 : null,
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.regularFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  )),
                            ),
                          ),
                        ),

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

                                  FormViewBoxTimeSlotTableRow(
                                    timeSlot: stateController
                                        .boxTimeSlotsHourly[index],
                                    //set below data according to "index"
                                    dataOne: variableMap['box#4']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[0],
                                    dataTwo: variableMap['box#4']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[1],
                                    dataThree: variableMap['box#4']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[2],
                                    dataFour: variableMap['box#4']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[3],
                                    dataFive: variableMap['box#4']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[4],
                                    dataSix: variableMap['box#4']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[5],
                                  ),

                                  const SB(height: 5),

                                  Divider(color: CFGColor.lightGrey, height: 0),
                                ],
                              );
                            }),
                      ],
                    ),

                    //Box 5
                    Column(
                      children: [
                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: mediaQuerySize.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(CFGTheme.cardRadius),
                              border: Border.all(
                                color: CFGColor.midGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(boxLabelMap[4] ?? "",
                                  style: TextStyle(
                                    // height: extendTextHeight ? 2.2 : null,
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.regularFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  )),
                            ),
                          ),
                        ),

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

                                  FormViewBoxTimeSlotTableRow(
                                    timeSlot: stateController
                                        .boxTimeSlotsHourly[index],
                                    //set below data according to "index"
                                    dataOne: variableMap['box#5']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[0],
                                    dataTwo: variableMap['box#5']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[1],
                                    dataThree: variableMap['box#5']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[2],
                                    dataFour: variableMap['box#5']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[3],
                                    dataFive: variableMap['box#5']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[4],
                                    dataSix: variableMap['box#5']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[5],
                                  ),

                                  const SB(height: 5),

                                  Divider(color: CFGColor.lightGrey, height: 0),
                                ],
                              );
                            }),
                      ],
                    ),

                    //Box 6
                    Column(
                      children: [
                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: mediaQuerySize.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(CFGTheme.cardRadius),
                              border: Border.all(
                                color: CFGColor.midGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(boxLabelMap[5] ?? "",
                                  style: TextStyle(
                                    // height: extendTextHeight ? 2.2 : null,
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.regularFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  )),
                            ),
                          ),
                        ),

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

                                  FormViewBoxTimeSlotTableRow(
                                    timeSlot: stateController
                                        .boxTimeSlotsHourly[index],
                                    //set below data according to "index"
                                    dataOne: variableMap['box#6']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[0],
                                    dataTwo: variableMap['box#6']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[1],
                                    dataThree: variableMap['box#6']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[2],
                                    dataFour: variableMap['box#6']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[3],
                                    dataFive: variableMap['box#6']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[4],
                                    dataSix: variableMap['box#6']?[
                                        stateController
                                            .boxTimeSlotsHourly[index]]?[5],
                                  ),

                                  const SB(height: 5),

                                  Divider(color: CFGColor.lightGrey, height: 0),
                                ],
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),

              const SB(height: 20),

              FormViewTextRow(
                label: "Last Modified By",
                data: widget.data.updatedBy ?? widget.data.createdBy,
              ),
              FormViewTextRow(
                label: "Last Modified On",
                data: widget.data.updatedAt ?? widget.data.createdAt,
              ),
              FormViewSignatureRow(
                label: "Signature",
                signatureFileName: widget.data.signature,
              ),

              //
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SB(
                      height: 36,
                      width: 36,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                CFGTheme.bgColorScreen),
                            shape:
                                const WidgetStatePropertyAll(CircleBorder())),
                        onPressed: () {
                          Get.toNamed(
                            widget.updateRouter,
                            arguments: widget.data,
                          );
                        },
                        icon: SvgPicture.asset(
                          CFGImage.edit,
                          colorFilter: ColorFilter.mode(
                              CFGTheme.button, BlendMode.srcIn),
                          // color: Colors.white,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),

                    //
                    const SB(width: 20),

                    SB(
                      height: 36,
                      width: 36,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                CFGTheme.bgColorScreen),
                            shape:
                                const WidgetStatePropertyAll(CircleBorder())),
                        onPressed: () {
                          // Get.to(() => SimpleFormsDelete());

                          showDialog(
                            barrierDismissible: true,
                            barrierColor: const Color(0x60000000),
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                elevation: 0,
                                actionsAlignment: MainAxisAlignment.center,
                                backgroundColor: CFGTheme.bgColorScreen,
                                titlePadding: const EdgeInsets.only(top: 30),
                                contentPadding:
                                    const EdgeInsets.only(top: 15, bottom: 30),
                                // actionsPadding: const EdgeInsets.only(bottom: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        CFGTheme.cardRadius)),
                                title: Text(
                                  "Delete",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: CFGFont.titleFontSize,
                                    fontWeight: CFGFont.mediumFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  ),
                                ),
                                content: Container(
                                  constraints: BoxConstraints(
                                      minWidth: mediaQuerySize.width * 0.3),
                                  child: Text(
                                    "Are you sure?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: CFGFont.smallTitleFontSize,
                                      fontWeight: CFGFont.regularFontWeight,
                                      color: CFGFont.defaultFontColor,
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: ButtonStyle(
                                      fixedSize: const WidgetStatePropertyAll(
                                          Size(80, 40)),
                                      overlayColor: WidgetStatePropertyAll(
                                          CFGTheme.buttonOverlay),
                                      backgroundColor: WidgetStatePropertyAll(
                                          CFGTheme.button),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                CFGTheme.buttonRadius)),
                                      ),
                                    ),
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        height: 0,
                                        fontSize: CFGFont.defaultFontSize,
                                        fontWeight: CFGFont.mediumFontWeight,
                                        color: CFGFont.whiteFontColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      widget.onDelete(true, widget.data);
                                      Get.close(2);
                                    },
                                  ),

                                  const SB(width: 10),

                                  //
                                  TextButton(
                                    style: ButtonStyle(
                                      fixedSize: const WidgetStatePropertyAll(
                                          Size(80, 40)),
                                      overlayColor: WidgetStatePropertyAll(
                                          CFGTheme.buttonOverlay),
                                      backgroundColor: WidgetStatePropertyAll(
                                          CFGColor.lightGrey),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                CFGTheme.buttonRadius)),
                                      ),
                                    ),
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        height: 0,
                                        fontSize: CFGFont.defaultFontSize,
                                        fontWeight: CFGFont.mediumFontWeight,
                                        color: CFGFont.defaultFontColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: SvgPicture.asset(
                          CFGImage.delete,
                          colorFilter: ColorFilter.mode(
                              CFGTheme.button, BlendMode.srcIn),
                          // color: Colors.white,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
