import 'package:farm_management/configs/font.dart';
import 'package:farm_management/database/tables/task/task.dart';
import 'package:farm_management/database/tables/user/user.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';

class CompletedAndIncompletedTask extends StatefulWidget {
  const CompletedAndIncompletedTask({super.key});

  @override
  State<CompletedAndIncompletedTask> createState() =>
      _CompletedAndIncompletedTaskState();
}

class _CompletedAndIncompletedTaskState
    extends State<CompletedAndIncompletedTask> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  List<TaskModel> recordList = [];
  List<TaskModel> completedRecordList = [];
  List<TaskModel> incompletedRecordList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      recordList = await Task().fetchTodayOrOlderRecords();
      // Split records into completed and incompleted lists
      completedRecordList =
          recordList.where((task) => task.isCompleted == 1).toList();
      incompletedRecordList =
          recordList.where((task) => task.isCompleted != 1).toList();

      debugPrint(
          "Total: ${recordList.length}, Completed: ${completedRecordList.length}, Incomplete: ${incompletedRecordList.length}");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  Future<bool> deleteRecord(TaskModel dataObject) async {
    try {
      int recordId = await Task().deleteRecord(model: dataObject);
      debugPrint("Deleted Record from table where id = $recordId");
      return true;
    } catch (error) {
      debugPrint('Error updating record: $error');
      // Return an appropriate value or rethrow the exception if needed
      rethrow;
    }
  }

  onDelete(bool delete, dynamic dataObject) async {
    if (delete == true) {
      await deleteRecord(dataObject);
      setState(() {
        loadingFuture = loadRecords();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CFGTheme.bgColorScreen,
          drawerEnableOpenDragGesture: false,
          appBar: SimpleFormsAppBar(
              title: "Completed & Incomplete Tasks", isMainTile: true),

          //
          body: Column(
            children: [
              // TabBar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: CFGTheme.buttonLightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: CFGTheme.button,
                  ),
                  labelColor: CFGFont.whiteFontColor,
                  unselectedLabelColor: CFGFont.defaultFontColor,
                  labelStyle: const TextStyle(
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.mediumFontWeight,
                  ),
                  tabs: const [
                    Tab(text: 'Completed'),
                    Tab(text: 'Incomplete'),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    // Completed task tiles
                    //
                    FutureBuilder<Object>(
                        future: loadingFuture,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: CFGTheme.bodyLRPadding,
                              right: CFGTheme.bodyLRPadding,
                              // top: CFGTheme.bodyTBPadding,
                              bottom: CFGTheme.bodyTBPadding,
                            ),
                            child: ListView.builder(
                                // physics: BouncingScrollPhysics(),
                                // padding: const EdgeInsets.only(top: 10, bottom: 10),
                                itemCount: completedRecordList.length,
                                itemBuilder: (context, index) {
                                  String? formattedDate;
                                  String? workerName;

                                  Future<bool> loadRecordData() async {
                                    try {
                                      UserModel? workerData = await User()
                                          .fetchById(
                                              userId: completedRecordList[index]
                                                  .userId);
                                      workerName = workerData?.displayName;
                                      debugPrint(workerName);
                                      // Format the date to only show the date part
                                      formattedDate = completedRecordList[index]
                                          .date
                                          .toString()
                                          .split(' ')
                                          .first;
                                      return true;
                                    } catch (e) {
                                      debugPrint('Error loading data: $e');
                                      return false;
                                    }
                                  }

                                  return FutureBuilder(
                                      future: loadRecordData(),
                                      builder: (context, asyncSnapshot) {
                                        return GestureDetector(
                                          child: SimpleFormsTileViewCard(
                                            dataObject:
                                                completedRecordList[index],
                                            onDelete: onDelete,
                                            viewRouter: NavRoute.taskView,
                                            updateRouter: NavRoute.taskUpdate,
                                            editButtonHidden: true,
                                            deleteButtonHidden: true,
                                            lastModifiedDateHidden: true,
                                            lastModifiedDate: "",
                                            textFieldOneLabel: "Area & Section",
                                            textFieldOneData:
                                                "${completedRecordList[index].area} - ${completedRecordList[index].section}",
                                            textFieldTwoLabel: "Date",
                                            textFieldTwoData:
                                                formattedDate ?? "",
                                            textFieldThreeLabel: "Worker",
                                            textFieldThreeData:
                                                workerName ?? "",
                                            textFieldFourLabel: "Description",
                                            textFieldFourData:
                                                completedRecordList[index]
                                                        .description ??
                                                    "",
                                            textFieldFourMaxLines: 5,
                                          ),
                                          onTap: () {
                                            //open view
                                            // Get.to(() => ProductBatchLabelAssessmentView());
                                          },
                                        );
                                      });
                                }),
                          );
                        }),

                    // Incomplete task tiles
                    FutureBuilder<Object>(
                        future: loadingFuture,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: CFGTheme.bodyLRPadding,
                              right: CFGTheme.bodyLRPadding,
                              // top: CFGTheme.bodyTBPadding,
                              bottom: CFGTheme.bodyTBPadding,
                            ),
                            child: ListView.builder(
                                // physics: BouncingScrollPhysics(),
                                // padding: const EdgeInsets.only(top: 10, bottom: 10),
                                itemCount: incompletedRecordList.length,
                                itemBuilder: (context, index) {
                                  String? formattedDate;
                                  String? workerName;

                                  Future<bool> loadRecordData() async {
                                    try {
                                      UserModel? workerData = await User()
                                          .fetchById(
                                              userId:
                                                  incompletedRecordList[index]
                                                      .userId);
                                      workerName = workerData?.displayName;
                                      debugPrint(workerName);
                                      // Format the date to only show the date part
                                      formattedDate =
                                          incompletedRecordList[index]
                                              .date
                                              .toString()
                                              .split(' ')
                                              .first;
                                      return true;
                                    } catch (e) {
                                      debugPrint('Error loading data: $e');
                                      return false;
                                    }
                                  }

                                  return FutureBuilder(
                                      future: loadRecordData(),
                                      builder: (context, asyncSnapshot) {
                                        return GestureDetector(
                                          child: SimpleFormsTileViewCard(
                                            dataObject:
                                                incompletedRecordList[index],
                                            onDelete: onDelete,
                                            viewRouter: NavRoute.taskView,
                                            updateRouter: NavRoute.taskUpdate,
                                            editButtonHidden: true,
                                            deleteButtonHidden: true,
                                            lastModifiedDateHidden: true,
                                            lastModifiedDate: "",
                                            textFieldOneLabel: "Area & Section",
                                            textFieldOneData:
                                                "${incompletedRecordList[index].area} - ${incompletedRecordList[index].section}",
                                            textFieldTwoLabel: "Date",
                                            textFieldTwoData:
                                                formattedDate ?? "",
                                            textFieldThreeLabel: "Worker",
                                            textFieldThreeData:
                                                workerName ?? "",
                                            textFieldFourLabel: "Description",
                                            textFieldFourData:
                                                incompletedRecordList[index]
                                                        .description ??
                                                    "",
                                            textFieldFourMaxLines: 5,
                                          ),
                                          onTap: () {
                                            //open view
                                            // Get.to(() => ProductBatchLabelAssessmentView());
                                          },
                                        );
                                      });
                                }),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
