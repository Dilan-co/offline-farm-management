import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/models/table_models/simple_forms/production_harvesting_packaging_forms/product_batch_label_assessment_model.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_form_view_signature_row.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class ProductBatchLabelAssessmentView extends StatelessWidget {
  final String updateRouter;
  final ProductionBatchLabelAssessmentModel data;
  final Function(bool, ProductionBatchLabelAssessmentModel) onDelete;
  const ProductBatchLabelAssessmentView({
    super.key,
    required this.updateRouter,
    required this.data,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final StateController stateController = Get.find();
    debugPrint(updateRouter);
    Size mediaQuerySize = MediaQuery.of(context).size;

    String? clientName;
    String? farmName;
    String? cropName;

    Future<bool> loadRecordData() async {
      try {
        clientName = getValueForKey(data.client, stateController.clientList);
        farmName = getValueForKey(data.farm, stateController.farmList);
        cropName = getValueForKey(data.crop, stateController.cropList);
        debugPrint(clientName);
        debugPrint(farmName);
        debugPrint(cropName);
        return true;
      } catch (e) {
        debugPrint('Error loading data: $e');
        return false;
      }
    }

    //Load Data from IDs
    loadRecordData();

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
              title: "Production Batch Label Assessments", isView: true),
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
                  label: "Production Batch No",
                  data: data.productionBatchNumber,
                ),
                FormViewTextRow(
                  label: "Variety",
                  data: data.variety,
                ),
                FormViewTextRow(
                  label: "Pack Date",
                  data: data.packDate,
                ),
                FormViewTextRow(
                  label: "Start Time",
                  data: data.startTime,
                ),
                FormViewTextRow(
                  label: "End Time",
                  data: data.endTime,
                ),

                //Sample 01
                const SB(height: 20),

                Divider(color: CFGColor.lightGrey, height: 0),

                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("SAMPLE O1",
                      style: TextStyle(
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                ),

                Divider(color: CFGColor.lightGrey, height: 0),

                const SB(height: 10),

                FormViewTextRow(
                  label: "Label",
                  data: data.labelSampleOne,
                  isImage: true,
                  imageFileName: data.labelSampleOne,
                ),
                FormViewTextRow(
                  label: "Pack Date",
                  data: data.packDateOne,
                ),
                FormViewTextRow(
                  label: "Best Before Date",
                  data: data.bestBeforeDateOne,
                ),
                FormViewTextRow(
                  label: "Label Position",
                  data: data.labelPositionOne == 1 ? "YES" : "NO",
                ),
                FormViewTextRow(
                  label: "Label Legible",
                  data: data.labelLegibleOne == 1 ? "YES" : "NO",
                ),

                //Sample 02
                const SB(height: 20),

                Divider(color: CFGColor.lightGrey, height: 0),

                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("SAMPLE O2",
                      style: TextStyle(
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                ),

                Divider(color: CFGColor.lightGrey, height: 0),

                const SB(height: 10),
                FormViewTextRow(
                  label: "Label",
                  data: data.labelSampleTwo,
                  isImage: true,
                  imageFileName: data.labelSampleTwo,
                ),
                FormViewTextRow(
                  label: "Pack Date",
                  data: data.packDateTwo,
                ),
                FormViewTextRow(
                  label: "Best Before Date",
                  data: data.bestBeforeDateTwo,
                ),
                FormViewTextRow(
                  label: "Label Position",
                  data: data.labelPositionTwo == 1 ? "YES" : "NO",
                ),
                FormViewTextRow(
                  label: "Label Legible",
                  data: data.labelLegibleTwo == 1 ? "YES" : "NO",
                ),

                //
                const SB(height: 20),

                FormViewTextRow(
                    label: "Corrective Action", data: data.correctiveAction),
                FormViewTextRow(label: "Comment", data: data.comment),
                FormViewTextRow(
                    label: "Last Modified By",
                    data: data.updatedBy ?? data.createdBy),
                FormViewTextRow(
                    label: "Last Modified On",
                    data: data.updatedAt ?? data.createdAt),
                FormViewSignatureRow(
                  label: "Signature",
                  signatureFileName: data.signature,
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
                              updateRouter,
                              arguments: data,
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
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                        onDelete(true, data);
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
                                              borderRadius:
                                                  BorderRadius.circular(
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
      ),
    );
  }
}
