import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';

class FormDatePicker extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final bool isUpdate;
  final double prefixContainerWidth;
  final double prefixContainerMargin;
  final double prefixContainerIconSize;
  final dynamic initialData;
  final Function(String) onChangedDate;
  const FormDatePicker({
    super.key,
    required this.label,
    required this.hintText,
    required this.isRequired,
    required this.isUpdate,
    this.prefixContainerWidth = 70,
    this.prefixContainerMargin = 20,
    this.prefixContainerIconSize = 30,
    this.initialData,
    required this.onChangedDate,
  });

  @override
  State<FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  TextEditingController textController = TextEditingController();
  bool required = true;
  dynamic pickedDateUnformatted;
  dynamic pickedDateFormatted; //yyyy-mm-dd
  dynamic initialDateTime; //yyyy-mm-dd

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertingToDateTime();
  }

  convertingToDateTime() {
    if (widget.isUpdate) {
      if (widget.initialData == null || widget.initialData == "") {
        setState(() {
          initialDateTime = DateTime.now();
          textController.text = "";
          required = true;
        });
      } else {
        setState(() {
          initialDateTime = DateFormat("yyyy-MM-dd").parse(widget.initialData!);
          textController.text = widget.initialData!.toString().split(' ').first;
          required = false;
        });
      }
    } else {
      setState(() {
        initialDateTime = DateTime.now();
        textController.text = "";
        required = true;
      });
    }
    debugPrint("${widget.initialData}");
    debugPrint(textController.text);
    debugPrint("$initialDateTime");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        //
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label,
                  style: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.regularFontWeight,
                    color: CFGFont.defaultFontColor,
                  )),
              Visibility(
                visible: widget.isRequired,
                child: Text(required ? "Required" : '',
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: CFGFont.smallFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.redFontColor,
                    )),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: TextFormField(
            controller: textController,
            enabled: true,
            readOnly: true,
            showCursor: false,
            style: TextStyle(
              fontSize: CFGFont.smallTitleFontSize,
              fontWeight: CFGFont.regularFontWeight,
              color: CFGFont.defaultFontColor,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
                borderSide: BorderSide(color: CFGTheme.button, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
                borderSide: BorderSide(
                  color: CFGColor.midGrey,
                  width: 1.0,
                ),
              ),
              prefixIcon: Container(
                width: widget.prefixContainerWidth,
                margin: EdgeInsets.only(
                    right: widget.prefixContainerMargin, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: CFGColor.midGrey, width: 1))),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: CFGTheme.button,
                  size: widget.prefixContainerIconSize,
                ),
              ),
              fillColor: CFGTheme.bgColorScreen,
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                letterSpacing: 1,
                fontSize: CFGFont.smallFontSize,
                fontWeight: CFGFont.regularFontWeight,
                color: CFGFont.lightGreyFontColor,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(CFGTheme.cardRadius)),
              ),
            ),
            onTap: () async {
              //Date Picker
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: initialDateTime,
                firstDate: DateTime(2010),
                lastDate: DateTime(2050),
                confirmText: "Select",
                cancelText: "Cancel",
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        surfaceTint: CFGTheme.bgColorScreen,
                        primary: CFGTheme.button,
                        onPrimary: CFGTheme.bgColorScreen,
                        onSurface: CFGColor.black,
                        brightness: Brightness.light,
                      ),
                      datePickerTheme: const DatePickerThemeData(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                            foregroundColor: CFGTheme.bgColorScreen,
                            backgroundColor: CFGTheme.button,
                            iconColor: CFGTheme.bgColorScreen,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(CFGTheme.cardRadius)),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            textStyle: TextStyle(
                              fontSize: CFGFont.smallTitleFontSize,
                              fontWeight: CFGFont.mediumFontWeight,
                              color: CFGFont.whiteFontColor,
                            )),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                setState(() {
                  pickedDateUnformatted = picked.toString();
                  pickedDateFormatted =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')} ${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:${picked.second.toString().padLeft(2, '0')}";
                  textController.text =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

                  if (widget.isRequired && textController.text.isEmpty) {
                    required = true;
                  } else {
                    required = false;
                  }
                });

                widget.onChangedDate(pickedDateFormatted);
              }
            },
            onChanged: (value) {},
            onSaved: (newValue) {},
          ),
        ),

        // TextButton(
        //     onPressed: () {
        //       if (_formKey.currentState!.validate()) {}
        //     },
        //     child: Text('Validate')),
      ],
    );
  }
}
