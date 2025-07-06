import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/sized_box.dart';

class FormBoxTimeSlotTableRow extends StatefulWidget {
  final bool isUpdate;
  final String timeSlot;
  final dynamic initialDataTextFieldOne;
  final dynamic initialDataTextFieldTwo;
  final dynamic initialDataTextFieldThree;
  final dynamic initialDataTextFieldFour;
  final dynamic initialDataTextFieldFive;
  final dynamic initialDataTextFieldSix;
  final Function(String) onChangedTextFieldOne;
  final Function(String) onChangedTextFieldTwo;
  final Function(String) onChangedTextFieldThree;
  final Function(String) onChangedTextFieldFour;
  final Function(String) onChangedTextFieldFive;
  final Function(String) onChangedTextFieldSix;
  const FormBoxTimeSlotTableRow({
    super.key,
    required this.isUpdate,
    required this.timeSlot,
    this.initialDataTextFieldOne,
    this.initialDataTextFieldTwo,
    this.initialDataTextFieldThree,
    this.initialDataTextFieldFour,
    this.initialDataTextFieldFive,
    this.initialDataTextFieldSix,
    required this.onChangedTextFieldOne,
    required this.onChangedTextFieldTwo,
    required this.onChangedTextFieldThree,
    required this.onChangedTextFieldFour,
    required this.onChangedTextFieldFive,
    required this.onChangedTextFieldSix,
  });

  @override
  State<FormBoxTimeSlotTableRow> createState() =>
      _FormBoxTimeSlotTableRowState();
}

