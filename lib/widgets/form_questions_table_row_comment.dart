import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/form_textfield.dart';

class FormQuestionsTableRowComment extends StatefulWidget {
  final String mainColumnTitle;
  final String mainColumnCategory;
  final String switchLabel;
  final String formFieldLabel;
  final int questionId;
  final bool isUpdate;
  final dynamic initialData;
  final dynamic initialSwitchValue;
  final Function(bool, int) onChangedSwitch;
  final Function(String, int) onChangedQuestionText;
  const FormQuestionsTableRowComment({
    super.key,
    required this.mainColumnTitle,
    required this.mainColumnCategory,
    required this.switchLabel,
    required this.formFieldLabel,
    required this.questionId,
    required this.isUpdate,
    this.initialData,
    this.initialSwitchValue,
    required this.onChangedSwitch,
    required this.onChangedQuestionText,
  });

  @override
  State<FormQuestionsTableRowComment> createState() =>
      _FormQuestionsTableRowCommentState();
}

class _FormQuestionsTableRowCommentState
    extends State<FormQuestionsTableRowComment>
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
    widget.onChangedQuestionText(output, widget.questionId);
    debugPrint("${widget.questionId}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              //
              Text(widget.mainColumnTitle,
                  style: TextStyle(
                    // letterSpacing: 0.5,
                    height: 0,
                    fontSize: CFGFont.smallTitleFontSize,
                    fontWeight: CFGFont.lightFontWeight,
                    color: CFGFont.defaultFontColor,
                  )),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Text(":",
                    style: TextStyle(
                      // letterSpacing: 0.5,
                      // height: 0,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ),

              Flexible(
                child: Text(widget.mainColumnCategory,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      height: 0,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.mediumFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ),
            ],
          ),
        ),

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
                          widget.onChangedSwitch(value, widget.questionId);
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

        Divider(color: CFGColor.lightGrey, height: 0),
      ],
    );
  }
}
