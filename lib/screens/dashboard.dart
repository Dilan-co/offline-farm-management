import 'package:farm_management/configs/color.dart';
import 'package:farm_management/database/tables/task/task.dart';
import 'package:farm_management/lists/dropdown_list.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';
import 'package:farm_management/screens/task_view_and_completion.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/widgets/drawer_menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  List<TaskModel> taskList = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      taskList = await Task().fetchAllTodayRecords();
      debugPrint(taskList.isEmpty ? "Empty List" : "${taskList[0].taskId}");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Generating Dropdown Lists
    DropdownList().generateDropdownLists();

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
            title: Text("Dashboard",
                style: TextStyle(
                  fontSize: CFGFont.titleFontSize,
                  fontWeight: CFGFont.boldFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
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
            child: FutureBuilder<Object>(
                future: loadingFuture,
                builder: (context, asyncSnapshot) {
                  return Column(
                    children: [
                      //
                      Text("Task List - Today",
                          style: TextStyle(
                            fontSize: CFGFont.subTitleFontSize,
                            fontWeight: CFGFont.mediumFontWeight,
                            color: CFGFont.defaultFontColor,
                          )),

                      Divider(
                        color: CFGColor.lightGrey,
                        height: 15,
                        indent: CFGTheme.bodyLRPadding,
                        endIndent: CFGTheme.bodyLRPadding,
                      ),

                      Expanded(
                        child: taskList.isEmpty
                            ? Center(
                                child: Text("No tasks available for Today.",
                                    style: TextStyle(
                                      fontSize: CFGFont.subTitleFontSize,
                                      fontWeight: CFGFont.regularFontWeight,
                                      color: CFGFont.greyFontColor,
                                    )))
                            : ListView.builder(
                                // physics: BouncingScrollPhysics(),
                                // padding: const EdgeInsets.only(top: 10, bottom: 10),
                                // shrinkWrap: true,
                                itemCount: taskList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: SimpleFormsTileViewCard(
                                      lastModifiedDateHidden: true,
                                      viewButtonHidden: true,
                                      editButtonHidden: true,
                                      deleteButtonHidden: true,
                                      isTaskCompleted:
                                          taskList[index].isCompleted == 1,
                                      dataObject: taskList[index],
                                      viewRouter: "",
                                      updateRouter: "",
                                      lastModifiedDate: "",
                                      textFieldOneLabel: "Area",
                                      textFieldOneData: taskList[index].area,
                                      textFieldTwoLabel: "Section",
                                      textFieldTwoData: taskList[index].section,
                                      textFieldFourLabel: "Task Description",
                                      textFieldFourData:
                                          taskList[index].description ?? "",
                                      textFieldFourMaxLines: 3,
                                    ),
                                    onTap: () {
                                      //open view
                                    },
                                  );
                                }),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          style: ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(
                              MediaQuery.of(context).size.width -
                                  CFGTheme.bodyLRPadding,
                              44,
                            )),
                            backgroundColor: WidgetStatePropertyAll(
                                taskList.isNotEmpty
                                    ? CFGTheme.button
                                    : CFGTheme.buttonOverlay),
                            overlayColor:
                                WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        CFGTheme.buttonRadius))),
                            // padding: const WidgetStatePropertyAll(
                            //     EdgeInsets.only(left: 40, right: 40)),
                          ),
                          onPressed: () {
                            if (taskList.isNotEmpty) {
                              // Get.to(
                              //   const TaskViewAndCompletion(),
                              // );
                              Get.to(const TaskViewAndCompletion())?.then((_) {
                                // Reload the dashboard data when back
                                load();
                              });
                            }
                          },
                          child: Text("View & Complete Tasks",
                              style: TextStyle(
                                height: 0,
                                fontSize: CFGFont.subTitleFontSize,
                                fontWeight: CFGFont.regularFontWeight,
                                color: CFGFont.whiteFontColor,
                              )),
                        ),
                      ),

                      const SB(height: 10)
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
