import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/finished_product_weight_check_hourly_model.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/form_view_time_slot_table_row.dart';
import 'package:farm_management/widgets/simple_form_view_signature_row.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class FinishedProductWeightCheckHourlyView extends StatefulWidget {
  final String updateRouter;
  final FinishedProductWeightCheckHourlyModel data;
  final Function(bool, FinishedProductWeightCheckHourlyModel) onDelete;
  const FinishedProductWeightCheckHourlyView({
    super.key,
    required this.updateRouter,
    required this.data,
    required this.onDelete,
  });

  @override
  State<FinishedProductWeightCheckHourlyView> createState() =>
      _FinishedProductWeightCheckHourlyViewState();
}

class _FinishedProductWeightCheckHourlyViewState
    extends State<FinishedProductWeightCheckHourlyView> {
  final StateController stateController = Get.find();
  Map<String?, Map<String, String?>> variableMap = {
    'grossWeight': {},
    'correctiveAction': {},
    'comment': {},
  };
  String? clientName;
  String? farmName;
  String? cropName;

  @override
  void initState() {
    super.initState();
    //Load Data from IDs
    loadRecordData();
  }

  Future<bool> loadRecordData() async {
    try {
      // String a =
      //     '{\"06:00-07:00\":{\"id\":\"06:00-07:00\",\"start_time\":\"06:00\",\"end_time\":\"07:00\",\"weight\":\"10.6\",\"corrective_action\":\"Repacked\",\"comment\":\"\"},\"07:00-08:00\":{\"id\":\"07:00-08:00\",\"start_time\":\"07:00\",\"end_time\":\"08:00\",\"weight\":\"10.8\",\"corrective_action\":\"\",\"comment\":\"\"},\"08:00-09:00\":{\"id\":\"08:00-09:00\",\"start_time\":\"08:00\",\"end_time\":\"09:00\",\"weight\":\"11\",\"corrective_action\":\"\",\"comment\":\"\"},\"09:00-10:00\":{\"id\":\"09:00-10:00\",\"start_time\":\"09:00\",\"end_time\":\"10:00\",\"weight\":\"10.98\",\"corrective_action\":\"\",\"comment\":\"\"},\"10:00-11:00\":{\"id\":\"10:00-11:00\",\"start_time\":\"10:00\",\"end_time\":\"11:00\",\"weight\":\"\",\"corrective_action\":\"\",\"comment\":\"\"},\"11:00-12:00\":{\"id\":\"11:00-12:00\",\"start_time\":\"11:00\",\"end_time\":\"12:00\",\"weight\":\"\",\"corrective_action\":\"\",\"comment\":\"\"},\"12:00-13:00\":{\"id\":\"12:00-13:00\",\"start_time\":\"12:00\",\"end_time\":\"13:00\",\"weight\":\"\",\"corrective_action\":\"\",\"comment\":\"\"},\"13:00-14:00\":{\"id\":\"13:00-14:00\",\"start_time\":\"13:00\",\"end_time\":\"14:00\",\"weight\":\"\",\"corrective_action\":\"\",\"comment\":\"\"},\"14:00-15:00\":{\"id\":\"14:00-15:00\",\"start_time\":\"14:00\",\"end_time\":\"15:00\",\"weight\":\"\",\"corrective_action\":\"\",\"comment\":\"\"},\"15:00-16:00\":{\"id\":\"15:00-16:00\",\"start_time\":\"15:00\",\"end_time\":\"16:00\",\"weight\":\"\",\"corrective_action\":\"\",\"comment\":\"\"},\"16:00-17:00\":{\"id\":\"16:00-17:00\",\"start_time\":\"16:00\",\"end_time\":\"17:00\",\"weight\":\"\",\"corrective_action\":\"\",\"comment\":\"\"}}';
      final hourlyWeightCheckMap =
          await jsonDecode(widget.data.hourlyWeightCheck ?? "");
      debugPrint("Raw Data Map --> ${widget.data.hourlyWeightCheck}");
      debugPrint("$hourlyWeightCheckMap");
      for (var data in hourlyWeightCheckMap.entries) {
        // debugPrint("${data.value['id']}");
        setState(() {
          variableMap['grossWeight']![data.value['id']] = data.value['weight'];
          variableMap['correctiveAction']![data.value['id']] =
              data.value['corrective_action'];
          variableMap['comment']![data.value['id']] = data.value['comment'];
        });
      }
      debugPrint("$variableMap");
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

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.updateRouter);
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(
            title: "Finished Product Weight Check (Hourly)", isView: true),
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
                label: "Date",
                data: widget.data.date,
              ),
              FormViewTextRow(
                label: "Net Weight",
                data: widget.data.netWeight,
              ),
              FormViewTextRow(
                label: "Packaging Tare Weight",
                data: widget.data.packagingTareWeight,
              ),
              FormViewTextRow(
                label: "Minimum Gross Weight",
                data: widget.data.minimumGrossWeight,
              ),
              FormViewTextRow(
                label: "Packing Line",
                data: widget.data.packingLine,
              ),

              FormViewTextRow(
                label: "Comment",
                data: widget.data.comment,
              ),

              const SB(height: 20),

              //Time Slot Table
              ListView.builder(
                  itemCount: stateController.timeSlotsHourly.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        //
                        const SB(height: 5),

                        Divider(color: CFGColor.lightGrey, height: 0),

                        const SB(height: 5),

                        FormViewTimeSlotTableRow(
                          timeSlot: stateController.timeSlotsHourly[index],
                          firstFieldLabel: "Gross Weight",
                          firstFieldLabelData: variableMap['grossWeight']
                              ?[stateController.timeSlotsHourly[index]],
                          secondFieldLabel: "Corrective Action",
                          secondFieldLabelData: variableMap['correctiveAction']
                              ?[stateController.timeSlotsHourly[index]],
                          thirdFieldLabel: "Comment",
                          thirdFieldLabelData: variableMap['comment']
                              ?[stateController.timeSlotsHourly[index]],
                        ),
                      ],
                    );
                  }),

              const SB(height: 5),

              Divider(color: CFGColor.lightGrey, height: 0),

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
