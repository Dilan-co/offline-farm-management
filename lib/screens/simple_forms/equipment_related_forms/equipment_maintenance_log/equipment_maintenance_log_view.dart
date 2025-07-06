import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/org/org_equipment.dart';
import 'package:farm_management/models/table_models/org/org_equipment_model.dart';
import 'package:farm_management/models/table_models/simple_forms/equipment_related_forms/equipment_maintenance_log_model.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_form_view_signature_row.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class EquipmentMaintenanceLogView extends StatefulWidget {
  final String updateRouter;
  final EquipmentMaintenanceLogModel data;
  final Function(bool, EquipmentMaintenanceLogModel) onDelete;
  const EquipmentMaintenanceLogView({
    super.key,
    required this.updateRouter,
    required this.data,
    required this.onDelete,
  });

  @override
  State<EquipmentMaintenanceLogView> createState() =>
      _EquipmentMaintenanceLogViewState();
}

class _EquipmentMaintenanceLogViewState
    extends State<EquipmentMaintenanceLogView> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecordData();
    });
  }

  OrgEquipmentModel? equipmentData;

  String? clientName;
  String? equipmentName;
  String? assetId;

  Future<bool> loadRecordData() async {
    try {
      //Loading Equipment data by equipment_id
      equipmentData =
          await OrgEquipment().fetchById(equipmentId: widget.data.equipmentId);
      if (equipmentData != null) {
        assetId = "${equipmentData!.name} - ${equipmentData!.label}";
      }
      clientName =
          getValueForKey(widget.data.client, stateController.clientList);
      equipmentName = getValueForKey(
          widget.data.equipmentId, stateController.equipmentNameList);
      debugPrint('Client Name: $clientName');
      debugPrint('Equipment Name: $equipmentName');
      debugPrint('Asset ID: $assetId');
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
        appBar:
            SimpleFormsAppBar(title: "Equipment Maintenance Log", isView: true),
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
                child: ListView(
                  children: [
                    //
                    const SB(height: 10),

                    FormViewTextRow(
                      label: "Client",
                      data: clientName,
                    ),
                    FormViewTextRow(
                      label: "Asset ID",
                      data: assetId,
                    ),
                    FormViewTextRow(
                      label: "Asset Name",
                      data: equipmentName,
                    ),
                    FormViewTextRow(
                      label: "Problem",
                      data: widget.data.problem,
                    ),

                    FormViewTextRow(
                      label: "Priority",
                      data: widget.data.priority,
                      dataInRed: true,
                      dataBold: true,
                    ),

                    FormViewTextRow(
                      label: "Date Identified",
                      data: widget.data.dateIdentified,
                    ),
                    FormViewTextRow(
                      label: "Date Maintenance",
                      data: widget.data.dateMaintenance,
                    ),

                    FormViewTextRow(
                      label: "Media",
                      data: widget.data.media,
                      isImage: true,
                      imageFileName: widget.data.media,
                    ),

                    FormViewTextRow(
                      label: "Action Taken",
                      data: widget.data.actionTaken,
                    ),
                    FormViewTextRow(
                      label: "External Contractor",
                      data: widget.data.externalContractor,
                    ),
                    FormViewTextRow(
                      label: "External Contractor Details",
                      data: widget.data.externalContractorDetails,
                    ),
                    FormViewTextRow(
                      label: "Date Completed",
                      data: widget.data.dateCompleted,
                    ),
                    FormViewTextRow(
                      label: "Equipment Cleaned",
                      data: widget.data.equipmentCleaned,
                    ),
                    FormViewTextRow(
                      label: "Area Released By",
                      data: widget.data.areaReleasedBy,
                    ),
                    FormViewTextRow(
                      label: "Corrective Action",
                      data: widget.data.correctiveAction,
                    ),
                    FormViewTextRow(
                      label: "Comment",
                      data: widget.data.comment,
                    ),

                    FormViewTextRow(
                      label: "Deleted",
                      data: widget.data.deleted == 1 ? "YES" : "NO",
                    ),

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

                    const SB(height: 10),

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
                                  shape: const WidgetStatePropertyAll(
                                      CircleBorder())),
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
                                  shape: const WidgetStatePropertyAll(
                                      CircleBorder())),
                              onPressed: () {
                                // Get.to(() => SimpleFormsDelete());

                                showDialog(
                                  barrierDismissible: true,
                                  barrierColor: const Color(0x60000000),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      elevation: 0,
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      backgroundColor: CFGTheme.bgColorScreen,
                                      titlePadding:
                                          const EdgeInsets.only(top: 30),
                                      contentPadding: const EdgeInsets.only(
                                          top: 15, bottom: 30),
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
                                            minWidth:
                                                mediaQuerySize.width * 0.3),
                                        child: Text(
                                          "Are you sure?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize:
                                                CFGFont.smallTitleFontSize,
                                            fontWeight:
                                                CFGFont.regularFontWeight,
                                            color: CFGFont.defaultFontColor,
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          style: ButtonStyle(
                                            fixedSize:
                                                const WidgetStatePropertyAll(
                                                    Size(80, 40)),
                                            overlayColor:
                                                WidgetStatePropertyAll(
                                                    CFGTheme.buttonOverlay),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    CFGTheme.button),
                                            shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          CFGTheme
                                                              .buttonRadius)),
                                            ),
                                          ),
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                              height: 0,
                                              fontSize: CFGFont.defaultFontSize,
                                              fontWeight:
                                                  CFGFont.mediumFontWeight,
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
                                            fixedSize:
                                                const WidgetStatePropertyAll(
                                                    Size(80, 40)),
                                            overlayColor:
                                                WidgetStatePropertyAll(
                                                    CFGTheme.buttonOverlay),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    CFGColor.lightGrey),
                                            shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          CFGTheme
                                                              .buttonRadius)),
                                            ),
                                          ),
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                              height: 0,
                                              fontSize: CFGFont.defaultFontSize,
                                              fontWeight:
                                                  CFGFont.mediumFontWeight,
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
              );
            }),
      ),
    );
  }
}
