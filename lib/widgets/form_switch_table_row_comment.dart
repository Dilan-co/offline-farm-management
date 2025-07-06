import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/form_textfield.dart';

class FormSwitchTableRowComment extends StatefulWidget {
  final String switchLabel;
  final String formFieldLabel;
  final int taskId;
  final bool isUpdate;
  final dynamic initialData;
  final dynamic initialSwitchValue;
  final Function(bool, int) onChangedSwitch;
  final Function(String, int) onChangedText;
  const FormSwitchTableRowComment({
    super.key,
    required this.switchLabel,
    required this.formFieldLabel,
    required this.isUpdate,
    required this.taskId,
    this.initialData,
    this.initialSwitchValue,
    required this.onChangedSwitch,
    required this.onChangedText,
  });

  @override
  State<FormSwitchTableRowComment> createState() =>
      _FormSwitchTableRowCommentState();
}

class _FormSwitchTableRowCommentState extends State<FormSwitchTableRowComment>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  bool isSwitchedOn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitialValues();
  }

  loadInitialValues() {
    if (widget.isUpdate == true) {
      if (widget.initialSwitchValue == 1) {
        setState(() {
          isSwitchedOn = true;
        });
      } else {
        setState(() {
          isSwitchedOn = false;
        });
      }
    }
  }

  onChangedText(String output) {
    widget.onChangedText(output, widget.taskId);
    debugPrint("${widget.taskId}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        //
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Flexible(
                child: Text(widget.switchLabel,
                    style: TextStyle(
                      // overflow: TextOverflow.clip,
                      letterSpacing: 0.5,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ),

              Row(
                  //
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //
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

                    Text("NO",
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
                        // hoverColor: CFGColor.darkGrey,
                        // splashRadius: 20,
                        activeColor: CFGTheme.bgColorScreen,
                        activeTrackColor: CFGTheme.button,
                        trackOutlineColor:
                            WidgetStatePropertyAll(CFGColor.midGrey),
                        inactiveThumbColor: CFGColor.darkGrey,
                        inactiveTrackColor: CFGTheme.bgColorScreen,
                        value: isSwitchedOn,
                        onChanged: (bool value) {
                          widget.onChangedSwitch(value, widget.taskId);
                          setState(() {
                            isSwitchedOn = value;
                          });
                        },
                      ),
                    ),

                    Text("YES",
                        style: TextStyle(
                          fontSize: CFGFont.smallTitleFontSize,
                          fontWeight: isSwitchedOn
                              ? CFGFont.mediumFontWeight
                              : CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),
                  ]),
            ],
          ),
        ),

        Visibility(
          visible: !isSwitchedOn,
          child: FormTextField(
            isUpdate: widget.isUpdate,
            initialData: widget.initialData,
            label: widget.formFieldLabel,
            hintText: "Type here",
            isRequired: false,
            onChangedText: onChangedText,
          ),
        ),
      ],
    );
  }
}
