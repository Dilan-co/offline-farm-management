import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/database/tables/org/org_equipment_manufacturer.dart';
import 'package:farm_management/models/table_models/org/org_equipment_manufacturer_model.dart';
import 'package:farm_management/screens/simple_forms/equipment_related_forms/equipment_supplier/equipment_supplier_main_tile_view.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/form_textfield.dart';
import 'package:farm_management/widgets/form_toggle_switch_button.dart';

class EquipmentSupplierAdd extends StatefulWidget {
  final bool isUpdate;
  final OrgEquipmentManufacturerModel? data;
  const EquipmentSupplierAdd({
    super.key,
    this.isUpdate = false,
    this.data,
  });

  @override
  State<EquipmentSupplierAdd> createState() => _EquipmentSupplierAddState();
}

class _EquipmentSupplierAddState extends State<EquipmentSupplierAdd> {
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
          equipmentSupplier = widget.data!.name;
          email = widget.data!.email;
          phoneMobile = widget.data!.phoneMobile;
          phoneOfficeOne = widget.data!.phoneOfficeOne;
          phoneOfficeTwo = widget.data!.phoneOfficeTwo;
          address = widget.data!.address;
          state = widget.data!.state;
          country = widget.data!.country;
          comment = widget.data!.comment;
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

  String? equipmentSupplier;
  String? email;
  String? phoneMobile;
  String? phoneOfficeOne;
  String? phoneOfficeTwo;
  String? address;
  String? state;
  String? country;
  String? comment;
  int? status;

  onChangedEquipmentSupplier(String output) {
    setState(() {
      equipmentSupplier = output;
    });
    debugPrint(equipmentSupplier);
  }

  onChangedEmail(String output) {
    setState(() {
      email = output;
    });
    debugPrint(email);
  }

  onChangedPhoneNumber(String output) {
    setState(() {
      phoneMobile = output;
    });
    debugPrint(phoneMobile);
  }

  onChangedPhoneOfficeOne(String output) {
    setState(() {
      phoneOfficeOne = output;
    });
    debugPrint(phoneOfficeOne);
  }

  onChangedPhoneOfficeTwo(String output) {
    setState(() {
      phoneOfficeTwo = output;
    });
    debugPrint(phoneOfficeTwo);
  }

  onChangedAddress(String output) {
    setState(() {
      address = output;
    });
    debugPrint(address);
  }

  onChangedState(String output) {
    setState(() {
      state = output;
    });
    debugPrint(state);
  }

  onChangedCountry(String output) {
    setState(() {
      country = output;
    });
    debugPrint(country);
  }

  onChangedComment(String output) {
    setState(() {
      comment = output;
    });
    debugPrint(comment);
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
      DateTime now = DateTime.now();
      String createdAt =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      OrgEquipmentManufacturerModel dataModel = OrgEquipmentManufacturerModel(
          equipmentManufacturerId: null,
          name: equipmentSupplier!,
          phoneMobile: phoneMobile,
          phoneOfficeOne: phoneOfficeOne,
          phoneOfficeTwo: phoneOfficeTwo,
          email: email!,
          address: address,
          state: state,
          country: country!,
          status: status ?? 0,
          comment: comment,
          createdAt: createdAt, //2024-06-15 11:39:12
          updatedAt: null,
          createdBy: null,
          updatedBy: null,
          createdBySignature: null,
          signature: null,
          deleted: 0,
          isSynced: 0);
      int recordId =
          await OrgEquipmentManufacturer().createRecord(model: dataModel);
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
      OrgEquipmentManufacturerModel dataModel = OrgEquipmentManufacturerModel(
          equipmentManufacturerId: widget.data!.equipmentManufacturerId,
          name: equipmentSupplier!,
          phoneMobile: phoneMobile,
          phoneOfficeOne: phoneOfficeOne,
          phoneOfficeTwo: phoneOfficeTwo,
          email: email!,
          address: address,
          state: state,
          country: country!,
          status: status ?? 0,
          comment: comment,
          createdAt: widget.data!.createdAt, //2024-06-15 11:39:12
          updatedAt: updatedAt,
          createdBy: widget.data!.createdBy,
          updatedBy: null,
          createdBySignature: null,
          signature: null,
          deleted: 0,
          isSynced: 0);
      int recordId =
          await OrgEquipmentManufacturer().updateRecord(model: dataModel);
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
    if (equipmentSupplier != null && email != null && country != null) {
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
        Get.to(() => const EquipmentSupplierMainTileView());
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
          title: "Equipment Supplier", isUpdate: widget.isUpdate),
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
                  label: "Equipment supplier",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: equipmentSupplier,
                  onChangedText: onChangedEquipmentSupplier,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Email",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: email,
                  onChangedText: onChangedEmail,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Phone mobile",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: phoneMobile,
                  onChangedText: onChangedPhoneNumber,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Phone office 1",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: phoneOfficeOne,
                  onChangedText: onChangedPhoneOfficeOne,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Phone office 2",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: phoneOfficeTwo,
                  onChangedText: onChangedPhoneOfficeTwo,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Address",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: address,
                  onChangedText: onChangedAddress,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "State",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: state,
                  onChangedText: onChangedState,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Country",
                  hintText: "Type here",
                  isRequired: true,
                  initialData: country,
                  onChangedText: onChangedCountry,
                ),
                FormTextField(
                  isUpdate: widget.isUpdate,
                  label: "Comment",
                  hintText: "Type here",
                  isRequired: false,
                  initialData: comment,
                  onChangedText: onChangedComment,
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