class _FormBoxTimeSlotTableRowState extends State<FormBoxTimeSlotTableRow>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;
  TextEditingController textControllerOne = TextEditingController();
  TextEditingController textControllerTwo = TextEditingController();
  TextEditingController textControllerThree = TextEditingController();
  TextEditingController textControllerFour = TextEditingController();
  TextEditingController textControllerFive = TextEditingController();
  TextEditingController textControllerSix = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadInitialValues();
  }

  loadInitialValues() {
    if (widget.isUpdate) {
      // #1
      if (widget.initialDataTextFieldOne == null ||
          widget.initialDataTextFieldOne == "") {
        setState(() {
          textControllerOne.text = "";
        });
      } else {
        setState(() {
          textControllerOne.text = widget.initialDataTextFieldOne.toString();
        });
      }
      // #2
      if (widget.initialDataTextFieldTwo == null ||
          widget.initialDataTextFieldTwo == "") {
        setState(() {
          textControllerTwo.text = "";
        });
      } else {
        setState(() {
          textControllerTwo.text = widget.initialDataTextFieldTwo.toString();
        });
      }
      // #3
      if (widget.initialDataTextFieldThree == null ||
          widget.initialDataTextFieldThree == "") {
        setState(() {
          textControllerThree.text = "";
        });
      } else {
        setState(() {
          textControllerThree.text =
              widget.initialDataTextFieldThree.toString();
        });
      }
      // #4
      if (widget.initialDataTextFieldFour == null ||
          widget.initialDataTextFieldFour == "") {
        setState(() {
          textControllerFour.text = "";
        });
      } else {
        setState(() {
          textControllerFour.text = widget.initialDataTextFieldFour.toString();
        });
      }
      // #5
      if (widget.initialDataTextFieldFive == null ||
          widget.initialDataTextFieldFive == "") {
        setState(() {
          textControllerFive.text = "";
        });
      } else {
        setState(() {
          textControllerFive.text = widget.initialDataTextFieldFive.toString();
        });
      }
      // #6
      if (widget.initialDataTextFieldSix == null ||
          widget.initialDataTextFieldSix == "") {
        setState(() {
          textControllerSix.text = "";
        });
      } else {
        setState(() {
          textControllerSix.text = widget.initialDataTextFieldSix.toString();
        });
      }
    } else {
      setState(() {
        textControllerOne.text = "";
        textControllerTwo.text = "";
        textControllerThree.text = "";
        textControllerFour.text = "";
        textControllerFive.text = "";
        textControllerSix.text = "";
      });
    }
    debugPrint(textControllerOne.text);
    debugPrint(textControllerTwo.text);
    debugPrint(textControllerThree.text);
    debugPrint(textControllerFour.text);
    debugPrint(textControllerFive.text);
    debugPrint(textControllerSix.text);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text("Time Slot",
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  widget.timeSlot,
                  style: TextStyle(
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.lightFontWeight,
                    color: CFGFont.defaultFontColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              //
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    //TextField 1
                    Expanded(
                      child: TextFormField(
                        controller: textControllerOne,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              // Allow only numbers with decimal point
                              RegExp(r'^\d+\.?\d{0,}')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        enabled: true,
                        //set initial value here for update form
                        //initialValue: '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CFGFont.smallTitleFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide:
                                BorderSide(color: CFGTheme.button, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide: BorderSide(
                              color: CFGColor.midGrey,
                              width: 1.0,
                            ),
                          ),
                          fillColor: CFGTheme.bgColorScreen,
                          filled: true,
                          hintText: "1",
                          hintStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: CFGFont.smallFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.lightGreyFontColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CFGTheme.cardRadius)),
                          ),
                        ),
                        onChanged: (value) {
                          widget.onChangedTextFieldOne(value);
                          setState(() {});
                        },
                        onSaved: (newValue) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter text';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),

                    const SB(width: 20),

                    //TextField 2
                    Expanded(
                      child: TextFormField(
                        controller: textControllerTwo,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              // Allow only numbers
                              RegExp(r'^[0-9]+.?[0-9]*')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        enabled: true,
                        //set initial value here for update form
                        //initialValue: '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CFGFont.smallTitleFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide:
                                BorderSide(color: CFGTheme.button, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide: BorderSide(
                              color: CFGColor.midGrey,
                              width: 1.0,
                            ),
                          ),
                          fillColor: CFGTheme.bgColorScreen,
                          filled: true,
                          hintText: "2",
                          hintStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: CFGFont.smallFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.lightGreyFontColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CFGTheme.cardRadius)),
                          ),
                        ),
                        onChanged: (value) {
                          widget.onChangedTextFieldTwo(value);
                          setState(() {});
                        },
                        onSaved: (newValue) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter text';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),

                    const SB(width: 20),

                    //TextField 3
                    Expanded(
                      child: TextFormField(
                        controller: textControllerThree,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              // Allow only numbers
                              RegExp(r'^[0-9]+.?[0-9]*')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        enabled: true,
                        //set initial value here for update form
                        //initialValue: '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CFGFont.smallTitleFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide:
                                BorderSide(color: CFGTheme.button, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide: BorderSide(
                              color: CFGColor.midGrey,
                              width: 1.0,
                            ),
                          ),
                          fillColor: CFGTheme.bgColorScreen,
                          filled: true,
                          hintText: "3",
                          hintStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: CFGFont.smallFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.lightGreyFontColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CFGTheme.cardRadius)),
                          ),
                        ),
                        onChanged: (value) {
                          widget.onChangedTextFieldThree(value);
                          setState(() {});
                        },
                        onSaved: (newValue) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter text';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    ////TextField 4
                    Expanded(
                      child: TextFormField(
                        controller: textControllerFour,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              // Allow only numbers
                              RegExp(r'^[0-9]+.?[0-9]*')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        enabled: true,
                        //set initial value here for update form
                        //initialValue: '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CFGFont.smallTitleFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide:
                                BorderSide(color: CFGTheme.button, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide: BorderSide(
                              color: CFGColor.midGrey,
                              width: 1.0,
                            ),
                          ),
                          fillColor: CFGTheme.bgColorScreen,
                          filled: true,
                          hintText: "4",
                          hintStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: CFGFont.smallFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.lightGreyFontColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CFGTheme.cardRadius)),
                          ),
                        ),
                        onChanged: (value) {
                          widget.onChangedTextFieldFour(value);
                          setState(() {});
                        },
                        onSaved: (newValue) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter text';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),

                    const SB(width: 20),

                    //TextField 5
                    Expanded(
                      child: TextFormField(
                        controller: textControllerFive,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              // Allow only numbers
                              RegExp(r'^[0-9]+.?[0-9]*')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        enabled: true,
                        //set initial value here for update form
                        //initialValue: '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CFGFont.smallTitleFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide:
                                BorderSide(color: CFGTheme.button, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide: BorderSide(
                              color: CFGColor.midGrey,
                              width: 1.0,
                            ),
                          ),
                          fillColor: CFGTheme.bgColorScreen,
                          filled: true,
                          hintText: "5",
                          hintStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: CFGFont.smallFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.lightGreyFontColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CFGTheme.cardRadius)),
                          ),
                        ),
                        onChanged: (value) {
                          widget.onChangedTextFieldFive(value);
                          setState(() {});
                        },
                        onSaved: (newValue) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter text';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),

                    const SB(width: 20),

                    //TextField 6
                    Expanded(
                      child: TextFormField(
                        controller: textControllerSix,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              // Allow only numbers
                              RegExp(r'^[0-9]+.?[0-9]*')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        enabled: true,
                        //set initial value here for update form
                        //initialValue: '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CFGFont.smallTitleFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide:
                                BorderSide(color: CFGTheme.button, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.cardRadius),
                            borderSide: BorderSide(
                              color: CFGColor.midGrey,
                              width: 1.0,
                            ),
                          ),
                          fillColor: CFGTheme.bgColorScreen,
                          filled: true,
                          hintText: "6",
                          hintStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: CFGFont.smallFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.lightGreyFontColor,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CFGTheme.cardRadius)),
                          ),
                        ),
                        onChanged: (value) {
                          widget.onChangedTextFieldSix(value);
                          setState(() {});
                        },
                        onSaved: (newValue) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter text';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
