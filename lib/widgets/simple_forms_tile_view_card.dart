import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class SimpleFormsTileViewCard extends StatelessWidget {
  final dynamic dataObject;
  final Function(bool, dynamic)? onDelete;
  final String mainTileRouter;
  final String viewRouter;
  final String updateRouter;
  final String deleteRouter;
  final String lastModifiedDate;
  final bool lastModifiedDateHidden;
  final String textFieldOneLabel;
  final String textFieldTwoLabel;
  final String textFieldThreeLabel;
  final String textFieldFourLabel;
  final String textFieldOneData;
  final String textFieldTwoData;
  final String textFieldThreeData;
  final String textFieldFourData;
  final int? textFieldFourMaxLines;
  final bool viewButtonHidden;
  final bool editButtonHidden;
  final bool deleteButtonHidden;
  final bool isTaskCompleted;

  const SimpleFormsTileViewCard({
    super.key,
    required this.dataObject,
    this.onDelete,
    this.mainTileRouter = "",
    required this.viewRouter,
    required this.updateRouter,
    this.deleteRouter = "",
    required this.lastModifiedDate,
    this.lastModifiedDateHidden = false,
    required this.textFieldOneLabel,
    this.textFieldTwoLabel = "",
    this.textFieldThreeLabel = "",
    this.textFieldFourLabel = "",
    required this.textFieldOneData,
    this.textFieldTwoData = "",
    this.textFieldThreeData = "",
    this.textFieldFourData = "",
    this.textFieldFourMaxLines,
    this.viewButtonHidden = false,
    this.editButtonHidden = false,
    this.deleteButtonHidden = false,
    this.isTaskCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 5),
      width: mediaQuerySize.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: CFGColor.darkGrey),
        borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
        color: CFGTheme.bgColorScreen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Visibility(
            visible: !lastModifiedDateHidden,
            child: FormViewTextRow(
                label: "Last Modified",
                data: lastModifiedDate,
                isFormView: false,
                extendTextHeight: false),
          ),
          FormViewTextRow(
              label: textFieldOneLabel,
              data: textFieldOneData,
              isFormView: false,
              extendTextHeight: false),
          Visibility(
            visible: textFieldTwoLabel != "",
            child: FormViewTextRow(
                label: textFieldTwoLabel,
                data: textFieldTwoData,
                isFormView: false,
                extendTextHeight: false),
          ),
          Visibility(
            visible: textFieldThreeLabel != "",
            child: FormViewTextRow(
                label: textFieldThreeLabel,
                data: textFieldThreeData,
                isFormView: false,
                extendTextHeight: false),
          ),
          Visibility(
            visible: textFieldFourLabel != "",
            child: FormViewTextRow(
                label: textFieldFourLabel,
                data: textFieldFourData,
                maxLines: textFieldFourMaxLines,
                isFormView: false,
                extendTextHeight: false),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: !viewButtonHidden,
                  child: SB(
                    height: 36,
                    width: 36,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                          shape: const WidgetStatePropertyAll(CircleBorder())),
                      onPressed: () {
                        debugPrint(updateRouter);
                        Get.toNamed(
                          viewRouter,
                          arguments: {
                            'dataObject': dataObject,
                            'onDelete': onDelete,
                          },
                          parameters: {"updateRouter": updateRouter},
                        );
                      },
                      icon: SvgPicture.asset(
                        CFGImage.view,
                        colorFilter:
                            ColorFilter.mode(CFGTheme.button, BlendMode.srcIn),
                        // color: Colors.white,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: !editButtonHidden,
                  child: const SB(width: 5),
                ),

                Visibility(
                  visible: !editButtonHidden,
                  child: SB(
                    height: 36,
                    width: 36,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                          shape: const WidgetStatePropertyAll(CircleBorder())),
                      onPressed: () {
                        Get.toNamed(
                          updateRouter,
                          arguments: dataObject,
                          // parameters: {"test": ''},
                        );
                      },
                      icon: SvgPicture.asset(
                        CFGImage.edit,
                        colorFilter:
                            ColorFilter.mode(CFGTheme.button, BlendMode.srcIn),
                        // color: Colors.white,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: !deleteButtonHidden,
                  child: const SB(width: 5),
                ),

                Visibility(
                  visible: !deleteButtonHidden,
                  child: SB(
                    height: 36,
                    width: 36,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                          shape: const WidgetStatePropertyAll(CircleBorder())),
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
                                    backgroundColor:
                                        WidgetStatePropertyAll(CFGTheme.button),
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
                                    onDelete!(true, dataObject);
                                    Get.back();
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
                        colorFilter:
                            ColorFilter.mode(CFGTheme.button, BlendMode.srcIn),
                        // color: Colors.white,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),

                // Visibility(
                //   visible: isTaskCompleted,
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                //     child: TextButton(
                //       style: ButtonStyle(
                //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //         padding: const WidgetStatePropertyAll(EdgeInsets.only(
                //             left: 10, right: 10, top: 4, bottom: 4)),
                //         minimumSize: const WidgetStatePropertyAll(Size(0, 0)),
                //         backgroundColor:
                //             WidgetStatePropertyAll(CFGTheme.button),
                //         overlayColor:
                //             WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                //             side: BorderSide(color: CFGTheme.button),
                //             borderRadius: BorderRadius.circular(4))),
                //       ),
                //       onPressed: null,
                //       child: Text("Completed",
                //           style: TextStyle(
                //             height: 0,
                //             fontSize: 10,
                //             fontWeight: CFGFont.mediumFontWeight,
                //             color: CFGFont.whiteFontColor,
                //           )),
                //     ),
                //   ),
                // ),

                Visibility(
                  visible: isTaskCompleted,
                  child: SB(
                    height: 30,
                    width: 36,
                    child: IconButton(
                        padding: const EdgeInsets.only(top: 5),
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                            shape:
                                const WidgetStatePropertyAll(CircleBorder())),
                        onPressed: null,
                        icon: Icon(
                          Icons.check_circle_outline_rounded,
                          color: CFGTheme.button,
                          size: 22,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
