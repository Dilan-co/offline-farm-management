import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/database/tables/org/org_equipment_type.dart';
import 'package:farm_management/models/table_models/org/org_equipment_type_model.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/asset_type/asset_type_main_tile_view.dart';
import 'package:farm_management/services/request_permission.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:farm_management/widgets/form_toggle_switch_button.dart';
import 'package:permission_handler/permission_handler.dart';

class AssetTypeAdd extends StatefulWidget {
  final bool isUpdate;
  final OrgEquipmentTypeModel? data;
  const AssetTypeAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<AssetTypeAdd> createState() => _AssetTypeAddState();
}

class _AssetTypeAddState extends State<AssetTypeAdd> {
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
          assetType = widget.data!.name;
          description = widget.data!.description;
          status = widget.data!.status;
        });
        return true;
      } catch (e) {
        debugPrint('Error loading data: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  String? assetType;
  String? description;
  int? status;

  onChangedAssetType(String? output) {
    setState(() {
      assetType = output;
    });
    debugPrint(assetType);
  }

  onChangedDescription(String? output) {
    setState(() {
      description = output;
    });
    debugPrint(description);
  }

  onChangedStatus(bool? output) {
    setState(() {
      if (output == true) {
        status = 1;
      } else {
        status = 0;
      }
    });
    debugPrint("$status");
  }

  Future<int> createRecord() async {
    try {
      OrgEquipmentTypeModel dataModel = OrgEquipmentTypeModel(
          equipmentTypeId: null,
          name: assetType ?? "",
          description: description ?? "",
          status: status ?? 0,
          deleted: 0,
          isSynced: 0);
      int recordId = await OrgEquipmentType().createRecord(model: dataModel);
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
      OrgEquipmentTypeModel dataModel = OrgEquipmentTypeModel(
          equipmentTypeId: widget.data!.equipmentTypeId,
          name: assetType ?? "",
          description: description ?? "",
          status: status ?? 0,
          deleted: 0,
          isSynced: 0);
      int recordId = await OrgEquipmentType().updateRecord(model: dataModel);
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
    if (assetType != null) {
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
        Get.to(() => const AssetTypeMainTileView());
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
      appBar: SimpleFormsAppBar(title: "Asset Type", isUpdate: widget.isUpdate),
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
                  label: "Asset type",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: assetType,
                  onChangedText: onChangedAssetType,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Description",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: description,
                  onChangedText: onChangedDescription,
                ),

                //toggle button
                FormToggleSwitchButton(
                  label: "Status",
                  trueLabel: "Active",
                  falseLabel: "Inactive",
                  initialSwitchValue: status,
                  onChangedSwitch: onChangedStatus,
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
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
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
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
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
