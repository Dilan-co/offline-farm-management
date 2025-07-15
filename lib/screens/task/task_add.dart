import 'package:farm_management/database/tables/task/task.dart';
import 'package:farm_management/models/table_models/task/task_model.dart';
import 'package:farm_management/screens/task/task_main_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/services/get_value_for_key.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/form_date_picker.dart';
import 'package:farm_management/widgets/form_dropdown.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:permission_handler/permission_handler.dart';

class TaskAdd extends StatefulWidget {
  final bool isUpdate;
  final TaskModel? data;
  const TaskAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<TaskAdd> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  final StateController stateController = Get.find();
  late Future<bool> loadingFuture;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingFuture = loadRecordData();
    });
  }

  Future<bool> loadRecordData() async {
    if (widget.data != null) {
      try {
        setState(() {
          area = widget.data!.area;
          section = widget.data!.section;
          date = widget.data!.date;
          worker = widget.data!.userId;
          description = widget.data!.description;
        });
        //Dropdown initial values
        workerName = getValueForKey(worker!, stateController.workerList);
        debugPrint(workerName);
        return true;
      } catch (e) {
        debugPrint('Error loading data: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  //For initialData
  String? workerName;

  int? worker;
  String? area;
  String? section;
  String? date;
  String? description;

  onChangedArea(String? output) {
    setState(() {
      area = output;
    });
    debugPrint(area);
  }

  onChangedSection(String? output) {
    setState(() {
      section = output;
    });
    debugPrint(section);
  }

  onChangedDate(String? output) {
    setState(() {
      date = output;
    });
    debugPrint(date);
  }

  onChangedDropdownWorker(int? output) {
    setState(() {
      worker = output;
    });
    debugPrint("$output");
  }

  onChangedDescription(String? output) {
    setState(() {
      description = output;
    });
    debugPrint(description);
  }

  Future<int> createRecord() async {
    try {
      DateTime now = DateTime.now();
      String createdAt =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      TaskModel dataModel = TaskModel(
          taskId: null,
          area: area!,
          section: section!,
          date: date!,
          userId: worker!,
          description: description,
          isCompleted: 0,
          createdBy: stateController.getLoggedUserId(),
          updatedAt: createdAt,
          isSynced: 0);
      int recordId = await Task().createRecord(model: dataModel);
      debugPrint("------- Record ID -------");
      debugPrint("$recordId");
      return recordId;
    } catch (error) {
      debugPrint('Error creating record: $error');
      // Return an appropriate value or rethrow the exception if needed
      rethrow;
    }
  }

  Future<int> updateRecord() async {
    //Remember to add Bind ID to update the record. Don't keep it "null"
    try {
      DateTime now = DateTime.now();
      String updatedAt =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      TaskModel dataModel = TaskModel(
          taskId: widget.data!.taskId,
          area: area!,
          section: section!,
          date: date!,
          userId: worker!,
          description: description,
          isCompleted: 0,
          createdBy: stateController.getLoggedUserId(),
          updatedAt: updatedAt,
          isSynced: 0);
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

  //Saving Form Data
  onSave() async {
    //Check if required fields are filled to "Save" Form.
    if (area != null && section != null && date != null && worker != null) {
      await requestPermission(Permission.storage);
      //Add save Form data to DB here
      if (widget.isUpdate == true) {
        if (widget.data != null) {
          await updateRecord();
        }
      } else {
        await createRecord();
      }

      //Dismiss Keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      if (widget.isUpdate) {
        Get.close(2);
        Get.to(() => const TaskMainTileView());
      } else {
        Get.back(result: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: CFGTheme.bgColorScreen,
      drawerEnableOpenDragGesture: false,
      appBar: SimpleFormsAppBar(
          title: "Task Allocation", isUpdate: widget.isUpdate),
      //
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
              child: ListView(children: [
                //
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Area",
                  hintText: "Please type an area",
                  isRequired: true,
                  initialData: area,
                  onChangedText: onChangedArea,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Section",
                  hintText: "Please type a section",
                  isRequired: true,
                  initialData: section,
                  onChangedText: onChangedSection,
                ),

                FormDatePicker(
                  isUpdate: widget.isUpdate,
                  label: "Date",
                  hintText: "Tap to pick a date",
                  isRequired: true,
                  initialData: date,
                  onChangedDate: onChangedDate,
                ),

                FormDropdown(
                  isUpdate: widget.isUpdate,
                  dropdownList: stateController.workerList,
                  label: "Worker",
                  dropdownHintText: "Please select a worker",
                  isRequired: true,
                  initialData: workerName,
                  onChangedDropdown: onChangedDropdownWorker,
                ),

                FormTextField(
                  expandBox: true,
                  isUpdate: widget.isUpdate,
                  label: "Description",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: description,
                  onChangedText: onChangedDescription,
                ),

                Container(
                  color: CFGTheme.bgColorScreen,
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Cancel Button
                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(130, 44)),
                          backgroundColor:
                              WidgetStatePropertyAll(CFGColor.lightGrey),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  CFGTheme.buttonRadius))),
                        ),
                        onPressed: () {
                          //Dismiss Keyboard
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.back(result: true);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                              height: 0,
                              fontSize: CFGFont.subTitleFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),

                      //Save Button
                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(130, 44)),
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.button),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  CFGTheme.buttonRadius))),
                        ),
                        onPressed: () async {
                          await onSave();
                        },
                        child: Text("Save",
                            style: TextStyle(
                              height: 0,
                              fontSize: CFGFont.subTitleFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.whiteFontColor,
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }),
    ));
  }
}
