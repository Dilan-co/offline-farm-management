import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/task/task.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskViewAndCompletion extends StatefulWidget {
  const TaskViewAndCompletion({
    super.key,
  });

  @override
  State<TaskViewAndCompletion> createState() => _TaskViewAndCompletionState();
}

class _TaskViewAndCompletionState extends State<TaskViewAndCompletion> {
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

  //Complete Task
  onComplete({required TaskModel taskData}) async {
    //Save Task data to DB here
    await updateRecord(taskData: taskData);
    //After saving, reload the task list
    load();
  }

  Future<int> updateRecord({required TaskModel taskData}) async {
    //Remember to add Bind ID to update the record. Don't keep it "null"
    try {
      DateTime now = DateTime.now();
      String updatedAt =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

      TaskModel dataModel = TaskModel(
        taskId: taskData.taskId,
        userId: taskData.userId,
        area: taskData.area,
        section: taskData.section,
        date: taskData.date,
        description: taskData.description,
        isCompleted: 1,
        createdBy: taskData.createdBy,
        updatedAt: updatedAt,
        isSynced: 0,
      );

      int recordId = await Task().updateRecord(model: dataModel);

      debugPrint("------- Record ID -------");
      debugPrint("$recordId");
      return recordId;
    } catch (error) {
      debugPrint('Error updating record: $error');
      // Return an appropriate value or rethrow the exception if needed
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        appBar: AppBar(
          toolbarHeight: AppBar().preferredSize.height *
              stateController.getDeviceAppBarMultiplier(),
          backgroundColor: CFGTheme.bgColorScreen,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Task List - Today",
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
                      backgroundColor: WidgetStatePropertyAll(CFGTheme.button),
                      // iconColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: CFGTheme.appBarButtonImg,
                      size: 28 * stateController.getDeviceAppBarMultiplier()
                          as double,
                    ));
              }),
            ),
          ],
        ),
        body: FutureBuilder<Object>(
            future: loadingFuture,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(
                  left: CFGTheme.bodyLRPadding,
                  right: CFGTheme.bodyLRPadding,
                  // top: CFGTheme.bodyTBPadding,
                  bottom: CFGTheme.bodyTBPadding,
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemCount: taskList.length,
                  separatorBuilder: (context, index) => Divider(height: 32),
                  itemBuilder: (context, index) {
                    final task = taskList[index];
                    bool isCompleted = task.isCompleted == 1;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        Text('${task.area} - ${task.section}',
                            style: TextStyle(
                              fontSize: CFGFont.smallTitleFontSize,
                              fontWeight: CFGFont.mediumFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),

                        const SB(height: 8),

                        Text(task.description ?? "",
                            style: TextStyle(
                              fontSize: CFGFont.defaultFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),

                        const SB(height: 12),

                        Center(
                            child: isCompleted
                                ? TextButton(
                                    style: ButtonStyle(
                                      fixedSize: const WidgetStatePropertyAll(
                                          Size(150, 44)),
                                      backgroundColor: WidgetStatePropertyAll(
                                          CFGTheme.bgColorScreen),
                                      overlayColor: WidgetStatePropertyAll(
                                          CFGTheme.buttonOverlay),
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: CFGTheme.button),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CFGTheme.buttonRadius))),
                                    ),
                                    onPressed: null,
                                    child: Text("Completed",
                                        style: TextStyle(
                                          height: 0,
                                          fontSize: CFGFont.subTitleFontSize,
                                          fontWeight: CFGFont.regularFontWeight,
                                          color: CFGFont.defaultFontColor,
                                        )),
                                  )
                                : TextButton(
                                    style: ButtonStyle(
                                      fixedSize: const WidgetStatePropertyAll(
                                          Size(150, 44)),
                                      backgroundColor: WidgetStatePropertyAll(
                                          CFGTheme.button),
                                      overlayColor: WidgetStatePropertyAll(
                                          CFGTheme.buttonOverlay),
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CFGTheme.buttonRadius))),
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                        barrierDismissible: true,
                                        barrierColor: const Color(0x60000000),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 0,
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            backgroundColor:
                                                CFGTheme.bgColorScreen,
                                            titlePadding:
                                                const EdgeInsets.only(top: 30),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 15, bottom: 30),
                                            // actionsPadding: const EdgeInsets.only(bottom: 30),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        CFGTheme.cardRadius)),
                                            title: Text(
                                              "Confirm Task Completion",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: CFGFont.titleFontSize,
                                                fontWeight:
                                                    CFGFont.mediumFontWeight,
                                                color: CFGFont.defaultFontColor,
                                              ),
                                            ),
                                            content: Container(
                                              constraints: BoxConstraints(
                                                  minWidth:
                                                      mediaQuerySize.width *
                                                          0.3),
                                              child: Text(
                                                "Are you sure?",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: CFGFont
                                                      .smallTitleFontSize,
                                                  fontWeight:
                                                      CFGFont.regularFontWeight,
                                                  color:
                                                      CFGFont.defaultFontColor,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: ButtonStyle(
                                                  fixedSize:
                                                      const WidgetStatePropertyAll(
                                                          Size(80, 40)),
                                                  overlayColor:
                                                      WidgetStatePropertyAll(
                                                          CFGTheme
                                                              .buttonOverlay),
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          CFGTheme.button),
                                                  shape: WidgetStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(CFGTheme
                                                                .buttonRadius)),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                    height: 0,
                                                    fontSize:
                                                        CFGFont.defaultFontSize,
                                                    fontWeight: CFGFont
                                                        .mediumFontWeight,
                                                    color:
                                                        CFGFont.whiteFontColor,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  //Mark the task as completed and update record
                                                  onComplete(taskData: task);
                                                  Get.back();
                                                },
                                              ),

                                              const SB(width: 10),

                                              //
                                              TextButton(
                                                style: ButtonStyle(
                                                  fixedSize:
                                                      const WidgetStatePropertyAll(
                                                          Size(80, 40)),
                                                  overlayColor:
                                                      WidgetStatePropertyAll(
                                                          CFGTheme
                                                              .buttonOverlay),
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          CFGColor.lightGrey),
                                                  shape: WidgetStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(CFGTheme
                                                                .buttonRadius)),
                                                  ),
                                                ),
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                    height: 0,
                                                    fontSize:
                                                        CFGFont.defaultFontSize,
                                                    fontWeight: CFGFont
                                                        .mediumFontWeight,
                                                    color: CFGFont
                                                        .defaultFontColor,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Tap to Complete",
                                        style: TextStyle(
                                          height: 0,
                                          fontSize: CFGFont.subTitleFontSize,
                                          fontWeight: CFGFont.regularFontWeight,
                                          color: CFGFont.whiteFontColor,
                                        )),
                                  )),
                      ],
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
