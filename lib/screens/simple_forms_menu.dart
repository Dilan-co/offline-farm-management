// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/bottom_sheets/simple_forms_bottom_sheet.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/lists/simple_forms/simple_forms_sub_category.dart';
import 'package:farm_management/lists/simple_forms/simple_form_name.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/drawer_menu.dart';
import 'package:farm_management/widgets/simple_forms_listview_builder.dart';

class SimpleFormsMenu extends StatefulWidget {
  const SimpleFormsMenu({super.key});

  @override
  State<SimpleFormsMenu> createState() => _SimpleFormsMenuState();
}

class _SimpleFormsMenuState extends State<SimpleFormsMenu> {
  final StateController stateController = Get.find();

  String formName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      formName = SimpleFormName().formNames.elementAt(0);
      stateController
          .setSelectedSimpleFormName(SimpleFormName().formNames.elementAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    //-------- Uncomment After Implementing API --------
    //Generating Dropdown Lists
    // DropdownList().generateDropdownLists();

    //--------------------------------------------------
    Size mediaQuerySize = MediaQuery.of(context).size;

    //PopScope "false" to disable back button
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        debugPrint("Pop Disabled");
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CFGTheme.bgColorScreen,
          drawer: DrawerMenu(),
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            toolbarHeight: AppBar().preferredSize.height *
                stateController.getDeviceAppBarMultiplier(),
            backgroundColor: CFGTheme.bgColorScreen,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Column(
              children: [
                Text("Simple Forms",
                    style: TextStyle(
                      fontSize: CFGFont.titleFontSize,
                      fontWeight: CFGFont.boldFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
                const SB(height: 2),
                Text("Select the form type",
                    style: TextStyle(
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: CFGTheme.bodyLRPadding),
                child: Builder(builder: (context) {
                  return IconButton.filled(
                      padding: EdgeInsets.all(
                          stateController.getDeviceAppBarMultiplier() != 1.0
                              ? 10 * stateController.getDeviceAppBarMultiplier()
                                  as double
                              : 0),
                      style: ButtonStyle(
                        overlayColor:
                            WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                        backgroundColor:
                            WidgetStatePropertyAll(CFGTheme.button),
                        // iconColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.widgets_outlined,
                        color: CFGTheme.appBarButtonImg,
                        size: 28 * stateController.getDeviceAppBarMultiplier()
                            as double,
                      ));
                }),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: CFGTheme.bodyLRPadding,
              right: CFGTheme.bodyLRPadding,
              // top: CFGTheme.bodyTBPadding,
              bottom: CFGTheme.bodyTBPadding,
            ),
            child: Column(
              children: [
                //
                OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                      overlayColor:
                          WidgetStatePropertyAll(CFGTheme.buttonLightGrey),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.only(left: 10, right: 10)),
                      side: WidgetStatePropertyAll(BorderSide(
                        color: CFGTheme.button,
                        width: 1,
                      )),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Text(formName,
                          style: TextStyle(
                            height: 0,
                            fontSize: CFGFont.defaultFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.defaultFontColor,
                          )),

                      Icon(
                        Icons.expand_more_rounded,
                        color: CFGTheme.button,
                      )

                      // SvgPicture.asset(
                      //   CFGImage.appBarButton,
                      //   colorFilter:
                      //       ColorFilter.mode(CFGColor.black, BlendMode.srcIn),
                      //   // color: Colors.white,
                      //   height: 18,
                      //   width: 18,
                      // ),
                    ],
                  ),
                  onPressed: () async {
                    //bottom sheet
                    showModalBottomSheet(
                        //to make the bottom sheet full width of the screen
                        // constraints: BoxConstraints(
                        //   maxWidth: mediaQuerySize.width,
                        // ),
                        barrierColor: const Color(0x20000000),
                        isScrollControlled: true,
                        enableDrag: true,
                        isDismissible: true,
                        elevation: 0,
                        backgroundColor: CFGTheme.bgColorScreen,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return SB(
                            height: mediaQuerySize.height * 0.4,
                            child: const SimpleFormsBottomSheet(),
                          );
                        }).then((value) {
                      if (value != null) {
                        setState(() {
                          formName = value;
                        });
                      }
                    });
                  },
                ),

                //
                const SB(height: 10),

                //Selected Item List Builder
                stateController.getSelectedSimpleFormName() ==
                        SimpleFormName().formNames.elementAt(0)
                    ? SimpleFormsListViewBuilder(
                        simpleFormsSubCategory:
                            "SimpleFormsSubCategory().productionHarvestingPackagingForms",
                        simpleFormsSubCategoryList: SimpleFormsSubCategory()
                            .productionHarvestingPackagingForms,
                      )
                    : stateController.getSelectedSimpleFormName() ==
                            SimpleFormName().formNames.elementAt(1)
                        ? SimpleFormsListViewBuilder(
                            simpleFormsSubCategory:
                                "SimpleFormsSubCategory().equipmentRelatedForms",
                            simpleFormsSubCategoryList:
                                SimpleFormsSubCategory().equipmentRelatedForms,
                          )
                        : stateController.getSelectedSimpleFormName() ==
                                SimpleFormName().formNames.elementAt(2)
                            ? SimpleFormsListViewBuilder(
                                simpleFormsSubCategory:
                                    "SimpleFormsSubCategory().waterSourceTreatmentForms",
                                simpleFormsSubCategoryList:
                                    SimpleFormsSubCategory()
                                        .waterSourceTreatmentForms,
                              )
                            : const SB(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
