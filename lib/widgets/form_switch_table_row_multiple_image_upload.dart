import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:permission_handler/permission_handler.dart';

class FormSwitchTableRowMultipleImageUpload extends StatefulWidget {
  final String switchLabel;
  final String trueLabel;
  final String falseLabel;
  final int assessmentItemChildId;
  final String? question;
  final bool isUpdate;
  final bool invertValues;
  final List<String?> initialFileNames;
  final dynamic initialSwitchValue;
  final Function(bool, int) onChangedSwitch;
  // Function to handle multiple file paths
  final Function(List<String?>, int) selectedFilePaths;

  const FormSwitchTableRowMultipleImageUpload({
    super.key,
    required this.switchLabel,
    this.trueLabel = "YES",
    this.falseLabel = "NO",
    required this.assessmentItemChildId,
    required this.question,
    required this.isUpdate,
    this.invertValues = false,
    this.initialFileNames = const [],
    this.initialSwitchValue,
    required this.onChangedSwitch,
    required this.selectedFilePaths,
  });

  @override
  State<FormSwitchTableRowMultipleImageUpload> createState() =>
      _FormSwitchTableRowMultipleImageUploadState();
}

class _FormSwitchTableRowMultipleImageUploadState
    extends State<FormSwitchTableRowMultipleImageUpload>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isSwitchedOn = true;
  List<File> files = [];
  List<String> fileNames = [];

  @override
  void initState() {
    super.initState();
    loadInitialValues();
  }

  loadInitialValues() {
    if (widget.isUpdate == true) {
      if (widget.initialFileNames.isNotEmpty) {
        setState(() {
          // Filter out any potential null values
          fileNames = widget.initialFileNames
              .where((name) => name != null)
              .cast<String>()
              .toList();
        });
      }
      if (widget.invertValues) {
        setState(() {
          isSwitchedOn = widget.initialSwitchValue != 1;
        });
      } else {
        setState(() {
          isSwitchedOn = widget.initialSwitchValue == 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(widget.switchLabel,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Text(":",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),
                  ),
                  Text(widget.falseLabel,
                      style: TextStyle(
                        fontSize: CFGFont.smallTitleFontSize,
                        fontWeight: isSwitchedOn
                            ? CFGFont.regularFontWeight
                            : CFGFont.mediumFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Switch(
                      activeColor: CFGTheme.bgColorScreen,
                      activeTrackColor: CFGTheme.button,
                      trackOutlineColor:
                          WidgetStatePropertyAll(CFGColor.midGrey),
                      inactiveThumbColor: CFGColor.darkGrey,
                      inactiveTrackColor: CFGTheme.bgColorScreen,
                      value: isSwitchedOn,
                      onChanged: (bool value) {
                        widget.onChangedSwitch(
                            value, widget.assessmentItemChildId);
                        setState(() {
                          isSwitchedOn = value;
                        });
                      },
                    ),
                  ),
                  Text(widget.trueLabel,
                      style: TextStyle(
                        fontSize: CFGFont.smallTitleFontSize,
                        fontWeight: isSwitchedOn
                            ? CFGFont.mediumFontWeight
                            : CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Row(
            children: [
              Flexible(
                child: Text(widget.question ?? "",
                    style: TextStyle(
                      fontSize: CFGFont.smallTitleFontSize,
                      fontWeight: isSwitchedOn
                          ? CFGFont.regularFontWeight
                          : CFGFont.mediumFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              TextButton(
                style: ButtonStyle(
                  fixedSize: const WidgetStatePropertyAll(Size(140, 38)),
                  backgroundColor: WidgetStatePropertyAll(CFGTheme.button),
                  overlayColor: WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(CFGTheme.buttonRadius))),
                ),
                onPressed: () async {
                  //storage permission check & request
                  await requestPermission(Permission.storage);

                  //open file explorer to select multiple images
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    // Enable multiple selection
                    allowMultiple: true,
                  );

                  if (result != null) {
                    // Process the selected files
                    setState(() {
                      files = result.paths
                          .where((path) => path != null)
                          .map((path) => File(path!))
                          .toList();
                      fileNames = result.names
                          .where((name) => name != null)
                          .map((name) => name!)
                          .toList();
                    });
                    // Send file paths to parent widget
                    widget.selectedFilePaths(
                        files.map((file) => file.path).toList(),
                        widget.assessmentItemChildId);
                  }
                },
                child: Text("Upload Pictures",
                    style: TextStyle(
                      height: 0,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.whiteFontColor,
                    )),
              ),

              // Display selected file names
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: CFGColor.lightGrey,
                      ),
                    ),
                  ),
                  child: fileNames.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: fileNames.length,
                          itemBuilder: (context, index) {
                            return Text(
                              fileNames[index].isEmpty ? "" : fileNames[index],
                              style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: CFGFont.defaultFontSize,
                                fontWeight: CFGFont.regularFontWeight,
                                color: CFGFont.defaultFontColor,
                              ),
                            );
                          },
                        )
                      : const Text(
                          "",
                          style: TextStyle(
                            fontSize: CFGFont.defaultFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
