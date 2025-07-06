import 'package:farm_management/database/tables/user/user.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class TaskView extends StatefulWidget {
  final String updateRouter;
  final TaskModel data;
  final Function(bool, TaskModel) onDelete;
  const TaskView({
    super.key,
    required this.updateRouter,
    required this.data,
    required this.onDelete,
  });

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final StateController stateController = Get.find();
  String? workerName;
  String? supervisorName;

  @override
  void initState() {
    super.initState();
    //Load Data from IDs
    loadRecordData();
  }

  Future<bool> loadRecordData() async {
    try {
      UserModel? workerData =
          await User().fetchById(userId: widget.data.userId);
      //
      UserModel? supervisorData =
          await User().fetchById(userId: widget.data.createdBy ?? 0);
      setState(() {
        workerName = workerData?.displayName;
        supervisorName = supervisorData?.displayName;
      });
      debugPrint(workerName);
      debugPrint("Created By: $supervisorName");
      return true;
    } catch (e) {
      debugPrint('Error loading data: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.updateRouter);
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(title: "Task Allocation", isView: true),
        //
        body: Padding(
          padding: EdgeInsets.only(
            left: CFGTheme.bodyLRPadding,
            right: CFGTheme.bodyLRPadding,
            // top: CFGTheme.bodyTBPadding,
            bottom: CFGTheme.bodyTBPadding,
          ),
          child: ListView(
            children: [
              //
              const SB(height: 10),

              FormViewTextRow(
                label: "Area",
                data: widget.data.area,
              ),
              FormViewTextRow(
                label: "Section",
                data: widget.data.section,
              ),
              FormViewTextRow(
                label: "Date",
                data: widget.data.date,
              ),
              FormViewTextRow(
                label: "Worker",
                data: workerName,
              ),
              FormViewTextRow(
                label: "Task Description",
                data: widget.data.description,
              ),
              FormViewTextRow(
                label: "Is Completed",
                data: widget.data.isCompleted == 1 ? "YES" : "NO",
              ),
              FormViewTextRow(
                label: "Created By",
                data: supervisorName,
              ),
              FormViewTextRow(
                label: "Updated At",
                data: widget.data.updatedAt,
              ),

              //
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SB(
                      height: 36,
                      width: 36,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                            shape:
                                const WidgetStatePropertyAll(CircleBorder())),
                        onPressed: () {
                          Get.toNamed(
                            widget.updateRouter,
                            arguments: widget.data,
                          );
                        },
                        icon: SvgPicture.asset(
                          CFGImage.edit,
                          colorFilter: ColorFilter.mode(
                              CFGTheme.button, BlendMode.srcIn),
                          // color: Colors.white,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),

                    //
                    const SB(width: 20),

                    SB(
                      height: 36,
                      width: 36,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                            shape:
                                const WidgetStatePropertyAll(CircleBorder())),
                        onPressed: () {
                          // Get.to(() => SimpleFormsDelete());

                          showDialog(
                            barrierDismissible: true,
                            barrierColor: const Color(0x60000000),
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                elevation: 0,
                                actionsAlignment: MainAxisAlignment.center,
                                backgroundColor: CFGTheme.bgColorScreen,
                                titlePadding: const EdgeInsets.only(top: 30),
                                contentPadding:
                                    const EdgeInsets.only(top: 15, bottom: 30),
                                // actionsPadding: const EdgeInsets.only(bottom: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        CFGTheme.cardRadius)),
                                title: Text(
                                  "Delete",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: CFGFont.titleFontSize,
                                    fontWeight: CFGFont.mediumFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  ),
                                ),
                                content: Container(
                                  constraints: BoxConstraints(
                                      minWidth: mediaQuerySize.width * 0.3),
                                  child: Text(
                                    "Are you sure?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: CFGFont.smallTitleFontSize,
                                      fontWeight: CFGFont.regularFontWeight,
                                      color: CFGFont.defaultFontColor,
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: ButtonStyle(
                                      fixedSize: const WidgetStatePropertyAll(
                                          Size(80, 40)),
                                      overlayColor: WidgetStatePropertyAll(
                                          CFGTheme.buttonOverlay),
                                      backgroundColor: WidgetStatePropertyAll(
                                          CFGTheme.button),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                CFGTheme.buttonRadius)),
                                      ),
                                    ),
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        height: 0,
                                        fontSize: CFGFont.defaultFontSize,
                                        fontWeight: CFGFont.mediumFontWeight,
                                        color: CFGFont.whiteFontColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      widget.onDelete(true, widget.data);
                                      Get.close(2);
                                    },
                                  ),

                                  const SB(width: 10),

                                  //
                                  TextButton(
                                    style: ButtonStyle(
                                      fixedSize: const WidgetStatePropertyAll(
                                          Size(80, 40)),
                                      overlayColor: WidgetStatePropertyAll(
                                          CFGTheme.buttonOverlay),
                                      backgroundColor: WidgetStatePropertyAll(
                                          CFGColor.lightGrey),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                CFGTheme.buttonRadius)),
                                      ),
                                    ),
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        height: 0,
                                        fontSize: CFGFont.defaultFontSize,
                                        fontWeight: CFGFont.mediumFontWeight,
                                        color: CFGFont.defaultFontColor,
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
                        icon: SvgPicture.asset(
                          CFGImage.delete,
                          colorFilter: ColorFilter.mode(
                              CFGTheme.button, BlendMode.srcIn),
                          // color: Colors.white,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
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
