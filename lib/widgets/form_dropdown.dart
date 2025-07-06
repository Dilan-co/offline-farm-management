import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';

class FormDropdown extends StatefulWidget {
  final String label;
  final String dropdownHintText;
  final List dropdownList; //Change this to List<Map<int, String>>
  final bool isRequired;
  final bool isUpdate;
  final bool isDropDownIndexReset;
  final String? initialData;
  final Function(int?) onChangedDropdown;
  const FormDropdown({
    super.key,
    required this.label,
    required this.dropdownHintText,
    required this.dropdownList,
    required this.isRequired,
    required this.isUpdate,
    this.isDropDownIndexReset = false,
    this.initialData,
    required this.onChangedDropdown,
  });

  @override
  State<FormDropdown> createState() => _FormDropdownState();
}

class _FormDropdownState extends State<FormDropdown>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  // static const List<String> testList = <String>[
  //   'Test Data One',
  //   'Test Data Two',
  //   'Test Data Three',
  //   'Test Data Four'
  // ];

  int? dropdownIndex;
  Color dropdownButtonBorderColor = CFGColor.midGrey;
  bool required = true;

  loadInitialValues() {
    debugPrint("Initial Data --> ${widget.initialData}");
    if (widget.isUpdate) {
      if (widget.initialData == null || widget.initialData == "") {
        setState(() {
          required = true;
        });
      } else {
        setState(() {
          required = false;
        });
      }
    }
  }

  dropdownIndexReset() {
    int? output;
    if (widget.isDropDownIndexReset) {
      if (widget.dropdownList.isNotEmpty) {
        for (var entry in widget.dropdownList) {
          // Reset selectedValue to a default value or the first item in the new list
          debugPrint("Key ${entry.keys.first}");
          if (dropdownIndex == entry.keys.first) {
            output = entry.keys.first;
            setState(() {
              required = false;
            });
            break;
          } else {
            output = null;
            if (widget.initialData == null || widget.initialData == "") {
              setState(() {
                required = true;
              });
            } else {
              setState(() {
                required = false;
              });
            }
          }
        }
      } else {
        output = null;
        setState(() {
          required = true;
        });
      }
      debugPrint("Dropdown Index $output");
      setState(() {
        dropdownIndex = output;
      });
    }
  }

  // int? valueCheck({required int? value}) {
  //   // Check if selectedValue exists in the new list
  //   bool valueFound = false;
  //   for (var entry in widget.dropdownList) {
  //     if (value == entry.keys.first) {
  //       valueFound = true;
  //       break;
  //     }
  //   }

  //   if (valueFound) {
  //     setState(() {
  //       required = false;
  //       dropdownIndex = value;
  //     });
  //     return value;
  //   } else {
  //     // Return a default value or the first item's key in the list
  //     setState(() {
  //       dropdownIndex = widget.dropdownList.isNotEmpty
  //           ? widget.dropdownList[0].keys.first
  //           : null;
  //     });
  //     return widget.dropdownList.isNotEmpty
  //         ? widget.dropdownList[0].keys.first
  //         : null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //
    loadInitialValues();
    dropdownIndexReset();

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
          padding: const EdgeInsets.only(top: 2, bottom: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<int>(
              isExpanded: true,
              hint: Text(
                widget.initialData ?? widget.dropdownHintText,
                style: widget.initialData == null
                    ? TextStyle(
                        letterSpacing: 1,
                        fontSize: CFGFont.smallFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.lightGreyFontColor,
                      )
                    : TextStyle(
                        fontSize: CFGFont.smallTitleFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      ),
              ),
              items: widget.dropdownList
                  .asMap()
                  .entries
                  .map((entry) => DropdownMenuItem<int>(
                        value: entry.value.keys.first,
                        child: Text(
                          entry.value.values.first,
                          style: TextStyle(
                            fontSize: CFGFont.smallTitleFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.defaultFontColor,
                          ),
                        ),
                      ))
                  .toList(),
              value: dropdownIndex,
              onMenuStateChange: (isOpen) {
                setState(() {
                  if (isOpen) {
                    dropdownButtonBorderColor = CFGTheme.button;
                  } else {
                    dropdownButtonBorderColor = CFGColor.midGrey;
                  }
                });
              },
              onChanged: (int? selectedIndex) {
                if (selectedIndex != null) {
                  widget.onChangedDropdown(selectedIndex);
                }
                setState(() {
                  debugPrint("$selectedIndex");
                  dropdownIndex = selectedIndex;
                  if (widget.isRequired && selectedIndex == null) {
                    required = true;
                  } else {
                    required = false;
                  }
                });
              },
              iconStyleData: IconStyleData(
                icon: Icon(
                  Icons.expand_more_rounded,
                  color: CFGTheme.button,
                ),
              ),
              buttonStyleData: ButtonStyleData(
                overlayColor: WidgetStatePropertyAll(CFGTheme.buttonLightGrey),
                decoration: BoxDecoration(
                  // color: CFGTheme.bgColorScreen,
                  border:
                      Border.all(width: 1, color: dropdownButtonBorderColor),
                  borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
                ),
                padding: const EdgeInsets.only(right: 20),
              ),
              dropdownStyleData: DropdownStyleData(
                useSafeArea: true,
                isOverButton: false,
                elevation: 0,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: CFGColor.lightGrey),
                  borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
                  color: CFGTheme.bgColorScreen,
                ),
                offset: const Offset(0, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                overlayColor: WidgetStatePropertyAll(CFGColor.lightGrey),
                padding: const EdgeInsets.only(left: 20, right: 20),
              ),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.only(top: 5, bottom: 10),
        //   child: DropdownButtonFormField<String>(
        //     isDense: true,
        //     isExpanded: true,
        //     itemHeight: 48,
        //     borderRadius: BorderRadius.circular(20),
        //     padding: EdgeInsets.zero,
        //     decoration: InputDecoration(
        //       contentPadding: const EdgeInsets.only(left: 20, right: 20),
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
        //         borderSide: BorderSide(
        //           color: CFGTheme.button,
        //           width: 1.0,
        //         ),
        //       ),
        //       enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
        //         borderSide: BorderSide(
        //           color: CFGColor.midGrey,
        //           width: 1.0,
        //         ),
        //       ),
        //       fillColor: CFGTheme.bgColorScreen,
        //       filled: true,
        //       hintText: widget.dropdownHintText,
        //       hintStyle: TextStyle(
        //         letterSpacing: 1,
        //         fontSize: CFGFont.smallFontSize,
        //         fontWeight: CFGFont.lightFontWeight,
        //         color: CFGFont.greyFontColor,
        //       ),
        //       floatingLabelBehavior: FloatingLabelBehavior.never,
        //       border: OutlineInputBorder(
        //         borderRadius:
        //             BorderRadius.all(Radius.circular(CFGTheme.cardRadius)),
        //       ),
        //     ),
        //     focusColor: CFGTheme.bgColorScreen,
        //     dropdownColor: CFGTheme.bgColorScreen,
        //     value: dropdownValue,
        //     icon: Icon(
        //       Icons.expand_more_rounded,
        //       color: CFGTheme.button,
        //     ),
        //     elevation: 0,
        //     onChanged: (String? value) {
        //       // This is called when the user selects an item.
        //       setState(() {
        //         dropdownValue = value!;
        //       });
        //     },
        //     items: list.map<DropdownMenuItem<String>>((String value) {
        //       return DropdownMenuItem<String>(
        //         value: value,
        //         child: Text(
        //           value,
        //           style: TextStyle(
        //             fontSize: CFGFont.smallTitleFontSize,
        //             fontWeight: CFGFont.regularFontWeight,
        //             color: CFGFont.defaultFontColor,
        //           ),
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // ),
      ],
    );
  }
}
