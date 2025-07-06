import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/widgets/sized_box.dart';

class ProductBatchLabelAssessmentMainTileViewCard extends StatelessWidget {
  final String lastModifiedDate;
  final String client;
  final String farm;
  final String crop;
  final String batchNo;

  const ProductBatchLabelAssessmentMainTileViewCard({
    super.key,
    required this.lastModifiedDate,
    required this.client,
    required this.farm,
    required this.crop,
    required this.batchNo,
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
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Text("Last Modified",
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text("Client",
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text("Farm",
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text("Crop",
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text("Production",
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                  Text("Batch No",
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    //
                    Text(":",
                        style: TextStyle(
                          // height: 1.5,
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),

                    Text(":",
                        style: TextStyle(
                          // height: 1.5,
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),

                    Text(":",
                        style: TextStyle(
                          // height: 1.5,
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),

                    Text(":",
                        style: TextStyle(
                          // height: 1.5,
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),

                    Text(":",
                        style: TextStyle(
                          // height: 1.5,
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),
                    Text("",
                        style: TextStyle(
                          // height: 1.5,
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Text(lastModifiedDate,
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.lightFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text(client,
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.lightFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text(farm,
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.lightFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text(crop,
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.lightFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),

                  Text(batchNo,
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.lightFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                  Text('',
                      style: TextStyle(
                        // height: 1.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.lightFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SB(
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
                        NavRoute.productBatchLabelAssessmentView,
                        parameters: {
                          "updateRouter":
                              NavRoute.productBatchLabelAssessmentUpdate
                        },
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

                //
                const SB(width: 5),

                SB(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                        shape: const WidgetStatePropertyAll(CircleBorder())),
                    onPressed: () {
                      Get.toNamed(NavRoute.productBatchLabelAssessmentAdd);
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

                //
                const SB(width: 5),

                SB(
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
                                borderRadius:
                                    BorderRadius.circular(CFGTheme.cardRadius)),
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
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.mediumFontWeight,
                                    color: CFGFont.whiteFontColor,
                                  ),
                                ),
                                onPressed: () {
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
