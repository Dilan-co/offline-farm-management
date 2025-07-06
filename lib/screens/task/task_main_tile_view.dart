import 'package:farm_management/configs/font.dart';
import 'package:farm_management/database/tables/task/task.dart';
import 'package:farm_management/database/tables/user/user.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';
import 'package:farm_management/screens/task/complete_and_incomplete_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_forms_tile_view_card.dart';

class TaskMainTileView extends StatefulWidget {
  const TaskMainTileView({super.key});

  @override
  State<TaskMainTileView> createState() => _TaskMainTileViewState();
}

class _TaskMainTileViewState extends State<TaskMainTileView> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;
  List<TaskModel> recordList = [];
  List<TaskModel> completeAndIncompleteRecordList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecords();
    });
  }

  Future<bool> loadRecords() async {
    try {
      recordList = await Task().fetchAllFutureRecords();
      completeAndIncompleteRecordList = await Task().fetchTodayOrOlderRecords();
      debugPrint(recordList.isEmpty ? "Empty List" : "${recordList[0].taskId}");
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(title: "Task Allocation", isMainTile: true),
        //
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding:
              EdgeInsets.only(bottom: 20, right: CFGTheme.bodyLRPadding - 15),
          child: SB(
            width: 60 * stateController.getDeviceAppBarMultiplier() as double,
            height: 60 * stateController.getDeviceAppBarMultiplier() as double,
            child: FloatingActionButton(
              onPressed: () async {
                dynamic result = await Get.toNamed(NavRoute.taskAdd);
                if (result == true) {
                  // The route was popped with a true value
                  setState(() {
                    loadingFuture = loadRecords();
                  });
                }
              },
              backgroundColor: CFGTheme.button,
              hoverColor: CFGTheme.buttonOverlay,
              shape: const CircleBorder(),
              child: Icon(
                Icons.add_rounded,
                size:
                    32 * stateController.getDeviceAppBarMultiplier() as double,
                color: CFGColor.white,
              ),
            ),
          ),
        ),

        //
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
                    //Tap to View Completed & Incomplete Tasks Button
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 10),
                      child: TextButton(
                        style: ButtonStyle(
                          minimumSize: WidgetStatePropertyAll(Size(
                            MediaQuery.of(context).size.width -
                                CFGTheme.bodyLRPadding,
                            44,
                          )),
                          backgroundColor: WidgetStatePropertyAll(
                              completeAndIncompleteRecordList.isNotEmpty
                                  ? CFGTheme.button
                                  : CFGTheme.buttonOverlay),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  CFGTheme.buttonRadius))),
                          // padding: const WidgetStatePropertyAll(
                          //     EdgeInsets.only(left: 40, right: 40)),
                        ),
                        onPressed: () {
                          if (completeAndIncompleteRecordList.isNotEmpty) {
                            Get.to(
                              const CompletedAndIncompletedTask(),
                            );
                          }
                        },
                        child: Text("Tap to View Completed & Incomplete Tasks",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 0,
                              fontSize: CFGFont.subTitleFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.whiteFontColor,
                            )),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                          // physics: BouncingScrollPhysics(),
                          // padding: const EdgeInsets.only(top: 10, bottom: 10),
                          itemCount: recordList.length,
                          itemBuilder: (context, index) {
                            String? formattedDate;
                            String? workerName;

                            Future<bool> loadRecordData() async {
                              try {
                                UserModel? workerData = await User().fetchById(
                                    userId: recordList[index].userId);
                                workerName = workerData?.displayName;
                                debugPrint(workerName);
                                // Format the date to only show the date part
                                formattedDate = recordList[index]
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
                                      dataObject: recordList[index],
                                      onDelete: onDelete,
                                      viewRouter: NavRoute.taskView,
                                      updateRouter: NavRoute.taskUpdate,
                                      lastModifiedDateHidden: true,
                                      lastModifiedDate: "",
                                      textFieldOneLabel: "Area & Section",
                                      textFieldOneData:
                                          "${recordList[index].area} - ${recordList[index].section}",
                                      textFieldTwoLabel: "Date",
                                      textFieldTwoData: formattedDate ?? "",
                                      textFieldThreeLabel: "Worker",
                                      textFieldThreeData: workerName ?? "",
                                      textFieldFourLabel: "Description",
                                      textFieldFourData:
                                          recordList[index].description ?? "",
                                      textFieldFourMaxLines: 5,
                                    ),
                                    onTap: () {
                                      //open view
                                      // Get.to(() => ProductBatchLabelAssessmentView());
                                    },
                                  );
                                });
                          }),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
