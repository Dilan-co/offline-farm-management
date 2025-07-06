import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/widgets/sized_box.dart';

class FormViewBoxTimeSlotTableRow extends StatefulWidget {
  final String timeSlot;
  final dynamic dataOne;
  final dynamic dataTwo;
  final dynamic dataThree;
  final dynamic dataFour;
  final dynamic dataFive;
  final dynamic dataSix;
  const FormViewBoxTimeSlotTableRow({
    super.key,
    required this.timeSlot,
    required this.dataOne,
    required this.dataTwo,
    required this.dataThree,
    required this.dataFour,
    required this.dataFive,
    required this.dataSix,
  });

  @override
  State<FormViewBoxTimeSlotTableRow> createState() =>
      _FormViewBoxTimeSlotTableRowState();
}

class _FormViewBoxTimeSlotTableRowState
    extends State<FormViewBoxTimeSlotTableRow>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

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
                    //
                    Expanded(
                        child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(CFGTheme.cardRadius),
                        border: Border.all(
                          color: CFGColor.midGrey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                            widget.dataOne == null
                                ? ""
                                : widget.dataOne.toString(),
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.lightFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),
                    )),

                    const SB(width: 20),

                    Expanded(
                        child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(CFGTheme.cardRadius),
                        border: Border.all(
                          color: CFGColor.midGrey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                            widget.dataTwo == null
                                ? ""
                                : widget.dataTwo.toString(),
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.lightFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),
                    )),

                    const SB(width: 20),

                    Expanded(
                        child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(CFGTheme.cardRadius),
                        border: Border.all(
                          color: CFGColor.midGrey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                            widget.dataThree == null
                                ? ""
                                : widget.dataThree.toString(),
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.lightFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),
                    )),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    //
                    Expanded(
                        child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(CFGTheme.cardRadius),
                        border: Border.all(
                          color: CFGColor.midGrey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                            widget.dataFour == null
                                ? ""
                                : widget.dataFour.toString(),
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.lightFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),
                    )),

                    const SB(width: 20),

                    Expanded(
                        child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(CFGTheme.cardRadius),
                        border: Border.all(
                          color: CFGColor.midGrey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                            widget.dataFive == null
                                ? ""
                                : widget.dataFive.toString(),
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.lightFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),
                    )),

                    const SB(width: 20),

                    Expanded(
                        child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(CFGTheme.cardRadius),
                        border: Border.all(
                          color: CFGColor.midGrey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                            widget.dataSix == null
                                ? ""
                                : widget.dataSix.toString(),
                            style: TextStyle(
                              // height: extendTextHeight ? 2.2 : null,
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.lightFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),
                    )),
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
