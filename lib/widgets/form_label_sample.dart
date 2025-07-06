import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FormLabelSample extends StatefulWidget {
  final String label;
  final dynamic initialPackDate;
  final dynamic initialBestBeforeDate;
  final dynamic initialFileName;
  final dynamic initialLabelPosition;
  final dynamic initialLabelLegible;
  final bool isUpdate;
  final Function(String) onChangedPackDate;
  final Function(String) onChangedBestBeforeDate;
  final Function(String?) selectedFilePath;
  final Function(bool) onChangedSwitchLabelLegible;
  final Function(bool) onChangedSwitchLabelPosition;
  const FormLabelSample({
    super.key,
    required this.label,
    required this.initialFileName,
    required this.initialPackDate,
    required this.initialBestBeforeDate,
    required this.initialLabelPosition,
    required this.initialLabelLegible,
    required this.isUpdate,
    required this.onChangedPackDate,
    required this.onChangedBestBeforeDate,
    required this.selectedFilePath,
    required this.onChangedSwitchLabelLegible,
    required this.onChangedSwitchLabelPosition,
  });

  @override
  State<FormLabelSample> createState() => _FormLabelSampleState();
}

class _FormLabelSampleState extends State<FormLabelSample>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  // static const List<String> list = <String>['Yes', 'No'];

  // String labelPositionSelectedValue = "No";
  // String labelLegibleSelectedValue = "No";
  bool positionIsSelected = false;
  bool legibleIsSelected = false;
  //"file" is to be the one to save into DB
  File? file;
  String fileName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitialValues();
  }

  loadInitialValues() {
    if (widget.isUpdate == true && widget.initialFileName != null) {
      setState(() {
        fileName = widget.initialFileName.toString();
      });
    } else {
      setState(() {
        fileName = "";
      });
    }
    debugPrint(fileName);
    if (widget.isUpdate == true) {
      if (widget.initialLabelPosition == 1) {
        setState(() {
          positionIsSelected = true;
        });
      } else {
        setState(() {
          positionIsSelected = false;
        });
      }
      if (widget.initialLabelLegible == 1) {
        setState(() {
          legibleIsSelected = true;
        });
      } else {
        setState(() {
          legibleIsSelected = false;
        });
      }
      debugPrint("$positionIsSelected");
      debugPrint("$legibleIsSelected");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Size mediaQuerySize = MediaQuery.of(context).size;
    double centerSpacing = mediaQuerySize.width * 0.02;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Divider(color: CFGColor.lightGrey, height: 0),

          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(widget.label,
                style: TextStyle(
                  fontSize: CFGFont.smallTitleFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
          ),

          Divider(color: CFGColor.lightGrey, height: 0),

          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Row(
              children: [
                //
                TextButton(
                  style: ButtonStyle(
                    fixedSize: const WidgetStatePropertyAll(Size(110, 38)),
                    minimumSize: const WidgetStatePropertyAll(Size(110, 38)),
                    backgroundColor: WidgetStatePropertyAll(CFGTheme.button),
                    overlayColor:
                        WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(CFGTheme.buttonRadius))),
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
                        file = File(result.files.single.path.toString());
                        fileName = result.files.first.name;
                      });
                      widget.selectedFilePath(file?.path);
                      debugPrint(fileName);
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Text("Upload",
                      style: TextStyle(
                        height: 0,
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
                      fileName,
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

          //add datepicker here

          Row(
            children: [
              //
              SB(
                width: mediaQuerySize.width * 0.5 -
                    (CFGTheme.bodyLRPadding + centerSpacing),
                child: FormDatePicker(
                  isUpdate: widget.isUpdate,
                  initialData: widget.initialPackDate,
                  label: "Pack Date",
                  hintText: "Tap here",
                  isRequired: false,
                  prefixContainerWidth: 44,
                  prefixContainerMargin: 10,
                  prefixContainerIconSize: 30,
                  onChangedDate: widget.onChangedPackDate,
                ),
              ),

              //Center Spacing
              SB(width: (centerSpacing) * 2),

              SB(
                width: mediaQuerySize.width * 0.5 -
                    (CFGTheme.bodyLRPadding + centerSpacing),
                child: FormDatePicker(
                  isUpdate: widget.isUpdate,
                  initialData: widget.initialBestBeforeDate,
                  label: "Best Before Date",
                  hintText: "Tap here",
                  isRequired: false,
                  prefixContainerWidth: 44,
                  prefixContainerMargin: 10,
                  prefixContainerIconSize: 30,
                  onChangedDate: widget.onChangedBestBeforeDate,
                ),
              ),
            ],
          ),

          //Label position and Label legible
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                //Label Position
                SB(
                  width: mediaQuerySize.width * 0.5 -
                      (CFGTheme.bodyLRPadding + centerSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Text("Label Position",
                          style: TextStyle(
                            letterSpacing: 0.5,
                            fontSize: CFGFont.defaultFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.defaultFontColor,
                          )),

                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            Text("NO",
                                style: TextStyle(
                                  fontSize: CFGFont.smallTitleFontSize,
                                  fontWeight: positionIsSelected
                                      ? CFGFont.regularFontWeight
                                      : CFGFont.mediumFontWeight,
                                  color: CFGFont.defaultFontColor,
                                )),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Switch(
                                // hoverColor: CFGColor.darkGrey,
                                // splashRadius: 20,
                                activeColor: CFGTheme.bgColorScreen,
                                activeTrackColor: CFGTheme.button,
                                trackOutlineColor:
                                    WidgetStatePropertyAll(CFGColor.midGrey),
                                inactiveThumbColor: CFGColor.darkGrey,
                                inactiveTrackColor: CFGTheme.bgColorScreen,
                                value: positionIsSelected,
                                onChanged: (bool value) {
                                  widget.onChangedSwitchLabelPosition(value);
                                  setState(() {
                                    positionIsSelected = value;
                                  });
                                },
                              ),
                            ),

                            Text("YES",
                                style: TextStyle(
                                  fontSize: CFGFont.smallTitleFontSize,
                                  fontWeight: positionIsSelected
                                      ? CFGFont.mediumFontWeight
                                      : CFGFont.regularFontWeight,
                                  color: CFGFont.defaultFontColor,
                                )),
                          ],
                        ),
                      ),

                      // SB(
                      //   width: mediaQuerySize.width * 0.32,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 30),
                      //     child: ListView.builder(
                      //       shrinkWrap: true,
                      //       padding: EdgeInsets.zero,
                      //       // physics: const BouncingScrollPhysics(),
                      //       itemCount: list.length,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return Padding(
                      //           padding:
                      //               const EdgeInsets.only(top: 5, bottom: 5),
                      //           child: RadioListTile(
                      //             // overlayColor:
                      //             //     WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                      //             dense: true,
                      //             toggleable: false,
                      //             title: Text(list.elementAt(index),
                      //                 style: TextStyle(
                      //                   fontSize: CFGFont.defaultFontSize,
                      //                   fontWeight: CFGFont.regularFontWeight,
                      //                   color: list.elementAt(index) ==
                      //                           labelPositionSelectedValue
                      //                       ? CFGFont.whiteFontColor
                      //                       : CFGFont.defaultFontColor,
                      //                 )),
                      //             value: list.elementAt(index),
                      //             groupValue: labelPositionSelectedValue,
                      //             selected: list.elementAt(index) ==
                      //                     labelPositionSelectedValue
                      //                 ? true
                      //                 : false,
                      //             enableFeedback: true,
                      //             //spacing between radio and text
                      //             // visualDensity: const VisualDensity(horizontal: -4.0),
                      //             visualDensity: const VisualDensity(
                      //                 horizontal: VisualDensity.minimumDensity,
                      //                 vertical: VisualDensity.minimumDensity),
                      //             materialTapTargetSize:
                      //                 MaterialTapTargetSize.shrinkWrap,
                      //             contentPadding:
                      //                 const EdgeInsets.only(right: 5),
                      //             shape: RoundedRectangleBorder(
                      //                 side:
                      //                     BorderSide(color: CFGColor.midGrey),
                      //                 borderRadius: BorderRadius.circular(4)),
                      //             activeColor: CFGTheme.appBarButtonImg,
                      //             selectedTileColor: CFGTheme.button,
                      //             onChanged: (value) async {
                      //               setState(() {
                      //                 labelPositionSelectedValue =
                      //                     value.toString();
                      //                 debugPrint(value.toString());
                      //               });
                      //             },
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                //Center Spacing
                SB(width: (centerSpacing) * 2),

                //Label Legible
                SB(
                  width: mediaQuerySize.width * 0.5 -
                      (CFGTheme.bodyLRPadding + centerSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Text("Label Legible",
                          style: TextStyle(
                            letterSpacing: 0.5,
                            fontSize: CFGFont.defaultFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.defaultFontColor,
                          )),

                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            Text("NO",
                                style: TextStyle(
                                  fontSize: CFGFont.smallTitleFontSize,
                                  fontWeight: legibleIsSelected
                                      ? CFGFont.regularFontWeight
                                      : CFGFont.mediumFontWeight,
                                  color: CFGFont.defaultFontColor,
                                )),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Switch(
                                // hoverColor: CFGColor.darkGrey,
                                // splashRadius: 20,
                                activeColor: CFGTheme.bgColorScreen,
                                activeTrackColor: CFGTheme.button,
                                trackOutlineColor:
                                    WidgetStatePropertyAll(CFGColor.midGrey),
                                inactiveThumbColor: CFGColor.darkGrey,
                                inactiveTrackColor: CFGTheme.bgColorScreen,
                                value: legibleIsSelected,
                                onChanged: (bool value) {
                                  widget.onChangedSwitchLabelLegible(value);
                                  setState(() {
                                    legibleIsSelected = value;
                                  });
                                },
                              ),
                            ),

                            Text("YES",
                                style: TextStyle(
                                  fontSize: CFGFont.smallTitleFontSize,
                                  fontWeight: legibleIsSelected
                                      ? CFGFont.mediumFontWeight
                                      : CFGFont.regularFontWeight,
                                  color: CFGFont.defaultFontColor,
                                )),
                          ],
                        ),
                      ),

                      // SB(
                      //   width: mediaQuerySize.width * 0.32,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 30),
                      //     child: ListView.builder(
                      //       shrinkWrap: true,
                      //       padding: EdgeInsets.zero,
                      //       // physics: const BouncingScrollPhysics(),
                      //       itemCount: list.length,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return Padding(
                      //           padding:
                      //               const EdgeInsets.only(top: 5, bottom: 5),
                      //           child: RadioListTile(
                      //             // overlayColor:
                      //             //     WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                      //             dense: true,
                      //             toggleable: false,
                      //             title: Text(list.elementAt(index),
                      //                 style: TextStyle(
                      //                   fontSize: CFGFont.defaultFontSize,
                      //                   fontWeight: CFGFont.regularFontWeight,
                      //                   color: list.elementAt(index) ==
                      //                           labelLegibleSelectedValue
                      //                       ? CFGFont.whiteFontColor
                      //                       : CFGFont.defaultFontColor,
                      //                 )),
                      //             value: list.elementAt(index),
                      //             groupValue: labelLegibleSelectedValue,
                      //             selected: list.elementAt(index) ==
                      //                     labelLegibleSelectedValue
                      //                 ? true
                      //                 : false,
                      //             enableFeedback: false,
                      //             //spacing between radio and text
                      //             // visualDensity: const VisualDensity(horizontal: -4.0),
                      //             visualDensity: const VisualDensity(
                      //                 horizontal: VisualDensity.minimumDensity,
                      //                 vertical: VisualDensity.minimumDensity),
                      //             materialTapTargetSize:
                      //                 MaterialTapTargetSize.shrinkWrap,
                      //             contentPadding:
                      //                 const EdgeInsets.only(right: 5),
                      //             shape: RoundedRectangleBorder(
                      //                 side:
                      //                     BorderSide(color: CFGColor.midGrey),
                      //                 borderRadius: BorderRadius.circular(4)),
                      //             activeColor: CFGTheme.appBarButtonImg,
                      //             selectedTileColor: CFGTheme.button,
                      //             onChanged: (value) async {
                      //               setState(() {
                      //                 labelLegibleSelectedValue =
                      //                     value.toString();
                      //                 debugPrint(value.toString());
                      //               });
                      //             },
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
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
