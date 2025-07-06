import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/lists/simple_forms/simple_form_name.dart';
import 'package:farm_management/widgets/sized_box.dart';

class SimpleFormsBottomSheet extends StatefulWidget {
  final int? index;
  const SimpleFormsBottomSheet({
    super.key,
    this.index,
  });

  @override
  State<SimpleFormsBottomSheet> createState() => _SimpleFormsBottomSheetState();
}

class _SimpleFormsBottomSheetState extends State<SimpleFormsBottomSheet> {
  final StateController stateController = Get.find();
  // String? selectedFormName;

  // List<String> formNames = [
  //   "Production/ Harvesting/ Packing Related Forms",
  //   "Equipment Related Forms",
  //   "Chemical Product Related Forms",
  //   "Water Source/Treatment Forms",
  //   "Other"
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        // const SB(height: 15),

        Container(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          decoration: BoxDecoration(
            color: CFGTheme.bgColorScreen,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 5,
              width: 64,
              decoration: const BoxDecoration(
                color: Color(0x40000000),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
        ),

        //
        const SB(height: 10),

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: CFGTheme.bodyLRPadding,
              right: CFGTheme.bodyLRPadding,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              // physics: const BouncingScrollPhysics(),
              itemCount: SimpleFormName().formNames.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RadioListTile(
                    // overlayColor:
                    //     WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                    dense: true,
                    toggleable: false,
                    title: Text(SimpleFormName().formNames.elementAt(index),
                        style: TextStyle(
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: SimpleFormName().formNames.elementAt(index) ==
                                  stateController.getSelectedSimpleFormName()
                              ? CFGFont.whiteFontColor
                              : CFGFont.defaultFontColor,
                        )),
                    value: SimpleFormName().formNames.elementAt(index),
                    groupValue: stateController.getSelectedSimpleFormName(),
                    selected: SimpleFormName().formNames.elementAt(index) ==
                            stateController.getSelectedSimpleFormName()
                        ? true
                        : false,
                    enableFeedback: true,
                    contentPadding: const EdgeInsets.only(left: 5, right: 5),
                    //spacing between radio and text
                    visualDensity: const VisualDensity(horizontal: -4.0),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: CFGTheme.button),
                        borderRadius: BorderRadius.circular(5)),
                    activeColor: CFGTheme.appBarButtonImg,
                    selectedTileColor: CFGTheme.button,
                    onChanged: (value) async {
                      setState(() {
                        stateController
                            .setSelectedSimpleFormName(value!.toString());
                        debugPrint(value.toString());
                      });
                      Navigator.pop(context, value.toString());
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
