// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:farm_management/configs/color.dart';
// import 'package:farm_management/configs/string.dart';
// import 'package:farm_management/configs/theme.dart';
// import 'package:farm_management/configs/font.dart';
// import 'package:farm_management/controller/state_controller.dart';
// import 'package:farm_management/services/request_permission.dart';
// import 'package:farm_management/widgets/simple_forms_app_bar.dart';
// import 'package:farm_management/widgets/sized_box.dart';
// import 'package:farm_management/widgets/form_box_time_slot_table_row.dart';
// import 'package:farm_management/widgets/form_date_picker.dart';
// import 'package:farm_management/widgets/form_dropdown.dart';
// import 'package:farm_management/widgets/form_signature.dart';
// import 'package:farm_management/widgets/form_textfield.dart';
// import 'package:permission_handler/permission_handler.dart';

// class FinishedProductSizeCheckHourlyAddCopy extends StatefulWidget {
//   final bool isUpdate;
//   const FinishedProductSizeCheckHourlyAddCopy({
//     super.key,
//     this.isUpdate = false,
//   });

//   @override
//   State<FinishedProductSizeCheckHourlyAddCopy> createState() =>
//       _FinishedProductSizeCheckHourlyAddCopyState();
// }

// class _FinishedProductSizeCheckHourlyAddCopyState
//     extends State<FinishedProductSizeCheckHourlyAddCopy>
//     with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   //to keep the State when scrolling out of the screen
//   @override
//   bool get wantKeepAlive => true;

//   final StateController stateController = Get.find();

//   // GlobalKey _childKey = GlobalKey();
//   // double _childHeight = 0.0;

//   late TabController tabController;
//   int selectedIndex = 0;
//   List<Map<int, String>> varietyList = [];

//   Uint8List? signatureData;

//   int? client;
//   int? farm;
//   int? crop;
//   int? variety;
//   String? date;
//   String? measurementUnit;
//   String? comment;
//   String? boxOneLabel;
//   String? boxTwoLabel;
//   String? boxThreeLabel;
//   String? boxFourLabel;
//   String? boxFiveLabel;
//   String? boxSixLabel;
//   String? signatureName;

//   onChangedDropdownClient(int? output) {
//     setState(() {
//       client = output;
//     });
//     debugPrint("$output");
//   }

//   onChangedDropdownFarm(int? output) {
//     setState(() {
//       farm = output;
//     });
//     debugPrint("$output");
//   }

//   onChangedDropdownCrop(int? output) {
//     setState(() {
//       crop = output;
//     });
//     debugPrint("$output");
//   }

//   onChangedDropdownVariety(int? output) {
//     setState(() {
//       variety = output;
//     });
//     debugPrint("$output");
//   }

//   onChangedDate(String? output) {
//     setState(() {
//       date = output;
//     });
//     debugPrint(date);
//   }

//   onChangedMeasurementUnit(String? output) {
//     setState(() {
//       measurementUnit = output;
//     });
//     debugPrint(measurementUnit);
//   }

//   onChangedComment(String? output) {
//     setState(() {
//       comment = output;
//     });
//     debugPrint(comment);
//   }

//   onChangedBoxOneLabel(String? output) {
//     setState(() {
//       boxOneLabel = output;
//     });
//     debugPrint(boxOneLabel);
//   }

//   onChangedBoxTwoLabel(String? output) {
//     setState(() {
//       boxTwoLabel = output;
//     });
//     debugPrint(boxTwoLabel);
//   }

//   onChangedBoxThreeLabel(String? output) {
//     setState(() {
//       boxThreeLabel = output;
//     });
//     debugPrint(boxThreeLabel);
//   }

//   onChangedBoxFourLabel(String? output) {
//     setState(() {
//       boxFourLabel = output;
//     });
//     debugPrint(boxFourLabel);
//   }

//   onChangedBoxFiveLabel(String? output) {
//     setState(() {
//       boxFiveLabel = output;
//     });
//     debugPrint(boxFiveLabel);
//   }

//   onChangedBoxSixLabel(String? output) {
//     setState(() {
//       boxSixLabel = output;
//     });
//     debugPrint(boxSixLabel);
//   }

//   //---- BOX #1 ----
//   // Time Slot One
//   String? boxOneTimeSlotOneTextFieldOne;
//   String? boxOneTimeSlotOneTextFieldTwo;
//   String? boxOneTimeSlotOneTextFieldThree;
//   String? boxOneTimeSlotOneTextFieldFour;
//   String? boxOneTimeSlotOneTextFieldFive;
//   String? boxOneTimeSlotOneTextFieldSix;
//   // Time Slot Two
//   String? boxOneTimeSlotTwoTextFieldOne;
//   String? boxOneTimeSlotTwoTextFieldTwo;
//   String? boxOneTimeSlotTwoTextFieldThree;
//   String? boxOneTimeSlotTwoTextFieldFour;
//   String? boxOneTimeSlotTwoTextFieldFive;
//   String? boxOneTimeSlotTwoTextFieldSix;
//   // Time Slot Three
//   String? boxOneTimeSlotThreeTextFieldOne;
//   String? boxOneTimeSlotThreeTextFieldTwo;
//   String? boxOneTimeSlotThreeTextFieldThree;
//   String? boxOneTimeSlotThreeTextFieldFour;
//   String? boxOneTimeSlotThreeTextFieldFive;
//   String? boxOneTimeSlotThreeTextFieldSix;
//   // Time Slot Four
//   String? boxOneTimeSlotFourTextFieldOne;
//   String? boxOneTimeSlotFourTextFieldTwo;
//   String? boxOneTimeSlotFourTextFieldThree;
//   String? boxOneTimeSlotFourTextFieldFour;
//   String? boxOneTimeSlotFourTextFieldFive;
//   String? boxOneTimeSlotFourTextFieldSix;
//   // Time Slot Five
//   String? boxOneTimeSlotFiveTextFieldOne;
//   String? boxOneTimeSlotFiveTextFieldTwo;
//   String? boxOneTimeSlotFiveTextFieldThree;
//   String? boxOneTimeSlotFiveTextFieldFour;
//   String? boxOneTimeSlotFiveTextFieldFive;
//   String? boxOneTimeSlotFiveTextFieldSix;
//   // Time Slot Six
//   String? boxOneTimeSlotSixTextFieldOne;
//   String? boxOneTimeSlotSixTextFieldTwo;
//   String? boxOneTimeSlotSixTextFieldThree;
//   String? boxOneTimeSlotSixTextFieldFour;
//   String? boxOneTimeSlotSixTextFieldFive;
//   String? boxOneTimeSlotSixTextFieldSix;

//   //---- BOX #2 ----
//   // Time Slot One
//   String? boxTwoTimeSlotOneTextFieldOne;
//   String? boxTwoTimeSlotOneTextFieldTwo;
//   String? boxTwoTimeSlotOneTextFieldThree;
//   String? boxTwoTimeSlotOneTextFieldFour;
//   String? boxTwoTimeSlotOneTextFieldFive;
//   String? boxTwoTimeSlotOneTextFieldSix;
//   // Time Slot Two
//   String? boxTwoTimeSlotTwoTextFieldOne;
//   String? boxTwoTimeSlotTwoTextFieldTwo;
//   String? boxTwoTimeSlotTwoTextFieldThree;
//   String? boxTwoTimeSlotTwoTextFieldFour;
//   String? boxTwoTimeSlotTwoTextFieldFive;
//   String? boxTwoTimeSlotTwoTextFieldSix;
//   // Time Slot Three
//   String? boxTwoTimeSlotThreeTextFieldOne;
//   String? boxTwoTimeSlotThreeTextFieldTwo;
//   String? boxTwoTimeSlotThreeTextFieldThree;
//   String? boxTwoTimeSlotThreeTextFieldFour;
//   String? boxTwoTimeSlotThreeTextFieldFive;
//   String? boxTwoTimeSlotThreeTextFieldSix;
//   // Time Slot Four
//   String? boxTwoTimeSlotFourTextFieldOne;
//   String? boxTwoTimeSlotFourTextFieldTwo;
//   String? boxTwoTimeSlotFourTextFieldThree;
//   String? boxTwoTimeSlotFourTextFieldFour;
//   String? boxTwoTimeSlotFourTextFieldFive;
//   String? boxTwoTimeSlotFourTextFieldSix;
//   // Time Slot Five
//   String? boxTwoTimeSlotFiveTextFieldOne;
//   String? boxTwoTimeSlotFiveTextFieldTwo;
//   String? boxTwoTimeSlotFiveTextFieldThree;
//   String? boxTwoTimeSlotFiveTextFieldFour;
//   String? boxTwoTimeSlotFiveTextFieldFive;
//   String? boxTwoTimeSlotFiveTextFieldSix;
//   // Time Slot Six
//   String? boxTwoTimeSlotSixTextFieldOne;
//   String? boxTwoTimeSlotSixTextFieldTwo;
//   String? boxTwoTimeSlotSixTextFieldThree;
//   String? boxTwoTimeSlotSixTextFieldFour;
//   String? boxTwoTimeSlotSixTextFieldFive;
//   String? boxTwoTimeSlotSixTextFieldSix;

//   //---- BOX #3 ----
//   // Time Slot One
//   String? boxThreeTimeSlotOneTextFieldOne;
//   String? boxThreeTimeSlotOneTextFieldTwo;
//   String? boxThreeTimeSlotOneTextFieldThree;
//   String? boxThreeTimeSlotOneTextFieldFour;
//   String? boxThreeTimeSlotOneTextFieldFive;
//   String? boxThreeTimeSlotOneTextFieldSix;
//   // Time Slot Two
//   String? boxThreeTimeSlotTwoTextFieldOne;
//   String? boxThreeTimeSlotTwoTextFieldTwo;
//   String? boxThreeTimeSlotTwoTextFieldThree;
//   String? boxThreeTimeSlotTwoTextFieldFour;
//   String? boxThreeTimeSlotTwoTextFieldFive;
//   String? boxThreeTimeSlotTwoTextFieldSix;
//   // Time Slot Three
//   String? boxThreeTimeSlotThreeTextFieldOne;
//   String? boxThreeTimeSlotThreeTextFieldTwo;
//   String? boxThreeTimeSlotThreeTextFieldThree;
//   String? boxThreeTimeSlotThreeTextFieldFour;
//   String? boxThreeTimeSlotThreeTextFieldFive;
//   String? boxThreeTimeSlotThreeTextFieldSix;
//   // Time Slot Four
//   String? boxThreeTimeSlotFourTextFieldOne;
//   String? boxThreeTimeSlotFourTextFieldTwo;
//   String? boxThreeTimeSlotFourTextFieldThree;
//   String? boxThreeTimeSlotFourTextFieldFour;
//   String? boxThreeTimeSlotFourTextFieldFive;
//   String? boxThreeTimeSlotFourTextFieldSix;
//   // Time Slot Five
//   String? boxThreeTimeSlotFiveTextFieldOne;
//   String? boxThreeTimeSlotFiveTextFieldTwo;
//   String? boxThreeTimeSlotFiveTextFieldThree;
//   String? boxThreeTimeSlotFiveTextFieldFour;
//   String? boxThreeTimeSlotFiveTextFieldFive;
//   String? boxThreeTimeSlotFiveTextFieldSix;
//   // Time Slot Six
//   String? boxThreeTimeSlotSixTextFieldOne;
//   String? boxThreeTimeSlotSixTextFieldTwo;
//   String? boxThreeTimeSlotSixTextFieldThree;
//   String? boxThreeTimeSlotSixTextFieldFour;
//   String? boxThreeTimeSlotSixTextFieldFive;
//   String? boxThreeTimeSlotSixTextFieldSix;

//   //---- BOX #4 ----
//   // Time Slot One
//   String? boxFourTimeSlotOneTextFieldOne;
//   String? boxFourTimeSlotOneTextFieldTwo;
//   String? boxFourTimeSlotOneTextFieldThree;
//   String? boxFourTimeSlotOneTextFieldFour;
//   String? boxFourTimeSlotOneTextFieldFive;
//   String? boxFourTimeSlotOneTextFieldSix;
//   // Time Slot Two
//   String? boxFourTimeSlotTwoTextFieldOne;
//   String? boxFourTimeSlotTwoTextFieldTwo;
//   String? boxFourTimeSlotTwoTextFieldThree;
//   String? boxFourTimeSlotTwoTextFieldFour;
//   String? boxFourTimeSlotTwoTextFieldFive;
//   String? boxFourTimeSlotTwoTextFieldSix;
//   // Time Slot Three
//   String? boxFourTimeSlotThreeTextFieldOne;
//   String? boxFourTimeSlotThreeTextFieldTwo;
//   String? boxFourTimeSlotThreeTextFieldThree;
//   String? boxFourTimeSlotThreeTextFieldFour;
//   String? boxFourTimeSlotThreeTextFieldFive;
//   String? boxFourTimeSlotThreeTextFieldSix;
//   // Time Slot Four
//   String? boxFourTimeSlotFourTextFieldOne;
//   String? boxFourTimeSlotFourTextFieldTwo;
//   String? boxFourTimeSlotFourTextFieldThree;
//   String? boxFourTimeSlotFourTextFieldFour;
//   String? boxFourTimeSlotFourTextFieldFive;
//   String? boxFourTimeSlotFourTextFieldSix;
//   // Time Slot Five
//   String? boxFourTimeSlotFiveTextFieldOne;
//   String? boxFourTimeSlotFiveTextFieldTwo;
//   String? boxFourTimeSlotFiveTextFieldThree;
//   String? boxFourTimeSlotFiveTextFieldFour;
//   String? boxFourTimeSlotFiveTextFieldFive;
//   String? boxFourTimeSlotFiveTextFieldSix;
//   // Time Slot Six
//   String? boxFourTimeSlotSixTextFieldOne;
//   String? boxFourTimeSlotSixTextFieldTwo;
//   String? boxFourTimeSlotSixTextFieldThree;
//   String? boxFourTimeSlotSixTextFieldFour;
//   String? boxFourTimeSlotSixTextFieldFive;
//   String? boxFourTimeSlotSixTextFieldSix;

//   //---- BOX #5 ----
//   // Time Slot One
//   String? boxFiveTimeSlotOneTextFieldOne;
//   String? boxFiveTimeSlotOneTextFieldTwo;
//   String? boxFiveTimeSlotOneTextFieldThree;
//   String? boxFiveTimeSlotOneTextFieldFour;
//   String? boxFiveTimeSlotOneTextFieldFive;
//   String? boxFiveTimeSlotOneTextFieldSix;
//   // Time Slot Two
//   String? boxFiveTimeSlotTwoTextFieldOne;
//   String? boxFiveTimeSlotTwoTextFieldTwo;
//   String? boxFiveTimeSlotTwoTextFieldThree;
//   String? boxFiveTimeSlotTwoTextFieldFour;
//   String? boxFiveTimeSlotTwoTextFieldFive;
//   String? boxFiveTimeSlotTwoTextFieldSix;
//   // Time Slot Three
//   String? boxFiveTimeSlotThreeTextFieldOne;
//   String? boxFiveTimeSlotThreeTextFieldTwo;
//   String? boxFiveTimeSlotThreeTextFieldThree;
//   String? boxFiveTimeSlotThreeTextFieldFour;
//   String? boxFiveTimeSlotThreeTextFieldFive;
//   String? boxFiveTimeSlotThreeTextFieldSix;
//   // Time Slot Four
//   String? boxFiveTimeSlotFourTextFieldOne;
//   String? boxFiveTimeSlotFourTextFieldTwo;
//   String? boxFiveTimeSlotFourTextFieldThree;
//   String? boxFiveTimeSlotFourTextFieldFour;
//   String? boxFiveTimeSlotFourTextFieldFive;
//   String? boxFiveTimeSlotFourTextFieldSix;
//   // Time Slot Five
//   String? boxFiveTimeSlotFiveTextFieldOne;
//   String? boxFiveTimeSlotFiveTextFieldTwo;
//   String? boxFiveTimeSlotFiveTextFieldThree;
//   String? boxFiveTimeSlotFiveTextFieldFour;
//   String? boxFiveTimeSlotFiveTextFieldFive;
//   String? boxFiveTimeSlotFiveTextFieldSix;
//   // Time Slot Six
//   String? boxFiveTimeSlotSixTextFieldOne;
//   String? boxFiveTimeSlotSixTextFieldTwo;
//   String? boxFiveTimeSlotSixTextFieldThree;
//   String? boxFiveTimeSlotSixTextFieldFour;
//   String? boxFiveTimeSlotSixTextFieldFive;
//   String? boxFiveTimeSlotSixTextFieldSix;

//   //---- BOX #6 ----
//   // Time Slot One
//   String? boxSixTimeSlotOneTextFieldOne;
//   String? boxSixTimeSlotOneTextFieldTwo;
//   String? boxSixTimeSlotOneTextFieldThree;
//   String? boxSixTimeSlotOneTextFieldFour;
//   String? boxSixTimeSlotOneTextFieldFive;
//   String? boxSixTimeSlotOneTextFieldSix;
//   // Time Slot Two
//   String? boxSixTimeSlotTwoTextFieldOne;
//   String? boxSixTimeSlotTwoTextFieldTwo;
//   String? boxSixTimeSlotTwoTextFieldThree;
//   String? boxSixTimeSlotTwoTextFieldFour;
//   String? boxSixTimeSlotTwoTextFieldFive;
//   String? boxSixTimeSlotTwoTextFieldSix;
//   // Time Slot Three
//   String? boxSixTimeSlotThreeTextFieldOne;
//   String? boxSixTimeSlotThreeTextFieldTwo;
//   String? boxSixTimeSlotThreeTextFieldThree;
//   String? boxSixTimeSlotThreeTextFieldFour;
//   String? boxSixTimeSlotThreeTextFieldFive;
//   String? boxSixTimeSlotThreeTextFieldSix;
//   // Time Slot Four
//   String? boxSixTimeSlotFourTextFieldOne;
//   String? boxSixTimeSlotFourTextFieldTwo;
//   String? boxSixTimeSlotFourTextFieldThree;
//   String? boxSixTimeSlotFourTextFieldFour;
//   String? boxSixTimeSlotFourTextFieldFive;
//   String? boxSixTimeSlotFourTextFieldSix;
//   // Time Slot Five
//   String? boxSixTimeSlotFiveTextFieldOne;
//   String? boxSixTimeSlotFiveTextFieldTwo;
//   String? boxSixTimeSlotFiveTextFieldThree;
//   String? boxSixTimeSlotFiveTextFieldFour;
//   String? boxSixTimeSlotFiveTextFieldFive;
//   String? boxSixTimeSlotFiveTextFieldSix;
//   // Time Slot Six
//   String? boxSixTimeSlotSixTextFieldOne;
//   String? boxSixTimeSlotSixTextFieldTwo;
//   String? boxSixTimeSlotSixTextFieldThree;
//   String? boxSixTimeSlotSixTextFieldFour;
//   String? boxSixTimeSlotSixTextFieldFive;
//   String? boxSixTimeSlotSixTextFieldSix;

//   //------ BOX #1 ------
//   // Time Slot One
//   onChangedBoxOneTimeSlotOneTextFieldOne(String output) {
//     setState(() {
//       boxOneTimeSlotOneTextFieldOne = output;
//     });
//     debugPrint(boxOneTimeSlotOneTextFieldOne);
//   }

//   onChangedBoxOneTimeSlotOneTextFieldTwo(String output) {
//     setState(() {
//       boxOneTimeSlotOneTextFieldTwo = output;
//     });
//     debugPrint(boxOneTimeSlotOneTextFieldTwo);
//   }

//   onChangedBoxOneTimeSlotOneTextFieldThree(String output) {
//     setState(() {
//       boxOneTimeSlotOneTextFieldThree = output;
//     });
//     debugPrint(boxOneTimeSlotOneTextFieldThree);
//   }

//   onChangedBoxOneTimeSlotOneTextFieldFour(String output) {
//     setState(() {
//       boxOneTimeSlotOneTextFieldFour = output;
//     });
//     debugPrint(boxOneTimeSlotOneTextFieldFour);
//   }

//   onChangedBoxOneTimeSlotOneTextFieldFive(String output) {
//     setState(() {
//       boxOneTimeSlotOneTextFieldFive = output;
//     });
//     debugPrint(boxOneTimeSlotOneTextFieldFive);
//   }

//   onChangedBoxOneTimeSlotOneTextFieldSix(String output) {
//     setState(() {
//       boxOneTimeSlotOneTextFieldSix = output;
//     });
//     debugPrint(boxOneTimeSlotOneTextFieldSix);
//   }

//   // Time Slot Two
//   onChangedBoxOneTimeSlotTwoTextFieldOne(String output) {
//     setState(() {
//       boxOneTimeSlotTwoTextFieldOne = output;
//     });
//     debugPrint(boxOneTimeSlotTwoTextFieldOne);
//   }

//   onChangedBoxOneTimeSlotTwoTextFieldTwo(String output) {
//     setState(() {
//       boxOneTimeSlotTwoTextFieldTwo = output;
//     });
//     debugPrint(boxOneTimeSlotTwoTextFieldTwo);
//   }

//   onChangedBoxOneTimeSlotTwoTextFieldThree(String output) {
//     setState(() {
//       boxOneTimeSlotTwoTextFieldThree = output;
//     });
//     debugPrint(boxOneTimeSlotTwoTextFieldThree);
//   }

//   onChangedBoxOneTimeSlotTwoTextFieldFour(String output) {
//     setState(() {
//       boxOneTimeSlotTwoTextFieldFour = output;
//     });
//     debugPrint(boxOneTimeSlotTwoTextFieldFour);
//   }

//   onChangedBoxOneTimeSlotTwoTextFieldFive(String output) {
//     setState(() {
//       boxOneTimeSlotTwoTextFieldFive = output;
//     });
//     debugPrint(boxOneTimeSlotTwoTextFieldFive);
//   }

//   onChangedBoxOneTimeSlotTwoTextFieldSix(String output) {
//     setState(() {
//       boxOneTimeSlotTwoTextFieldSix = output;
//     });
//     debugPrint(boxOneTimeSlotTwoTextFieldSix);
//   }

//   // Time Slot Three
//   onChangedBoxOneTimeSlotThreeTextFieldOne(String output) {
//     setState(() {
//       boxOneTimeSlotThreeTextFieldOne = output;
//     });
//     debugPrint(boxOneTimeSlotThreeTextFieldOne);
//   }

//   onChangedBoxOneTimeSlotThreeTextFieldTwo(String output) {
//     setState(() {
//       boxOneTimeSlotThreeTextFieldTwo = output;
//     });
//     debugPrint(boxOneTimeSlotThreeTextFieldTwo);
//   }

//   onChangedBoxOneTimeSlotThreeTextFieldThree(String output) {
//     setState(() {
//       boxOneTimeSlotThreeTextFieldThree = output;
//     });
//     debugPrint(boxOneTimeSlotThreeTextFieldThree);
//   }

//   onChangedBoxOneTimeSlotThreeTextFieldFour(String output) {
//     setState(() {
//       boxOneTimeSlotThreeTextFieldFour = output;
//     });
//     debugPrint(boxOneTimeSlotThreeTextFieldFour);
//   }

//   onChangedBoxOneTimeSlotThreeTextFieldFive(String output) {
//     setState(() {
//       boxOneTimeSlotThreeTextFieldFive = output;
//     });
//     debugPrint(boxOneTimeSlotThreeTextFieldFive);
//   }

//   onChangedBoxOneTimeSlotThreeTextFieldSix(String output) {
//     setState(() {
//       boxOneTimeSlotThreeTextFieldSix = output;
//     });
//     debugPrint(boxOneTimeSlotThreeTextFieldSix);
//   }

//   // Time Slot Four
//   onChangedBoxOneTimeSlotFourTextFieldOne(String output) {
//     setState(() {
//       boxOneTimeSlotFourTextFieldOne = output;
//     });
//     debugPrint(boxOneTimeSlotFourTextFieldOne);
//   }

//   onChangedBoxOneTimeSlotFourTextFieldTwo(String output) {
//     setState(() {
//       boxOneTimeSlotFourTextFieldTwo = output;
//     });
//     debugPrint(boxOneTimeSlotFourTextFieldTwo);
//   }

//   onChangedBoxOneTimeSlotFourTextFieldThree(String output) {
//     setState(() {
//       boxOneTimeSlotFourTextFieldThree = output;
//     });
//     debugPrint(boxOneTimeSlotFourTextFieldThree);
//   }

//   onChangedBoxOneTimeSlotFourTextFieldFour(String output) {
//     setState(() {
//       boxOneTimeSlotFourTextFieldFour = output;
//     });
//     debugPrint(boxOneTimeSlotFourTextFieldFour);
//   }

//   onChangedBoxOneTimeSlotFourTextFieldFive(String output) {
//     setState(() {
//       boxOneTimeSlotFourTextFieldFive = output;
//     });
//     debugPrint(boxOneTimeSlotFourTextFieldFive);
//   }

//   onChangedBoxOneTimeSlotFourTextFieldSix(String output) {
//     setState(() {
//       boxOneTimeSlotFourTextFieldSix = output;
//     });
//     debugPrint(boxOneTimeSlotFourTextFieldSix);
//   }

//   // Time Slot Five
//   onChangedBoxOneTimeSlotFiveTextFieldOne(String output) {
//     setState(() {
//       boxOneTimeSlotFiveTextFieldOne = output;
//     });
//     debugPrint(boxOneTimeSlotFiveTextFieldOne);
//   }

//   onChangedBoxOneTimeSlotFiveTextFieldTwo(String output) {
//     setState(() {
//       boxOneTimeSlotFiveTextFieldTwo = output;
//     });
//     debugPrint(boxOneTimeSlotFiveTextFieldTwo);
//   }

//   onChangedBoxOneTimeSlotFiveTextFieldThree(String output) {
//     setState(() {
//       boxOneTimeSlotFiveTextFieldThree = output;
//     });
//     debugPrint(boxOneTimeSlotFiveTextFieldThree);
//   }

//   onChangedBoxOneTimeSlotFiveTextFieldFour(String output) {
//     setState(() {
//       boxOneTimeSlotFiveTextFieldFour = output;
//     });
//     debugPrint(boxOneTimeSlotFiveTextFieldFour);
//   }

//   onChangedBoxOneTimeSlotFiveTextFieldFive(String output) {
//     setState(() {
//       boxOneTimeSlotFiveTextFieldFive = output;
//     });
//     debugPrint(boxOneTimeSlotFiveTextFieldFive);
//   }

//   onChangedBoxOneTimeSlotFiveTextFieldSix(String output) {
//     setState(() {
//       boxOneTimeSlotFiveTextFieldSix = output;
//     });
//     debugPrint(boxOneTimeSlotFiveTextFieldSix);
//   }

//   // Time Slot Six
//   onChangedBoxOneTimeSlotSixTextFieldOne(String output) {
//     setState(() {
//       boxOneTimeSlotSixTextFieldOne = output;
//     });
//     debugPrint(boxOneTimeSlotSixTextFieldOne);
//   }

//   onChangedBoxOneTimeSlotSixTextFieldTwo(String output) {
//     setState(() {
//       boxOneTimeSlotSixTextFieldTwo = output;
//     });
//     debugPrint(boxOneTimeSlotSixTextFieldTwo);
//   }

//   onChangedBoxOneTimeSlotSixTextFieldThree(String output) {
//     setState(() {
//       boxOneTimeSlotSixTextFieldThree = output;
//     });
//     debugPrint(boxOneTimeSlotSixTextFieldThree);
//   }

//   onChangedBoxOneTimeSlotSixTextFieldFour(String output) {
//     setState(() {
//       boxOneTimeSlotSixTextFieldFour = output;
//     });
//     debugPrint(boxOneTimeSlotSixTextFieldFour);
//   }

//   onChangedBoxOneTimeSlotSixTextFieldFive(String output) {
//     setState(() {
//       boxOneTimeSlotSixTextFieldFive = output;
//     });
//     debugPrint(boxOneTimeSlotSixTextFieldFive);
//   }

//   onChangedBoxOneTimeSlotSixTextFieldSix(String output) {
//     setState(() {
//       boxOneTimeSlotSixTextFieldSix = output;
//     });
//     debugPrint(boxOneTimeSlotSixTextFieldSix);
//   }

//   //------ BOX #2 ------
//   // Time Slot One
//   onChangedBoxTwoTimeSlotOneTextFieldOne(String output) {
//     setState(() {
//       boxTwoTimeSlotOneTextFieldOne = output;
//     });
//     debugPrint(boxTwoTimeSlotOneTextFieldOne);
//   }

//   onChangedBoxTwoTimeSlotOneTextFieldTwo(String output) {
//     setState(() {
//       boxTwoTimeSlotOneTextFieldTwo = output;
//     });
//     debugPrint(boxTwoTimeSlotOneTextFieldTwo);
//   }

//   onChangedBoxTwoTimeSlotOneTextFieldThree(String output) {
//     setState(() {
//       boxTwoTimeSlotOneTextFieldThree = output;
//     });
//     debugPrint(boxTwoTimeSlotOneTextFieldThree);
//   }

//   onChangedBoxTwoTimeSlotOneTextFieldFour(String output) {
//     setState(() {
//       boxTwoTimeSlotOneTextFieldFour = output;
//     });
//     debugPrint(boxTwoTimeSlotOneTextFieldFour);
//   }

//   onChangedBoxTwoTimeSlotOneTextFieldFive(String output) {
//     setState(() {
//       boxTwoTimeSlotOneTextFieldFive = output;
//     });
//     debugPrint(boxTwoTimeSlotOneTextFieldFive);
//   }

//   onChangedBoxTwoTimeSlotOneTextFieldSix(String output) {
//     setState(() {
//       boxTwoTimeSlotOneTextFieldSix = output;
//     });
//     debugPrint(boxTwoTimeSlotOneTextFieldSix);
//   }

//   // Time Slot Two
//   onChangedBoxTwoTimeSlotTwoTextFieldOne(String output) {
//     setState(() {
//       boxTwoTimeSlotTwoTextFieldOne = output;
//     });
//     debugPrint(boxTwoTimeSlotTwoTextFieldOne);
//   }

//   onChangedBoxTwoTimeSlotTwoTextFieldTwo(String output) {
//     setState(() {
//       boxTwoTimeSlotTwoTextFieldTwo = output;
//     });
//     debugPrint(boxTwoTimeSlotTwoTextFieldTwo);
//   }

//   onChangedBoxTwoTimeSlotTwoTextFieldThree(String output) {
//     setState(() {
//       boxTwoTimeSlotTwoTextFieldThree = output;
//     });
//     debugPrint(boxTwoTimeSlotTwoTextFieldThree);
//   }

//   onChangedBoxTwoTimeSlotTwoTextFieldFour(String output) {
//     setState(() {
//       boxTwoTimeSlotTwoTextFieldFour = output;
//     });
//     debugPrint(boxTwoTimeSlotTwoTextFieldFour);
//   }

//   onChangedBoxTwoTimeSlotTwoTextFieldFive(String output) {
//     setState(() {
//       boxTwoTimeSlotTwoTextFieldFive = output;
//     });
//     debugPrint(boxTwoTimeSlotTwoTextFieldFive);
//   }

//   onChangedBoxTwoTimeSlotTwoTextFieldSix(String output) {
//     setState(() {
//       boxTwoTimeSlotTwoTextFieldSix = output;
//     });
//     debugPrint(boxTwoTimeSlotTwoTextFieldSix);
//   }

//   // Time Slot Three
//   onChangedBoxTwoTimeSlotThreeTextFieldOne(String output) {
//     setState(() {
//       boxTwoTimeSlotThreeTextFieldOne = output;
//     });
//     debugPrint(boxTwoTimeSlotThreeTextFieldOne);
//   }

//   onChangedBoxTwoTimeSlotThreeTextFieldTwo(String output) {
//     setState(() {
//       boxTwoTimeSlotThreeTextFieldTwo = output;
//     });
//     debugPrint(boxTwoTimeSlotThreeTextFieldTwo);
//   }

//   onChangedBoxTwoTimeSlotThreeTextFieldThree(String output) {
//     setState(() {
//       boxTwoTimeSlotThreeTextFieldThree = output;
//     });
//     debugPrint(boxTwoTimeSlotThreeTextFieldThree);
//   }

//   onChangedBoxTwoTimeSlotThreeTextFieldFour(String output) {
//     setState(() {
//       boxTwoTimeSlotThreeTextFieldFour = output;
//     });
//     debugPrint(boxTwoTimeSlotThreeTextFieldFour);
//   }

//   onChangedBoxTwoTimeSlotThreeTextFieldFive(String output) {
//     setState(() {
//       boxTwoTimeSlotThreeTextFieldFive = output;
//     });
//     debugPrint(boxTwoTimeSlotThreeTextFieldFive);
//   }

//   onChangedBoxTwoTimeSlotThreeTextFieldSix(String output) {
//     setState(() {
//       boxTwoTimeSlotThreeTextFieldSix = output;
//     });
//     debugPrint(boxTwoTimeSlotThreeTextFieldSix);
//   }

//   // Time Slot Four
//   onChangedBoxTwoTimeSlotFourTextFieldOne(String output) {
//     setState(() {
//       boxTwoTimeSlotFourTextFieldOne = output;
//     });
//     debugPrint(boxTwoTimeSlotFourTextFieldOne);
//   }

//   onChangedBoxTwoTimeSlotFourTextFieldTwo(String output) {
//     setState(() {
//       boxTwoTimeSlotFourTextFieldTwo = output;
//     });
//     debugPrint(boxTwoTimeSlotFourTextFieldTwo);
//   }

//   onChangedBoxTwoTimeSlotFourTextFieldThree(String output) {
//     setState(() {
//       boxTwoTimeSlotFourTextFieldThree = output;
//     });
//     debugPrint(boxTwoTimeSlotFourTextFieldThree);
//   }

//   onChangedBoxTwoTimeSlotFourTextFieldFour(String output) {
//     setState(() {
//       boxTwoTimeSlotFourTextFieldFour = output;
//     });
//     debugPrint(boxTwoTimeSlotFourTextFieldFour);
//   }

//   onChangedBoxTwoTimeSlotFourTextFieldFive(String output) {
//     setState(() {
//       boxTwoTimeSlotFourTextFieldFive = output;
//     });
//     debugPrint(boxTwoTimeSlotFourTextFieldFive);
//   }

//   onChangedBoxTwoTimeSlotFourTextFieldSix(String output) {
//     setState(() {
//       boxTwoTimeSlotFourTextFieldSix = output;
//     });
//     debugPrint(boxTwoTimeSlotFourTextFieldSix);
//   }

//   // Time Slot Five
//   onChangedBoxTwoTimeSlotFiveTextFieldOne(String output) {
//     setState(() {
//       boxTwoTimeSlotFiveTextFieldOne = output;
//     });
//     debugPrint(boxTwoTimeSlotFiveTextFieldOne);
//   }

//   onChangedBoxTwoTimeSlotFiveTextFieldTwo(String output) {
//     setState(() {
//       boxTwoTimeSlotFiveTextFieldTwo = output;
//     });
//     debugPrint(boxTwoTimeSlotFiveTextFieldTwo);
//   }

//   onChangedBoxTwoTimeSlotFiveTextFieldThree(String output) {
//     setState(() {
//       boxTwoTimeSlotFiveTextFieldThree = output;
//     });
//     debugPrint(boxTwoTimeSlotFiveTextFieldThree);
//   }

//   onChangedBoxTwoTimeSlotFiveTextFieldFour(String output) {
//     setState(() {
//       boxTwoTimeSlotFiveTextFieldFour = output;
//     });
//     debugPrint(boxTwoTimeSlotFiveTextFieldFour);
//   }

//   onChangedBoxTwoTimeSlotFiveTextFieldFive(String output) {
//     setState(() {
//       boxTwoTimeSlotFiveTextFieldFive = output;
//     });
//     debugPrint(boxTwoTimeSlotFiveTextFieldFive);
//   }

//   onChangedBoxTwoTimeSlotFiveTextFieldSix(String output) {
//     setState(() {
//       boxTwoTimeSlotFiveTextFieldSix = output;
//     });
//     debugPrint(boxTwoTimeSlotFiveTextFieldSix);
//   }

//   // Time Slot Six
//   onChangedBoxTwoTimeSlotSixTextFieldOne(String output) {
//     setState(() {
//       boxTwoTimeSlotSixTextFieldOne = output;
//     });
//     debugPrint(boxTwoTimeSlotSixTextFieldOne);
//   }

//   onChangedBoxTwoTimeSlotSixTextFieldTwo(String output) {
//     setState(() {
//       boxTwoTimeSlotSixTextFieldTwo = output;
//     });
//     debugPrint(boxTwoTimeSlotSixTextFieldTwo);
//   }

//   onChangedBoxTwoTimeSlotSixTextFieldThree(String output) {
//     setState(() {
//       boxTwoTimeSlotSixTextFieldThree = output;
//     });
//     debugPrint(boxTwoTimeSlotSixTextFieldThree);
//   }

//   onChangedBoxTwoTimeSlotSixTextFieldFour(String output) {
//     setState(() {
//       boxTwoTimeSlotSixTextFieldFour = output;
//     });
//     debugPrint(boxTwoTimeSlotSixTextFieldFour);
//   }

//   onChangedBoxTwoTimeSlotSixTextFieldFive(String output) {
//     setState(() {
//       boxTwoTimeSlotSixTextFieldFive = output;
//     });
//     debugPrint(boxTwoTimeSlotSixTextFieldFive);
//   }

//   onChangedBoxTwoTimeSlotSixTextFieldSix(String output) {
//     setState(() {
//       boxTwoTimeSlotSixTextFieldSix = output;
//     });
//     debugPrint(boxTwoTimeSlotSixTextFieldSix);
//   }

//   //------ BOX #3 ------
//   // Time Slot One
//   onChangedBoxThreeTimeSlotOneTextFieldOne(String output) {
//     setState(() {
//       boxThreeTimeSlotOneTextFieldOne = output;
//     });
//     debugPrint(boxThreeTimeSlotOneTextFieldOne);
//   }

//   onChangedBoxThreeTimeSlotOneTextFieldTwo(String output) {
//     setState(() {
//       boxThreeTimeSlotOneTextFieldTwo = output;
//     });
//     debugPrint(boxThreeTimeSlotOneTextFieldTwo);
//   }

//   onChangedBoxThreeTimeSlotOneTextFieldThree(String output) {
//     setState(() {
//       boxThreeTimeSlotOneTextFieldThree = output;
//     });
//     debugPrint(boxThreeTimeSlotOneTextFieldThree);
//   }

//   onChangedBoxThreeTimeSlotOneTextFieldFour(String output) {
//     setState(() {
//       boxThreeTimeSlotOneTextFieldFour = output;
//     });
//     debugPrint(boxThreeTimeSlotOneTextFieldFour);
//   }

//   onChangedBoxThreeTimeSlotOneTextFieldFive(String output) {
//     setState(() {
//       boxThreeTimeSlotOneTextFieldFive = output;
//     });
//     debugPrint(boxThreeTimeSlotOneTextFieldFive);
//   }

//   onChangedBoxThreeTimeSlotOneTextFieldSix(String output) {
//     setState(() {
//       boxThreeTimeSlotOneTextFieldSix = output;
//     });
//     debugPrint(boxThreeTimeSlotOneTextFieldSix);
//   }

//   // Time Slot Two
//   onChangedBoxThreeTimeSlotTwoTextFieldOne(String output) {
//     setState(() {
//       boxThreeTimeSlotTwoTextFieldOne = output;
//     });
//     debugPrint(boxThreeTimeSlotTwoTextFieldOne);
//   }

//   onChangedBoxThreeTimeSlotTwoTextFieldTwo(String output) {
//     setState(() {
//       boxThreeTimeSlotTwoTextFieldTwo = output;
//     });
//     debugPrint(boxThreeTimeSlotTwoTextFieldTwo);
//   }

//   onChangedBoxThreeTimeSlotTwoTextFieldThree(String output) {
//     setState(() {
//       boxThreeTimeSlotTwoTextFieldThree = output;
//     });
//     debugPrint(boxThreeTimeSlotTwoTextFieldThree);
//   }

//   onChangedBoxThreeTimeSlotTwoTextFieldFour(String output) {
//     setState(() {
//       boxThreeTimeSlotTwoTextFieldFour = output;
//     });
//     debugPrint(boxThreeTimeSlotTwoTextFieldFour);
//   }

//   onChangedBoxThreeTimeSlotTwoTextFieldFive(String output) {
//     setState(() {
//       boxThreeTimeSlotTwoTextFieldFive = output;
//     });
//     debugPrint(boxThreeTimeSlotTwoTextFieldFive);
//   }

//   onChangedBoxThreeTimeSlotTwoTextFieldSix(String output) {
//     setState(() {
//       boxThreeTimeSlotTwoTextFieldSix = output;
//     });
//     debugPrint(boxThreeTimeSlotTwoTextFieldSix);
//   }

//   // Time Slot Three
//   onChangedBoxThreeTimeSlotThreeTextFieldOne(String output) {
//     setState(() {
//       boxThreeTimeSlotThreeTextFieldOne = output;
//     });
//     debugPrint(boxThreeTimeSlotThreeTextFieldOne);
//   }

//   onChangedBoxThreeTimeSlotThreeTextFieldTwo(String output) {
//     setState(() {
//       boxThreeTimeSlotThreeTextFieldTwo = output;
//     });
//     debugPrint(boxThreeTimeSlotThreeTextFieldTwo);
//   }

//   onChangedBoxThreeTimeSlotThreeTextFieldThree(String output) {
//     setState(() {
//       boxThreeTimeSlotThreeTextFieldThree = output;
//     });
//     debugPrint(boxThreeTimeSlotThreeTextFieldThree);
//   }

//   onChangedBoxThreeTimeSlotThreeTextFieldFour(String output) {
//     setState(() {
//       boxThreeTimeSlotThreeTextFieldFour = output;
//     });
//     debugPrint(boxThreeTimeSlotThreeTextFieldFour);
//   }

//   onChangedBoxThreeTimeSlotThreeTextFieldFive(String output) {
//     setState(() {
//       boxThreeTimeSlotThreeTextFieldFive = output;
//     });
//     debugPrint(boxThreeTimeSlotThreeTextFieldFive);
//   }

//   onChangedBoxThreeTimeSlotThreeTextFieldSix(String output) {
//     setState(() {
//       boxThreeTimeSlotThreeTextFieldSix = output;
//     });
//     debugPrint(boxThreeTimeSlotThreeTextFieldSix);
//   }

//   // Time Slot Four
//   onChangedBoxThreeTimeSlotFourTextFieldOne(String output) {
//     setState(() {
//       boxThreeTimeSlotFourTextFieldOne = output;
//     });
//     debugPrint(boxThreeTimeSlotFourTextFieldOne);
//   }

//   onChangedBoxThreeTimeSlotFourTextFieldTwo(String output) {
//     setState(() {
//       boxThreeTimeSlotFourTextFieldTwo = output;
//     });
//     debugPrint(boxThreeTimeSlotFourTextFieldTwo);
//   }

//   onChangedBoxThreeTimeSlotFourTextFieldThree(String output) {
//     setState(() {
//       boxThreeTimeSlotFourTextFieldThree = output;
//     });
//     debugPrint(boxThreeTimeSlotFourTextFieldThree);
//   }

//   onChangedBoxThreeTimeSlotFourTextFieldFour(String output) {
//     setState(() {
//       boxThreeTimeSlotFourTextFieldFour = output;
//     });
//     debugPrint(boxThreeTimeSlotFourTextFieldFour);
//   }

//   onChangedBoxThreeTimeSlotFourTextFieldFive(String output) {
//     setState(() {
//       boxThreeTimeSlotFourTextFieldFive = output;
//     });
//     debugPrint(boxThreeTimeSlotFourTextFieldFive);
//   }

//   onChangedBoxThreeTimeSlotFourTextFieldSix(String output) {
//     setState(() {
//       boxThreeTimeSlotFourTextFieldSix = output;
//     });
//     debugPrint(boxThreeTimeSlotFourTextFieldSix);
//   }

//   // Time Slot Five
//   onChangedBoxThreeTimeSlotFiveTextFieldOne(String output) {
//     setState(() {
//       boxThreeTimeSlotFiveTextFieldOne = output;
//     });
//     debugPrint(boxThreeTimeSlotFiveTextFieldOne);
//   }

//   onChangedBoxThreeTimeSlotFiveTextFieldTwo(String output) {
//     setState(() {
//       boxThreeTimeSlotFiveTextFieldTwo = output;
//     });
//     debugPrint(boxThreeTimeSlotFiveTextFieldTwo);
//   }

//   onChangedBoxThreeTimeSlotFiveTextFieldThree(String output) {
//     setState(() {
//       boxThreeTimeSlotFiveTextFieldThree = output;
//     });
//     debugPrint(boxThreeTimeSlotFiveTextFieldThree);
//   }

//   onChangedBoxThreeTimeSlotFiveTextFieldFour(String output) {
//     setState(() {
//       boxThreeTimeSlotFiveTextFieldFour = output;
//     });
//     debugPrint(boxThreeTimeSlotFiveTextFieldFour);
//   }

//   onChangedBoxThreeTimeSlotFiveTextFieldFive(String output) {
//     setState(() {
//       boxThreeTimeSlotFiveTextFieldFive = output;
//     });
//     debugPrint(boxThreeTimeSlotFiveTextFieldFive);
//   }

//   onChangedBoxThreeTimeSlotFiveTextFieldSix(String output) {
//     setState(() {
//       boxThreeTimeSlotFiveTextFieldSix = output;
//     });
//     debugPrint(boxThreeTimeSlotFiveTextFieldSix);
//   }

//   // Time Slot Six
//   onChangedBoxThreeTimeSlotSixTextFieldOne(String output) {
//     setState(() {
//       boxThreeTimeSlotSixTextFieldOne = output;
//     });
//     debugPrint(boxThreeTimeSlotSixTextFieldOne);
//   }

//   onChangedBoxThreeTimeSlotSixTextFieldTwo(String output) {
//     setState(() {
//       boxThreeTimeSlotSixTextFieldTwo = output;
//     });
//     debugPrint(boxThreeTimeSlotSixTextFieldTwo);
//   }

//   onChangedBoxThreeTimeSlotSixTextFieldThree(String output) {
//     setState(() {
//       boxThreeTimeSlotSixTextFieldThree = output;
//     });
//     debugPrint(boxThreeTimeSlotSixTextFieldThree);
//   }

//   onChangedBoxThreeTimeSlotSixTextFieldFour(String output) {
//     setState(() {
//       boxThreeTimeSlotSixTextFieldFour = output;
//     });
//     debugPrint(boxThreeTimeSlotSixTextFieldFour);
//   }

//   onChangedBoxThreeTimeSlotSixTextFieldFive(String output) {
//     setState(() {
//       boxThreeTimeSlotSixTextFieldFive = output;
//     });
//     debugPrint(boxThreeTimeSlotSixTextFieldFive);
//   }

//   onChangedBoxThreeTimeSlotSixTextFieldSix(String output) {
//     setState(() {
//       boxThreeTimeSlotSixTextFieldSix = output;
//     });
//     debugPrint(boxThreeTimeSlotSixTextFieldSix);
//   }

//   //------ BOX #4 ------
//   // Time Slot One
//   onChangedBoxFourTimeSlotOneTextFieldOne(String output) {
//     setState(() {
//       boxFourTimeSlotOneTextFieldOne = output;
//     });
//     debugPrint(boxFourTimeSlotOneTextFieldOne);
//   }

//   onChangedBoxFourTimeSlotOneTextFieldTwo(String output) {
//     setState(() {
//       boxFourTimeSlotOneTextFieldTwo = output;
//     });
//     debugPrint(boxFourTimeSlotOneTextFieldTwo);
//   }

//   onChangedBoxFourTimeSlotOneTextFieldThree(String output) {
//     setState(() {
//       boxFourTimeSlotOneTextFieldThree = output;
//     });
//     debugPrint(boxFourTimeSlotOneTextFieldThree);
//   }

//   onChangedBoxFourTimeSlotOneTextFieldFour(String output) {
//     setState(() {
//       boxFourTimeSlotOneTextFieldFour = output;
//     });
//     debugPrint(boxFourTimeSlotOneTextFieldFour);
//   }

//   onChangedBoxFourTimeSlotOneTextFieldFive(String output) {
//     setState(() {
//       boxFourTimeSlotOneTextFieldFive = output;
//     });
//     debugPrint(boxFourTimeSlotOneTextFieldFive);
//   }

//   onChangedBoxFourTimeSlotOneTextFieldSix(String output) {
//     setState(() {
//       boxFourTimeSlotOneTextFieldSix = output;
//     });
//     debugPrint(boxFourTimeSlotOneTextFieldSix);
//   }

//   // Time Slot Two
//   onChangedBoxFourTimeSlotTwoTextFieldOne(String output) {
//     setState(() {
//       boxFourTimeSlotTwoTextFieldOne = output;
//     });
//     debugPrint(boxFourTimeSlotTwoTextFieldOne);
//   }

//   onChangedBoxFourTimeSlotTwoTextFieldTwo(String output) {
//     setState(() {
//       boxFourTimeSlotTwoTextFieldTwo = output;
//     });
//     debugPrint(boxFourTimeSlotTwoTextFieldTwo);
//   }

//   onChangedBoxFourTimeSlotTwoTextFieldThree(String output) {
//     setState(() {
//       boxFourTimeSlotTwoTextFieldThree = output;
//     });
//     debugPrint(boxFourTimeSlotTwoTextFieldThree);
//   }

//   onChangedBoxFourTimeSlotTwoTextFieldFour(String output) {
//     setState(() {
//       boxFourTimeSlotTwoTextFieldFour = output;
//     });
//     debugPrint(boxFourTimeSlotTwoTextFieldFour);
//   }

//   onChangedBoxFourTimeSlotTwoTextFieldFive(String output) {
//     setState(() {
//       boxFourTimeSlotTwoTextFieldFive = output;
//     });
//     debugPrint(boxFourTimeSlotTwoTextFieldFive);
//   }

//   onChangedBoxFourTimeSlotTwoTextFieldSix(String output) {
//     setState(() {
//       boxFourTimeSlotTwoTextFieldSix = output;
//     });
//     debugPrint(boxFourTimeSlotTwoTextFieldSix);
//   }

//   // Time Slot Three
//   onChangedBoxFourTimeSlotThreeTextFieldOne(String output) {
//     setState(() {
//       boxFourTimeSlotThreeTextFieldOne = output;
//     });
//     debugPrint(boxFourTimeSlotThreeTextFieldOne);
//   }

//   onChangedBoxFourTimeSlotThreeTextFieldTwo(String output) {
//     setState(() {
//       boxFourTimeSlotThreeTextFieldTwo = output;
//     });
//     debugPrint(boxFourTimeSlotThreeTextFieldTwo);
//   }

//   onChangedBoxFourTimeSlotThreeTextFieldThree(String output) {
//     setState(() {
//       boxFourTimeSlotThreeTextFieldThree = output;
//     });
//     debugPrint(boxFourTimeSlotThreeTextFieldThree);
//   }

//   onChangedBoxFourTimeSlotThreeTextFieldFour(String output) {
//     setState(() {
//       boxFourTimeSlotThreeTextFieldFour = output;
//     });
//     debugPrint(boxFourTimeSlotThreeTextFieldFour);
//   }

//   onChangedBoxFourTimeSlotThreeTextFieldFive(String output) {
//     setState(() {
//       boxFourTimeSlotThreeTextFieldFive = output;
//     });
//     debugPrint(boxFourTimeSlotThreeTextFieldFive);
//   }

//   onChangedBoxFourTimeSlotThreeTextFieldSix(String output) {
//     setState(() {
//       boxFourTimeSlotThreeTextFieldSix = output;
//     });
//     debugPrint(boxFourTimeSlotThreeTextFieldSix);
//   }

//   // Time Slot Four
//   onChangedBoxFourTimeSlotFourTextFieldOne(String output) {
//     setState(() {
//       boxFourTimeSlotFourTextFieldOne = output;
//     });
//     debugPrint(boxFourTimeSlotFourTextFieldOne);
//   }

//   onChangedBoxFourTimeSlotFourTextFieldTwo(String output) {
//     setState(() {
//       boxFourTimeSlotFourTextFieldTwo = output;
//     });
//     debugPrint(boxFourTimeSlotFourTextFieldTwo);
//   }

//   onChangedBoxFourTimeSlotFourTextFieldThree(String output) {
//     setState(() {
//       boxFourTimeSlotFourTextFieldThree = output;
//     });
//     debugPrint(boxFourTimeSlotFourTextFieldThree);
//   }

//   onChangedBoxFourTimeSlotFourTextFieldFour(String output) {
//     setState(() {
//       boxFourTimeSlotFourTextFieldFour = output;
//     });
//     debugPrint(boxFourTimeSlotFourTextFieldFour);
//   }

//   onChangedBoxFourTimeSlotFourTextFieldFive(String output) {
//     setState(() {
//       boxFourTimeSlotFourTextFieldFive = output;
//     });
//     debugPrint(boxFourTimeSlotFourTextFieldFive);
//   }

//   onChangedBoxFourTimeSlotFourTextFieldSix(String output) {
//     setState(() {
//       boxFourTimeSlotFourTextFieldSix = output;
//     });
//     debugPrint(boxFourTimeSlotFourTextFieldSix);
//   }

//   // Time Slot Five
//   onChangedBoxFourTimeSlotFiveTextFieldOne(String output) {
//     setState(() {
//       boxFourTimeSlotFiveTextFieldOne = output;
//     });
//     debugPrint(boxFourTimeSlotFiveTextFieldOne);
//   }

//   onChangedBoxFourTimeSlotFiveTextFieldTwo(String output) {
//     setState(() {
//       boxFourTimeSlotFiveTextFieldTwo = output;
//     });
//     debugPrint(boxFourTimeSlotFiveTextFieldTwo);
//   }

//   onChangedBoxFourTimeSlotFiveTextFieldThree(String output) {
//     setState(() {
//       boxFourTimeSlotFiveTextFieldThree = output;
//     });
//     debugPrint(boxFourTimeSlotFiveTextFieldThree);
//   }

//   onChangedBoxFourTimeSlotFiveTextFieldFour(String output) {
//     setState(() {
//       boxFourTimeSlotFiveTextFieldFour = output;
//     });
//     debugPrint(boxFourTimeSlotFiveTextFieldFour);
//   }

//   onChangedBoxFourTimeSlotFiveTextFieldFive(String output) {
//     setState(() {
//       boxFourTimeSlotFiveTextFieldFive = output;
//     });
//     debugPrint(boxFourTimeSlotFiveTextFieldFive);
//   }

//   onChangedBoxFourTimeSlotFiveTextFieldSix(String output) {
//     setState(() {
//       boxFourTimeSlotFiveTextFieldSix = output;
//     });
//     debugPrint(boxFourTimeSlotFiveTextFieldSix);
//   }

//   // Time Slot Six
//   onChangedBoxFourTimeSlotSixTextFieldOne(String output) {
//     setState(() {
//       boxFourTimeSlotSixTextFieldOne = output;
//     });
//     debugPrint(boxFourTimeSlotSixTextFieldOne);
//   }

//   onChangedBoxFourTimeSlotSixTextFieldTwo(String output) {
//     setState(() {
//       boxFourTimeSlotSixTextFieldTwo = output;
//     });
//     debugPrint(boxFourTimeSlotSixTextFieldTwo);
//   }

//   onChangedBoxFourTimeSlotSixTextFieldThree(String output) {
//     setState(() {
//       boxFourTimeSlotSixTextFieldThree = output;
//     });
//     debugPrint(boxFourTimeSlotSixTextFieldThree);
//   }

//   onChangedBoxFourTimeSlotSixTextFieldFour(String output) {
//     setState(() {
//       boxFourTimeSlotSixTextFieldFour = output;
//     });
//     debugPrint(boxFourTimeSlotSixTextFieldFour);
//   }

//   onChangedBoxFourTimeSlotSixTextFieldFive(String output) {
//     setState(() {
//       boxFourTimeSlotSixTextFieldFive = output;
//     });
//     debugPrint(boxFourTimeSlotSixTextFieldFive);
//   }

//   onChangedBoxFourTimeSlotSixTextFieldSix(String output) {
//     setState(() {
//       boxFourTimeSlotSixTextFieldSix = output;
//     });
//     debugPrint(boxFourTimeSlotSixTextFieldSix);
//   }

//   //------ BOX #5 ------
//   // Time Slot One
//   onChangedBoxFiveTimeSlotOneTextFieldOne(String output) {
//     setState(() {
//       boxFiveTimeSlotOneTextFieldOne = output;
//     });
//     debugPrint(boxFiveTimeSlotOneTextFieldOne);
//   }

//   onChangedBoxFiveTimeSlotOneTextFieldTwo(String output) {
//     setState(() {
//       boxFiveTimeSlotOneTextFieldTwo = output;
//     });
//     debugPrint(boxFiveTimeSlotOneTextFieldTwo);
//   }

//   onChangedBoxFiveTimeSlotOneTextFieldThree(String output) {
//     setState(() {
//       boxFiveTimeSlotOneTextFieldThree = output;
//     });
//     debugPrint(boxFiveTimeSlotOneTextFieldThree);
//   }

//   onChangedBoxFiveTimeSlotOneTextFieldFour(String output) {
//     setState(() {
//       boxFiveTimeSlotOneTextFieldFour = output;
//     });
//     debugPrint(boxFiveTimeSlotOneTextFieldFour);
//   }

//   onChangedBoxFiveTimeSlotOneTextFieldFive(String output) {
//     setState(() {
//       boxFiveTimeSlotOneTextFieldFive = output;
//     });
//     debugPrint(boxFiveTimeSlotOneTextFieldFive);
//   }

//   onChangedBoxFiveTimeSlotOneTextFieldSix(String output) {
//     setState(() {
//       boxFiveTimeSlotOneTextFieldSix = output;
//     });
//     debugPrint(boxFiveTimeSlotOneTextFieldSix);
//   }

//   // Time Slot Two
//   onChangedBoxFiveTimeSlotTwoTextFieldOne(String output) {
//     setState(() {
//       boxFiveTimeSlotTwoTextFieldOne = output;
//     });
//     debugPrint(boxFiveTimeSlotTwoTextFieldOne);
//   }

//   onChangedBoxFiveTimeSlotTwoTextFieldTwo(String output) {
//     setState(() {
//       boxFiveTimeSlotTwoTextFieldTwo = output;
//     });
//     debugPrint(boxFiveTimeSlotTwoTextFieldTwo);
//   }

//   onChangedBoxFiveTimeSlotTwoTextFieldThree(String output) {
//     setState(() {
//       boxFiveTimeSlotTwoTextFieldThree = output;
//     });
//     debugPrint(boxFiveTimeSlotTwoTextFieldThree);
//   }

//   onChangedBoxFiveTimeSlotTwoTextFieldFour(String output) {
//     setState(() {
//       boxFiveTimeSlotTwoTextFieldFour = output;
//     });
//     debugPrint(boxFiveTimeSlotTwoTextFieldFour);
//   }

//   onChangedBoxFiveTimeSlotTwoTextFieldFive(String output) {
//     setState(() {
//       boxFiveTimeSlotTwoTextFieldFive = output;
//     });
//     debugPrint(boxFiveTimeSlotTwoTextFieldFive);
//   }

//   onChangedBoxFiveTimeSlotTwoTextFieldSix(String output) {
//     setState(() {
//       boxFiveTimeSlotTwoTextFieldSix = output;
//     });
//     debugPrint(boxFiveTimeSlotTwoTextFieldSix);
//   }

//   // Time Slot Three
//   onChangedBoxFiveTimeSlotThreeTextFieldOne(String output) {
//     setState(() {
//       boxFiveTimeSlotThreeTextFieldOne = output;
//     });
//     debugPrint(boxFiveTimeSlotThreeTextFieldOne);
//   }

//   onChangedBoxFiveTimeSlotThreeTextFieldTwo(String output) {
//     setState(() {
//       boxFiveTimeSlotThreeTextFieldTwo = output;
//     });
//     debugPrint(boxFiveTimeSlotThreeTextFieldTwo);
//   }

//   onChangedBoxFiveTimeSlotThreeTextFieldThree(String output) {
//     setState(() {
//       boxFiveTimeSlotThreeTextFieldThree = output;
//     });
//     debugPrint(boxFiveTimeSlotThreeTextFieldThree);
//   }

//   onChangedBoxFiveTimeSlotThreeTextFieldFour(String output) {
//     setState(() {
//       boxFiveTimeSlotThreeTextFieldFour = output;
//     });
//     debugPrint(boxFiveTimeSlotThreeTextFieldFour);
//   }

//   onChangedBoxFiveTimeSlotThreeTextFieldFive(String output) {
//     setState(() {
//       boxFiveTimeSlotThreeTextFieldFive = output;
//     });
//     debugPrint(boxFiveTimeSlotThreeTextFieldFive);
//   }

//   onChangedBoxFiveTimeSlotThreeTextFieldSix(String output) {
//     setState(() {
//       boxFiveTimeSlotThreeTextFieldSix = output;
//     });
//     debugPrint(boxFiveTimeSlotThreeTextFieldSix);
//   }

//   // Time Slot Four
//   onChangedBoxFiveTimeSlotFourTextFieldOne(String output) {
//     setState(() {
//       boxFiveTimeSlotFourTextFieldOne = output;
//     });
//     debugPrint(boxFiveTimeSlotFourTextFieldOne);
//   }

//   onChangedBoxFiveTimeSlotFourTextFieldTwo(String output) {
//     setState(() {
//       boxFiveTimeSlotFourTextFieldTwo = output;
//     });
//     debugPrint(boxFiveTimeSlotFourTextFieldTwo);
//   }

//   onChangedBoxFiveTimeSlotFourTextFieldThree(String output) {
//     setState(() {
//       boxFiveTimeSlotFourTextFieldThree = output;
//     });
//     debugPrint(boxFiveTimeSlotFourTextFieldThree);
//   }

//   onChangedBoxFiveTimeSlotFourTextFieldFour(String output) {
//     setState(() {
//       boxFiveTimeSlotFourTextFieldFour = output;
//     });
//     debugPrint(boxFiveTimeSlotFourTextFieldFour);
//   }

//   onChangedBoxFiveTimeSlotFourTextFieldFive(String output) {
//     setState(() {
//       boxFiveTimeSlotFourTextFieldFive = output;
//     });
//     debugPrint(boxFiveTimeSlotFourTextFieldFive);
//   }

//   onChangedBoxFiveTimeSlotFourTextFieldSix(String output) {
//     setState(() {
//       boxFiveTimeSlotFourTextFieldSix = output;
//     });
//     debugPrint(boxFiveTimeSlotFourTextFieldSix);
//   }

//   // Time Slot Five
//   onChangedBoxFiveTimeSlotFiveTextFieldOne(String output) {
//     setState(() {
//       boxFiveTimeSlotFiveTextFieldOne = output;
//     });
//     debugPrint(boxFiveTimeSlotFiveTextFieldOne);
//   }

//   onChangedBoxFiveTimeSlotFiveTextFieldTwo(String output) {
//     setState(() {
//       boxFiveTimeSlotFiveTextFieldTwo = output;
//     });
//     debugPrint(boxFiveTimeSlotFiveTextFieldTwo);
//   }

//   onChangedBoxFiveTimeSlotFiveTextFieldThree(String output) {
//     setState(() {
//       boxFiveTimeSlotFiveTextFieldThree = output;
//     });
//     debugPrint(boxFiveTimeSlotFiveTextFieldThree);
//   }

//   onChangedBoxFiveTimeSlotFiveTextFieldFour(String output) {
//     setState(() {
//       boxFiveTimeSlotFiveTextFieldFour = output;
//     });
//     debugPrint(boxFiveTimeSlotFiveTextFieldFour);
//   }

//   onChangedBoxFiveTimeSlotFiveTextFieldFive(String output) {
//     setState(() {
//       boxFiveTimeSlotFiveTextFieldFive = output;
//     });
//     debugPrint(boxFiveTimeSlotFiveTextFieldFive);
//   }

//   onChangedBoxFiveTimeSlotFiveTextFieldSix(String output) {
//     setState(() {
//       boxFiveTimeSlotFiveTextFieldSix = output;
//     });
//     debugPrint(boxFiveTimeSlotFiveTextFieldSix);
//   }

//   // Time Slot Six
//   onChangedBoxFiveTimeSlotSixTextFieldOne(String output) {
//     setState(() {
//       boxFiveTimeSlotSixTextFieldOne = output;
//     });
//     debugPrint(boxFiveTimeSlotSixTextFieldOne);
//   }

//   onChangedBoxFiveTimeSlotSixTextFieldTwo(String output) {
//     setState(() {
//       boxFiveTimeSlotSixTextFieldTwo = output;
//     });
//     debugPrint(boxFiveTimeSlotSixTextFieldTwo);
//   }

//   onChangedBoxFiveTimeSlotSixTextFieldThree(String output) {
//     setState(() {
//       boxFiveTimeSlotSixTextFieldThree = output;
//     });
//     debugPrint(boxFiveTimeSlotSixTextFieldThree);
//   }

//   onChangedBoxFiveTimeSlotSixTextFieldFour(String output) {
//     setState(() {
//       boxFiveTimeSlotSixTextFieldFour = output;
//     });
//     debugPrint(boxFiveTimeSlotSixTextFieldFour);
//   }

//   onChangedBoxFiveTimeSlotSixTextFieldFive(String output) {
//     setState(() {
//       boxFiveTimeSlotSixTextFieldFive = output;
//     });
//     debugPrint(boxFiveTimeSlotSixTextFieldFive);
//   }

//   onChangedBoxFiveTimeSlotSixTextFieldSix(String output) {
//     setState(() {
//       boxFiveTimeSlotSixTextFieldSix = output;
//     });
//     debugPrint(boxFiveTimeSlotSixTextFieldSix);
//   }

//   //------ BOX #6 ------
//   // Time Slot One
//   onChangedBoxSixTimeSlotOneTextFieldOne(String output) {
//     setState(() {
//       boxSixTimeSlotOneTextFieldOne = output;
//     });
//     debugPrint(boxSixTimeSlotOneTextFieldOne);
//   }

//   onChangedBoxSixTimeSlotOneTextFieldTwo(String output) {
//     setState(() {
//       boxSixTimeSlotOneTextFieldTwo = output;
//     });
//     debugPrint(boxSixTimeSlotOneTextFieldTwo);
//   }

//   onChangedBoxSixTimeSlotOneTextFieldThree(String output) {
//     setState(() {
//       boxSixTimeSlotOneTextFieldThree = output;
//     });
//     debugPrint(boxSixTimeSlotOneTextFieldThree);
//   }

//   onChangedBoxSixTimeSlotOneTextFieldFour(String output) {
//     setState(() {
//       boxSixTimeSlotOneTextFieldFour = output;
//     });
//     debugPrint(boxSixTimeSlotOneTextFieldFour);
//   }

//   onChangedBoxSixTimeSlotOneTextFieldFive(String output) {
//     setState(() {
//       boxSixTimeSlotOneTextFieldFive = output;
//     });
//     debugPrint(boxSixTimeSlotOneTextFieldFive);
//   }

//   onChangedBoxSixTimeSlotOneTextFieldSix(String output) {
//     setState(() {
//       boxSixTimeSlotOneTextFieldSix = output;
//     });
//     debugPrint(boxSixTimeSlotOneTextFieldSix);
//   }

//   // Time Slot Two
//   onChangedBoxSixTimeSlotTwoTextFieldOne(String output) {
//     setState(() {
//       boxSixTimeSlotTwoTextFieldOne = output;
//     });
//     debugPrint(boxSixTimeSlotTwoTextFieldOne);
//   }

//   onChangedBoxSixTimeSlotTwoTextFieldTwo(String output) {
//     setState(() {
//       boxSixTimeSlotTwoTextFieldTwo = output;
//     });
//     debugPrint(boxSixTimeSlotTwoTextFieldTwo);
//   }

//   onChangedBoxSixTimeSlotTwoTextFieldThree(String output) {
//     setState(() {
//       boxSixTimeSlotTwoTextFieldThree = output;
//     });
//     debugPrint(boxSixTimeSlotTwoTextFieldThree);
//   }

//   onChangedBoxSixTimeSlotTwoTextFieldFour(String output) {
//     setState(() {
//       boxSixTimeSlotTwoTextFieldFour = output;
//     });
//     debugPrint(boxSixTimeSlotTwoTextFieldFour);
//   }

//   onChangedBoxSixTimeSlotTwoTextFieldFive(String output) {
//     setState(() {
//       boxSixTimeSlotTwoTextFieldFive = output;
//     });
//     debugPrint(boxSixTimeSlotTwoTextFieldFive);
//   }

//   onChangedBoxSixTimeSlotTwoTextFieldSix(String output) {
//     setState(() {
//       boxSixTimeSlotTwoTextFieldSix = output;
//     });
//     debugPrint(boxSixTimeSlotTwoTextFieldSix);
//   }

//   // Time Slot Three
//   onChangedBoxSixTimeSlotThreeTextFieldOne(String output) {
//     setState(() {
//       boxSixTimeSlotThreeTextFieldOne = output;
//     });
//     debugPrint(boxSixTimeSlotThreeTextFieldOne);
//   }

//   onChangedBoxSixTimeSlotThreeTextFieldTwo(String output) {
//     setState(() {
//       boxSixTimeSlotThreeTextFieldTwo = output;
//     });
//     debugPrint(boxSixTimeSlotThreeTextFieldTwo);
//   }

//   onChangedBoxSixTimeSlotThreeTextFieldThree(String output) {
//     setState(() {
//       boxSixTimeSlotThreeTextFieldThree = output;
//     });
//     debugPrint(boxSixTimeSlotThreeTextFieldThree);
//   }

//   onChangedBoxSixTimeSlotThreeTextFieldFour(String output) {
//     setState(() {
//       boxSixTimeSlotThreeTextFieldFour = output;
//     });
//     debugPrint(boxSixTimeSlotThreeTextFieldFour);
//   }

//   onChangedBoxSixTimeSlotThreeTextFieldFive(String output) {
//     setState(() {
//       boxSixTimeSlotThreeTextFieldFive = output;
//     });
//     debugPrint(boxSixTimeSlotThreeTextFieldFive);
//   }

//   onChangedBoxSixTimeSlotThreeTextFieldSix(String output) {
//     setState(() {
//       boxSixTimeSlotThreeTextFieldSix = output;
//     });
//     debugPrint(boxSixTimeSlotThreeTextFieldSix);
//   }

//   // Time Slot Four
//   onChangedBoxSixTimeSlotFourTextFieldOne(String output) {
//     setState(() {
//       boxSixTimeSlotFourTextFieldOne = output;
//     });
//     debugPrint(boxSixTimeSlotFourTextFieldOne);
//   }

//   onChangedBoxSixTimeSlotFourTextFieldTwo(String output) {
//     setState(() {
//       boxSixTimeSlotFourTextFieldTwo = output;
//     });
//     debugPrint(boxSixTimeSlotFourTextFieldTwo);
//   }

//   onChangedBoxSixTimeSlotFourTextFieldThree(String output) {
//     setState(() {
//       boxSixTimeSlotFourTextFieldThree = output;
//     });
//     debugPrint(boxSixTimeSlotFourTextFieldThree);
//   }

//   onChangedBoxSixTimeSlotFourTextFieldFour(String output) {
//     setState(() {
//       boxSixTimeSlotFourTextFieldFour = output;
//     });
//     debugPrint(boxSixTimeSlotFourTextFieldFour);
//   }

//   onChangedBoxSixTimeSlotFourTextFieldFive(String output) {
//     setState(() {
//       boxSixTimeSlotFourTextFieldFive = output;
//     });
//     debugPrint(boxSixTimeSlotFourTextFieldFive);
//   }

//   onChangedBoxSixTimeSlotFourTextFieldSix(String output) {
//     setState(() {
//       boxSixTimeSlotFourTextFieldSix = output;
//     });
//     debugPrint(boxSixTimeSlotFourTextFieldSix);
//   }

//   // Time Slot Five
//   onChangedBoxSixTimeSlotFiveTextFieldOne(String output) {
//     setState(() {
//       boxSixTimeSlotFiveTextFieldOne = output;
//     });
//     debugPrint(boxSixTimeSlotFiveTextFieldOne);
//   }

//   onChangedBoxSixTimeSlotFiveTextFieldTwo(String output) {
//     setState(() {
//       boxSixTimeSlotFiveTextFieldTwo = output;
//     });
//     debugPrint(boxSixTimeSlotFiveTextFieldTwo);
//   }

//   onChangedBoxSixTimeSlotFiveTextFieldThree(String output) {
//     setState(() {
//       boxSixTimeSlotFiveTextFieldThree = output;
//     });
//     debugPrint(boxSixTimeSlotFiveTextFieldThree);
//   }

//   onChangedBoxSixTimeSlotFiveTextFieldFour(String output) {
//     setState(() {
//       boxSixTimeSlotFiveTextFieldFour = output;
//     });
//     debugPrint(boxSixTimeSlotFiveTextFieldFour);
//   }

//   onChangedBoxSixTimeSlotFiveTextFieldFive(String output) {
//     setState(() {
//       boxSixTimeSlotFiveTextFieldFive = output;
//     });
//     debugPrint(boxSixTimeSlotFiveTextFieldFive);
//   }

//   onChangedBoxSixTimeSlotFiveTextFieldSix(String output) {
//     setState(() {
//       boxSixTimeSlotFiveTextFieldSix = output;
//     });
//     debugPrint(boxSixTimeSlotFiveTextFieldSix);
//   }

//   // Time Slot Six
//   onChangedBoxSixTimeSlotSixTextFieldOne(String output) {
//     setState(() {
//       boxSixTimeSlotSixTextFieldOne = output;
//     });
//     debugPrint(boxSixTimeSlotSixTextFieldOne);
//   }

//   onChangedBoxSixTimeSlotSixTextFieldTwo(String output) {
//     setState(() {
//       boxSixTimeSlotSixTextFieldTwo = output;
//     });
//     debugPrint(boxSixTimeSlotSixTextFieldTwo);
//   }

//   onChangedBoxSixTimeSlotSixTextFieldThree(String output) {
//     setState(() {
//       boxSixTimeSlotSixTextFieldThree = output;
//     });
//     debugPrint(boxSixTimeSlotSixTextFieldThree);
//   }

//   onChangedBoxSixTimeSlotSixTextFieldFour(String output) {
//     setState(() {
//       boxSixTimeSlotSixTextFieldFour = output;
//     });
//     debugPrint(boxSixTimeSlotSixTextFieldFour);
//   }

//   onChangedBoxSixTimeSlotSixTextFieldFive(String output) {
//     setState(() {
//       boxSixTimeSlotSixTextFieldFive = output;
//     });
//     debugPrint(boxSixTimeSlotSixTextFieldFive);
//   }

//   onChangedBoxSixTimeSlotSixTextFieldSix(String output) {
//     setState(() {
//       boxSixTimeSlotSixTextFieldSix = output;
//     });
//     debugPrint(boxSixTimeSlotSixTextFieldSix);
//   }

//   onChangedSignature(Uint8List? output) {
//     setState(() {
//       signatureData = output;
//     });
//     debugPrint("$output");
//   }

//   //Save Signature as a PNG
//   Future<String?> saveSignatureImageToStorage(Uint8List? signatureData) async {
//     if (signatureData != null) {
//       try {
//         DateTime today = DateTime.now();
//         String signatureFileName =
//             "${today.year}${today.month}${today.day}${today.hour}${today.minute}${today.second}.png";
//         String signatureSubfolderPath =
//             '${stateController.getDocumentsDirectoryPath()}/${CFGString().signatureSubfolderName}';
//         String filePath = '$signatureSubfolderPath/$signatureFileName';

//         await File(filePath).writeAsBytes(signatureData);

//         debugPrint('Signature saved to local storage: $filePath');
//         return signatureFileName;
//       } catch (e) {
//         debugPrint('Error saving signature: $e');
//         return null;
//       }
//     }
//     return null;
//   }

//   //Saving Form Data
//   onSave() async {
//     //Check if required fields are filled to "Save" Form.
//     if (client != null &&
//         farm != null &&
//         crop != null &&
//         variety != null &&
//         date != null &&
//         measurementUnit != null) {
//       await requestPermission(Permission.storage);
//       signatureName = await saveSignatureImageToStorage(signatureData);
//       //Add save Form data to DB here
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     tabController = TabController(
//       initialIndex: selectedIndex,
//       length: 6,
//       vsync: this,
//     );

//     // // Add a post-frame callback to measure the child's height after layout.
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   final RenderBox renderBox =
//     //       _childKey.currentContext?.findRenderObject() as RenderBox;
//     //   setState(() {
//     //     _childHeight = renderBox.size.height;
//     //     print(_childHeight);
//     //   });
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     return SafeArea(
//         child: DefaultTabController(
//       length: 6,
//       child: Scaffold(
//         backgroundColor: CFGTheme.bgColorScreen,
//         drawerEnableOpenDragGesture: false,
//         appBar: SimpleFormsAppBar(
//             title: "Finished Product Size Check (Hourly)",
//             isUpdate: widget.isUpdate),
//         //
//         body: Padding(
//           padding: EdgeInsets.only(
//             left: CFGTheme.bodyLRPadding,
//             right: CFGTheme.bodyLRPadding,
//             // top: CFGTheme.bodyTBPadding,
//             bottom: CFGTheme.bodyTBPadding,
//           ),
//           child: ListView(children: [
//             //
//             FormDropdown(
//               isUpdate: widget.isUpdate,
//               dropdownList: stateController.cropList,
//               label: "Client",
//               dropdownHintText: "Please select a client",
//               isRequired: true,
//               onChangedDropdown: onChangedDropdownClient,
//             ),
//             FormDropdown(
//               isUpdate: widget.isUpdate,
//               dropdownList: stateController.farmList,
//               label: "Farm",
//               dropdownHintText: "Please select a farm",
//               isRequired: true,
//               onChangedDropdown: onChangedDropdownFarm,
//             ),
//             FormDropdown(
//               isUpdate: widget.isUpdate,
//               dropdownList: stateController.cropList,
//               label: "Crop",
//               dropdownHintText: "Please select a crop",
//               isRequired: true,
//               onChangedDropdown: onChangedDropdownCrop,
//             ),
//             FormDropdown(
//               isUpdate: widget.isUpdate,
//               dropdownList: varietyList,
//               label: "Variety",
//               dropdownHintText: "Please select a variety",
//               isRequired: true,
//               onChangedDropdown: onChangedDropdownVariety,
//             ),

//             FormDatePicker(
//               isUpdate: widget.isUpdate,
//               initialData: null,
//               label: "Date",
//               hintText: "Tap to pick a date",
//               isRequired: true,
//               onChangedDate: onChangedDate,
//             ),

//             FormTextField(
//               isUpdate: widget.isUpdate,
//               label: "Measurement unit",
//               hintText: "Type here",
//               isRequired: true,
//               onChangedText: onChangedMeasurementUnit,
//             ),
//             FormTextField(
//               isUpdate: widget.isUpdate,
//               label: "Comment",
//               hintText: "Type here",
//               isRequired: false,
//               onChangedText: onChangedComment,
//             ),

//             //------------------- Box Time Slot Table -------------------

//             Padding(
//               padding: const EdgeInsets.only(top: 20, bottom: 10),
//               child: Text("Select the BOX and fill data",
//                   style: TextStyle(
//                     fontSize: CFGFont.defaultFontSize,
//                     fontWeight: CFGFont.regularFontWeight,
//                     color: CFGFont.defaultFontColor,
//                   )),
//             ),

//             Divider(color: CFGColor.lightGrey, height: 0),

//             TabBar(
//               controller: tabController,
//               onTap: (int index) {
//                 setState(() {
//                   selectedIndex = index;
//                   tabController.animateTo(index);
//                 });
//               },
//               indicator: BoxDecoration(
//                   color: CFGTheme.buttonLightGrey,
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: CFGTheme.button,
//                     width: 2.0,
//                   )),
//               indicatorWeight: 5,
//               dividerColor: CFGColor.lightGrey,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicatorColor: CFGTheme.button,
//               labelColor: CFGFont.defaultFontColor,
//               labelPadding: EdgeInsets.zero,
//               unselectedLabelColor: CFGFont.greyFontColor,
//               overlayColor: WidgetStatePropertyAll(CFGTheme.buttonLightGrey),
//               labelStyle: TextStyle(
//                 fontFamily: 'Oswald',
//                 // letterSpacing: 0.5,
//                 fontSize: CFGFont.defaultFontSize,
//                 fontWeight: CFGFont.mediumFontWeight,
//                 color: CFGFont.defaultFontColor,
//               ),
//               tabs: const [
//                 Tab(text: 'BOX #1'),
//                 Tab(text: 'BOX #2'),
//                 Tab(text: 'BOX #3'),
//                 Tab(text: 'BOX #4'),
//                 Tab(text: 'BOX #5'),
//                 Tab(text: 'BOX #6'),
//               ],
//             ),

//             SB(
//               height: 1100,
//               child: TabBarView(
//                 controller: tabController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   //Box 1
//                   Column(
//                     children: [
//                       //
//                       FormTextField(
//                         isUpdate: widget.isUpdate,
//                         label: "",
//                         hintText: "Type here",
//                         isRequired: false,
//                         onChangedText: onChangedBoxOneLabel,
//                       ),

//                       const SB(height: 10),

//                       ListView.builder(
//                           itemCount: stateController.boxTimeSlotsHourly.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 //
//                                 const SB(height: 5),

//                                 FormBoxTimeSlotTableRow(
//                                   isUpdate: widget.isUpdate,
//                                   timeSlot:
//                                       stateController.boxTimeSlotsHourly[index],
//                                   onChangedTextFieldOne: index == 0
//                                       ? onChangedBoxOneTimeSlotOneTextFieldOne
//                                       : index == 1
//                                           ? onChangedBoxOneTimeSlotTwoTextFieldOne
//                                           : index == 2
//                                               ? onChangedBoxOneTimeSlotThreeTextFieldOne
//                                               : index == 3
//                                                   ? onChangedBoxOneTimeSlotFourTextFieldOne
//                                                   : index == 4
//                                                       ? onChangedBoxOneTimeSlotFiveTextFieldOne
//                                                       : index == 5
//                                                           ? onChangedBoxOneTimeSlotSixTextFieldOne
//                                                           : (val) {},
//                                   onChangedTextFieldTwo: index == 0
//                                       ? onChangedBoxOneTimeSlotOneTextFieldTwo
//                                       : index == 1
//                                           ? onChangedBoxOneTimeSlotTwoTextFieldTwo
//                                           : index == 2
//                                               ? onChangedBoxOneTimeSlotThreeTextFieldTwo
//                                               : index == 3
//                                                   ? onChangedBoxOneTimeSlotFourTextFieldTwo
//                                                   : index == 4
//                                                       ? onChangedBoxOneTimeSlotFiveTextFieldTwo
//                                                       : index == 5
//                                                           ? onChangedBoxOneTimeSlotSixTextFieldTwo
//                                                           : (val) {},
//                                   onChangedTextFieldThree: index == 0
//                                       ? onChangedBoxOneTimeSlotOneTextFieldThree
//                                       : index == 1
//                                           ? onChangedBoxOneTimeSlotTwoTextFieldThree
//                                           : index == 2
//                                               ? onChangedBoxOneTimeSlotThreeTextFieldThree
//                                               : index == 3
//                                                   ? onChangedBoxOneTimeSlotFourTextFieldThree
//                                                   : index == 4
//                                                       ? onChangedBoxOneTimeSlotFiveTextFieldThree
//                                                       : index == 5
//                                                           ? onChangedBoxOneTimeSlotSixTextFieldThree
//                                                           : (val) {},
//                                   onChangedTextFieldFour: index == 0
//                                       ? onChangedBoxOneTimeSlotOneTextFieldFour
//                                       : index == 1
//                                           ? onChangedBoxOneTimeSlotTwoTextFieldFour
//                                           : index == 2
//                                               ? onChangedBoxOneTimeSlotThreeTextFieldFour
//                                               : index == 3
//                                                   ? onChangedBoxOneTimeSlotFourTextFieldFour
//                                                   : index == 4
//                                                       ? onChangedBoxOneTimeSlotFiveTextFieldFour
//                                                       : index == 5
//                                                           ? onChangedBoxOneTimeSlotSixTextFieldFour
//                                                           : (val) {},
//                                   onChangedTextFieldFive: index == 0
//                                       ? onChangedBoxOneTimeSlotOneTextFieldFive
//                                       : index == 1
//                                           ? onChangedBoxOneTimeSlotTwoTextFieldFive
//                                           : index == 2
//                                               ? onChangedBoxOneTimeSlotThreeTextFieldFive
//                                               : index == 3
//                                                   ? onChangedBoxOneTimeSlotFourTextFieldFive
//                                                   : index == 4
//                                                       ? onChangedBoxOneTimeSlotFiveTextFieldFive
//                                                       : index == 5
//                                                           ? onChangedBoxOneTimeSlotSixTextFieldFive
//                                                           : (val) {},
//                                   onChangedTextFieldSix: index == 0
//                                       ? onChangedBoxOneTimeSlotOneTextFieldSix
//                                       : index == 1
//                                           ? onChangedBoxOneTimeSlotTwoTextFieldSix
//                                           : index == 2
//                                               ? onChangedBoxOneTimeSlotThreeTextFieldSix
//                                               : index == 3
//                                                   ? onChangedBoxOneTimeSlotFourTextFieldSix
//                                                   : index == 4
//                                                       ? onChangedBoxOneTimeSlotFiveTextFieldSix
//                                                       : index == 5
//                                                           ? onChangedBoxOneTimeSlotSixTextFieldSix
//                                                           : (val) {},
//                                 ),

//                                 const SB(height: 5),

//                                 Divider(color: CFGColor.lightGrey, height: 0),
//                               ],
//                             );
//                           }),
//                     ],
//                   ),

//                   //Box 2
//                   Column(
//                     children: [
//                       //
//                       FormTextField(
//                         isUpdate: widget.isUpdate,
//                         label: "",
//                         hintText: "Type here",
//                         isRequired: false,
//                         onChangedText: onChangedBoxTwoLabel,
//                       ),

//                       const SB(height: 10),

//                       ListView.builder(
//                           itemCount: stateController.boxTimeSlotsHourly.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 //
//                                 const SB(height: 5),

//                                 FormBoxTimeSlotTableRow(
//                                   isUpdate: widget.isUpdate,
//                                   timeSlot:
//                                       stateController.boxTimeSlotsHourly[index],
//                                   onChangedTextFieldOne: index == 0
//                                       ? onChangedBoxTwoTimeSlotOneTextFieldOne
//                                       : index == 1
//                                           ? onChangedBoxTwoTimeSlotTwoTextFieldOne
//                                           : index == 2
//                                               ? onChangedBoxTwoTimeSlotThreeTextFieldOne
//                                               : index == 3
//                                                   ? onChangedBoxTwoTimeSlotFourTextFieldOne
//                                                   : index == 4
//                                                       ? onChangedBoxTwoTimeSlotFiveTextFieldOne
//                                                       : index == 5
//                                                           ? onChangedBoxTwoTimeSlotSixTextFieldOne
//                                                           : (val) {},
//                                   onChangedTextFieldTwo: index == 0
//                                       ? onChangedBoxTwoTimeSlotOneTextFieldTwo
//                                       : index == 1
//                                           ? onChangedBoxTwoTimeSlotTwoTextFieldTwo
//                                           : index == 2
//                                               ? onChangedBoxTwoTimeSlotThreeTextFieldTwo
//                                               : index == 3
//                                                   ? onChangedBoxTwoTimeSlotFourTextFieldTwo
//                                                   : index == 4
//                                                       ? onChangedBoxTwoTimeSlotFiveTextFieldTwo
//                                                       : index == 5
//                                                           ? onChangedBoxTwoTimeSlotSixTextFieldTwo
//                                                           : (val) {},
//                                   onChangedTextFieldThree: index == 0
//                                       ? onChangedBoxTwoTimeSlotOneTextFieldThree
//                                       : index == 1
//                                           ? onChangedBoxTwoTimeSlotTwoTextFieldThree
//                                           : index == 2
//                                               ? onChangedBoxTwoTimeSlotThreeTextFieldThree
//                                               : index == 3
//                                                   ? onChangedBoxTwoTimeSlotFourTextFieldThree
//                                                   : index == 4
//                                                       ? onChangedBoxTwoTimeSlotFiveTextFieldThree
//                                                       : index == 5
//                                                           ? onChangedBoxTwoTimeSlotSixTextFieldThree
//                                                           : (val) {},
//                                   onChangedTextFieldFour: index == 0
//                                       ? onChangedBoxTwoTimeSlotOneTextFieldFour
//                                       : index == 1
//                                           ? onChangedBoxTwoTimeSlotTwoTextFieldFour
//                                           : index == 2
//                                               ? onChangedBoxTwoTimeSlotThreeTextFieldFour
//                                               : index == 3
//                                                   ? onChangedBoxTwoTimeSlotFourTextFieldFour
//                                                   : index == 4
//                                                       ? onChangedBoxTwoTimeSlotFiveTextFieldFour
//                                                       : index == 5
//                                                           ? onChangedBoxTwoTimeSlotSixTextFieldFour
//                                                           : (val) {},
//                                   onChangedTextFieldFive: index == 0
//                                       ? onChangedBoxTwoTimeSlotOneTextFieldFive
//                                       : index == 1
//                                           ? onChangedBoxTwoTimeSlotTwoTextFieldFive
//                                           : index == 2
//                                               ? onChangedBoxTwoTimeSlotThreeTextFieldFive
//                                               : index == 3
//                                                   ? onChangedBoxTwoTimeSlotFourTextFieldFive
//                                                   : index == 4
//                                                       ? onChangedBoxTwoTimeSlotFiveTextFieldFive
//                                                       : index == 5
//                                                           ? onChangedBoxTwoTimeSlotSixTextFieldFive
//                                                           : (val) {},
//                                   onChangedTextFieldSix: index == 0
//                                       ? onChangedBoxTwoTimeSlotOneTextFieldSix
//                                       : index == 1
//                                           ? onChangedBoxTwoTimeSlotTwoTextFieldSix
//                                           : index == 2
//                                               ? onChangedBoxTwoTimeSlotThreeTextFieldSix
//                                               : index == 3
//                                                   ? onChangedBoxTwoTimeSlotFourTextFieldSix
//                                                   : index == 4
//                                                       ? onChangedBoxTwoTimeSlotFiveTextFieldSix
//                                                       : index == 5
//                                                           ? onChangedBoxTwoTimeSlotSixTextFieldSix
//                                                           : (val) {},
//                                 ),

//                                 const SB(height: 5),

//                                 Divider(color: CFGColor.lightGrey, height: 0),
//                               ],
//                             );
//                           }),
//                     ],
//                   ),

//                   //Box 3
//                   Column(
//                     children: [
//                       //
//                       FormTextField(
//                         isUpdate: widget.isUpdate,
//                         label: "",
//                         hintText: "Type here",
//                         isRequired: false,
//                         onChangedText: onChangedBoxThreeLabel,
//                       ),

//                       const SB(height: 10),

//                       ListView.builder(
//                           itemCount: stateController.boxTimeSlotsHourly.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 //
//                                 const SB(height: 5),

//                                 FormBoxTimeSlotTableRow(
//                                   isUpdate: widget.isUpdate,
//                                   timeSlot:
//                                       stateController.boxTimeSlotsHourly[index],
//                                   onChangedTextFieldOne: index == 0
//                                       ? onChangedBoxThreeTimeSlotOneTextFieldOne
//                                       : index == 1
//                                           ? onChangedBoxThreeTimeSlotTwoTextFieldOne
//                                           : index == 2
//                                               ? onChangedBoxThreeTimeSlotThreeTextFieldOne
//                                               : index == 3
//                                                   ? onChangedBoxThreeTimeSlotFourTextFieldOne
//                                                   : index == 4
//                                                       ? onChangedBoxThreeTimeSlotFiveTextFieldOne
//                                                       : index == 5
//                                                           ? onChangedBoxThreeTimeSlotSixTextFieldOne
//                                                           : (val) {},
//                                   onChangedTextFieldTwo: index == 0
//                                       ? onChangedBoxThreeTimeSlotOneTextFieldTwo
//                                       : index == 1
//                                           ? onChangedBoxThreeTimeSlotTwoTextFieldTwo
//                                           : index == 2
//                                               ? onChangedBoxThreeTimeSlotThreeTextFieldTwo
//                                               : index == 3
//                                                   ? onChangedBoxThreeTimeSlotFourTextFieldTwo
//                                                   : index == 4
//                                                       ? onChangedBoxThreeTimeSlotFiveTextFieldTwo
//                                                       : index == 5
//                                                           ? onChangedBoxThreeTimeSlotSixTextFieldTwo
//                                                           : (val) {},
//                                   onChangedTextFieldThree: index == 0
//                                       ? onChangedBoxThreeTimeSlotOneTextFieldThree
//                                       : index == 1
//                                           ? onChangedBoxThreeTimeSlotTwoTextFieldThree
//                                           : index == 2
//                                               ? onChangedBoxThreeTimeSlotThreeTextFieldThree
//                                               : index == 3
//                                                   ? onChangedBoxThreeTimeSlotFourTextFieldThree
//                                                   : index == 4
//                                                       ? onChangedBoxThreeTimeSlotFiveTextFieldThree
//                                                       : index == 5
//                                                           ? onChangedBoxThreeTimeSlotSixTextFieldThree
//                                                           : (val) {},
//                                   onChangedTextFieldFour: index == 0
//                                       ? onChangedBoxThreeTimeSlotOneTextFieldFour
//                                       : index == 1
//                                           ? onChangedBoxThreeTimeSlotTwoTextFieldFour
//                                           : index == 2
//                                               ? onChangedBoxThreeTimeSlotThreeTextFieldFour
//                                               : index == 3
//                                                   ? onChangedBoxThreeTimeSlotFourTextFieldFour
//                                                   : index == 4
//                                                       ? onChangedBoxThreeTimeSlotFiveTextFieldFour
//                                                       : index == 5
//                                                           ? onChangedBoxThreeTimeSlotSixTextFieldFour
//                                                           : (val) {},
//                                   onChangedTextFieldFive: index == 0
//                                       ? onChangedBoxThreeTimeSlotOneTextFieldFive
//                                       : index == 1
//                                           ? onChangedBoxThreeTimeSlotTwoTextFieldFive
//                                           : index == 2
//                                               ? onChangedBoxThreeTimeSlotThreeTextFieldFive
//                                               : index == 3
//                                                   ? onChangedBoxThreeTimeSlotFourTextFieldFive
//                                                   : index == 4
//                                                       ? onChangedBoxThreeTimeSlotFiveTextFieldFive
//                                                       : index == 5
//                                                           ? onChangedBoxThreeTimeSlotSixTextFieldFive
//                                                           : (val) {},
//                                   onChangedTextFieldSix: index == 0
//                                       ? onChangedBoxThreeTimeSlotOneTextFieldSix
//                                       : index == 1
//                                           ? onChangedBoxThreeTimeSlotTwoTextFieldSix
//                                           : index == 2
//                                               ? onChangedBoxThreeTimeSlotThreeTextFieldSix
//                                               : index == 3
//                                                   ? onChangedBoxThreeTimeSlotFourTextFieldSix
//                                                   : index == 4
//                                                       ? onChangedBoxThreeTimeSlotFiveTextFieldSix
//                                                       : index == 5
//                                                           ? onChangedBoxThreeTimeSlotSixTextFieldSix
//                                                           : (val) {},
//                                 ),

//                                 const SB(height: 5),

//                                 Divider(color: CFGColor.lightGrey, height: 0),
//                               ],
//                             );
//                           }),
//                     ],
//                   ),

//                   //Box 4
//                   Column(
//                     children: [
//                       //
//                       FormTextField(
//                         isUpdate: widget.isUpdate,
//                         label: "",
//                         hintText: "Type here",
//                         isRequired: false,
//                         onChangedText: onChangedBoxFourLabel,
//                       ),

//                       const SB(height: 10),

//                       ListView.builder(
//                           itemCount: stateController.boxTimeSlotsHourly.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 //
//                                 const SB(height: 5),

//                                 FormBoxTimeSlotTableRow(
//                                   isUpdate: widget.isUpdate,
//                                   timeSlot:
//                                       stateController.boxTimeSlotsHourly[index],
//                                   onChangedTextFieldOne: index == 0
//                                       ? onChangedBoxFourTimeSlotOneTextFieldOne
//                                       : index == 1
//                                           ? onChangedBoxFourTimeSlotTwoTextFieldOne
//                                           : index == 2
//                                               ? onChangedBoxFourTimeSlotThreeTextFieldOne
//                                               : index == 3
//                                                   ? onChangedBoxFourTimeSlotFourTextFieldOne
//                                                   : index == 4
//                                                       ? onChangedBoxFourTimeSlotFiveTextFieldOne
//                                                       : index == 5
//                                                           ? onChangedBoxFourTimeSlotSixTextFieldOne
//                                                           : (val) {},
//                                   onChangedTextFieldTwo: index == 0
//                                       ? onChangedBoxFourTimeSlotOneTextFieldTwo
//                                       : index == 1
//                                           ? onChangedBoxFourTimeSlotTwoTextFieldTwo
//                                           : index == 2
//                                               ? onChangedBoxFourTimeSlotThreeTextFieldTwo
//                                               : index == 3
//                                                   ? onChangedBoxFourTimeSlotFourTextFieldTwo
//                                                   : index == 4
//                                                       ? onChangedBoxFourTimeSlotFiveTextFieldTwo
//                                                       : index == 5
//                                                           ? onChangedBoxFourTimeSlotSixTextFieldTwo
//                                                           : (val) {},
//                                   onChangedTextFieldThree: index == 0
//                                       ? onChangedBoxFourTimeSlotOneTextFieldThree
//                                       : index == 1
//                                           ? onChangedBoxFourTimeSlotTwoTextFieldThree
//                                           : index == 2
//                                               ? onChangedBoxFourTimeSlotThreeTextFieldThree
//                                               : index == 3
//                                                   ? onChangedBoxFourTimeSlotFourTextFieldThree
//                                                   : index == 4
//                                                       ? onChangedBoxFourTimeSlotFiveTextFieldThree
//                                                       : index == 5
//                                                           ? onChangedBoxFourTimeSlotSixTextFieldThree
//                                                           : (val) {},
//                                   onChangedTextFieldFour: index == 0
//                                       ? onChangedBoxFourTimeSlotOneTextFieldFour
//                                       : index == 1
//                                           ? onChangedBoxFourTimeSlotTwoTextFieldFour
//                                           : index == 2
//                                               ? onChangedBoxFourTimeSlotThreeTextFieldFour
//                                               : index == 3
//                                                   ? onChangedBoxFourTimeSlotFourTextFieldFour
//                                                   : index == 4
//                                                       ? onChangedBoxFourTimeSlotFiveTextFieldFour
//                                                       : index == 5
//                                                           ? onChangedBoxFourTimeSlotSixTextFieldFour
//                                                           : (val) {},
//                                   onChangedTextFieldFive: index == 0
//                                       ? onChangedBoxFourTimeSlotOneTextFieldFive
//                                       : index == 1
//                                           ? onChangedBoxFourTimeSlotTwoTextFieldFive
//                                           : index == 2
//                                               ? onChangedBoxFourTimeSlotThreeTextFieldFive
//                                               : index == 3
//                                                   ? onChangedBoxFourTimeSlotFourTextFieldFive
//                                                   : index == 4
//                                                       ? onChangedBoxFourTimeSlotFiveTextFieldFive
//                                                       : index == 5
//                                                           ? onChangedBoxFourTimeSlotSixTextFieldFive
//                                                           : (val) {},
//                                   onChangedTextFieldSix: index == 0
//                                       ? onChangedBoxFourTimeSlotOneTextFieldSix
//                                       : index == 1
//                                           ? onChangedBoxFourTimeSlotTwoTextFieldSix
//                                           : index == 2
//                                               ? onChangedBoxFourTimeSlotThreeTextFieldSix
//                                               : index == 3
//                                                   ? onChangedBoxFourTimeSlotFourTextFieldSix
//                                                   : index == 4
//                                                       ? onChangedBoxFourTimeSlotFiveTextFieldSix
//                                                       : index == 5
//                                                           ? onChangedBoxFourTimeSlotSixTextFieldSix
//                                                           : (val) {},
//                                 ),

//                                 const SB(height: 5),

//                                 Divider(color: CFGColor.lightGrey, height: 0),
//                               ],
//                             );
//                           }),
//                     ],
//                   ),

//                   //Box 5
//                   Column(
//                     children: [
//                       //
//                       FormTextField(
//                         isUpdate: widget.isUpdate,
//                         label: "",
//                         hintText: "Type here",
//                         isRequired: false,
//                         onChangedText: onChangedBoxFiveLabel,
//                       ),

//                       const SB(height: 10),

//                       ListView.builder(
//                           itemCount: stateController.boxTimeSlotsHourly.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 //
//                                 const SB(height: 5),

//                                 FormBoxTimeSlotTableRow(
//                                   isUpdate: widget.isUpdate,
//                                   timeSlot:
//                                       stateController.boxTimeSlotsHourly[index],
//                                   onChangedTextFieldOne: index == 0
//                                       ? onChangedBoxFiveTimeSlotOneTextFieldOne
//                                       : index == 1
//                                           ? onChangedBoxFiveTimeSlotTwoTextFieldOne
//                                           : index == 2
//                                               ? onChangedBoxFiveTimeSlotThreeTextFieldOne
//                                               : index == 3
//                                                   ? onChangedBoxFiveTimeSlotFourTextFieldOne
//                                                   : index == 4
//                                                       ? onChangedBoxFiveTimeSlotFiveTextFieldOne
//                                                       : index == 5
//                                                           ? onChangedBoxFiveTimeSlotSixTextFieldOne
//                                                           : (val) {},
//                                   onChangedTextFieldTwo: index == 0
//                                       ? onChangedBoxFiveTimeSlotOneTextFieldTwo
//                                       : index == 1
//                                           ? onChangedBoxFiveTimeSlotTwoTextFieldTwo
//                                           : index == 2
//                                               ? onChangedBoxFiveTimeSlotThreeTextFieldTwo
//                                               : index == 3
//                                                   ? onChangedBoxFiveTimeSlotFourTextFieldTwo
//                                                   : index == 4
//                                                       ? onChangedBoxFiveTimeSlotFiveTextFieldTwo
//                                                       : index == 5
//                                                           ? onChangedBoxFiveTimeSlotSixTextFieldTwo
//                                                           : (val) {},
//                                   onChangedTextFieldThree: index == 0
//                                       ? onChangedBoxFiveTimeSlotOneTextFieldThree
//                                       : index == 1
//                                           ? onChangedBoxFiveTimeSlotTwoTextFieldThree
//                                           : index == 2
//                                               ? onChangedBoxFiveTimeSlotThreeTextFieldThree
//                                               : index == 3
//                                                   ? onChangedBoxFiveTimeSlotFourTextFieldThree
//                                                   : index == 4
//                                                       ? onChangedBoxFiveTimeSlotFiveTextFieldThree
//                                                       : index == 5
//                                                           ? onChangedBoxFiveTimeSlotSixTextFieldThree
//                                                           : (val) {},
//                                   onChangedTextFieldFour: index == 0
//                                       ? onChangedBoxFiveTimeSlotOneTextFieldFour
//                                       : index == 1
//                                           ? onChangedBoxFiveTimeSlotTwoTextFieldFour
//                                           : index == 2
//                                               ? onChangedBoxFiveTimeSlotThreeTextFieldFour
//                                               : index == 3
//                                                   ? onChangedBoxFiveTimeSlotFourTextFieldFour
//                                                   : index == 4
//                                                       ? onChangedBoxFiveTimeSlotFiveTextFieldFour
//                                                       : index == 5
//                                                           ? onChangedBoxFiveTimeSlotSixTextFieldFour
//                                                           : (val) {},
//                                   onChangedTextFieldFive: index == 0
//                                       ? onChangedBoxFiveTimeSlotOneTextFieldFive
//                                       : index == 1
//                                           ? onChangedBoxFiveTimeSlotTwoTextFieldFive
//                                           : index == 2
//                                               ? onChangedBoxFiveTimeSlotThreeTextFieldFive
//                                               : index == 3
//                                                   ? onChangedBoxFiveTimeSlotFourTextFieldFive
//                                                   : index == 4
//                                                       ? onChangedBoxFiveTimeSlotFiveTextFieldFive
//                                                       : index == 5
//                                                           ? onChangedBoxFiveTimeSlotSixTextFieldFive
//                                                           : (val) {},
//                                   onChangedTextFieldSix: index == 0
//                                       ? onChangedBoxFiveTimeSlotOneTextFieldSix
//                                       : index == 1
//                                           ? onChangedBoxFiveTimeSlotTwoTextFieldSix
//                                           : index == 2
//                                               ? onChangedBoxFiveTimeSlotThreeTextFieldSix
//                                               : index == 3
//                                                   ? onChangedBoxFiveTimeSlotFourTextFieldSix
//                                                   : index == 4
//                                                       ? onChangedBoxFiveTimeSlotFiveTextFieldSix
//                                                       : index == 5
//                                                           ? onChangedBoxFiveTimeSlotSixTextFieldSix
//                                                           : (val) {},
//                                 ),

//                                 const SB(height: 5),

//                                 Divider(color: CFGColor.lightGrey, height: 0),
//                               ],
//                             );
//                           }),
//                     ],
//                   ),

//                   //Box 6
//                   Column(
//                     children: [
//                       //
//                       FormTextField(
//                         isUpdate: widget.isUpdate,
//                         label: "",
//                         hintText: "Type here",
//                         isRequired: false,
//                         onChangedText: onChangedBoxSixLabel,
//                       ),

//                       const SB(height: 10),

//                       ListView.builder(
//                           itemCount: stateController.boxTimeSlotsHourly.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 //
//                                 const SB(height: 5),

//                                 FormBoxTimeSlotTableRow(
//                                   isUpdate: widget.isUpdate,
//                                   timeSlot:
//                                       stateController.boxTimeSlotsHourly[index],
//                                   onChangedTextFieldOne: index == 0
//                                       ? onChangedBoxSixTimeSlotOneTextFieldOne
//                                       : index == 1
//                                           ? onChangedBoxSixTimeSlotTwoTextFieldOne
//                                           : index == 2
//                                               ? onChangedBoxSixTimeSlotThreeTextFieldOne
//                                               : index == 3
//                                                   ? onChangedBoxSixTimeSlotFourTextFieldOne
//                                                   : index == 4
//                                                       ? onChangedBoxSixTimeSlotFiveTextFieldOne
//                                                       : index == 5
//                                                           ? onChangedBoxSixTimeSlotSixTextFieldOne
//                                                           : (val) {},
//                                   onChangedTextFieldTwo: index == 0
//                                       ? onChangedBoxSixTimeSlotOneTextFieldTwo
//                                       : index == 1
//                                           ? onChangedBoxSixTimeSlotTwoTextFieldTwo
//                                           : index == 2
//                                               ? onChangedBoxSixTimeSlotThreeTextFieldTwo
//                                               : index == 3
//                                                   ? onChangedBoxSixTimeSlotFourTextFieldTwo
//                                                   : index == 4
//                                                       ? onChangedBoxSixTimeSlotFiveTextFieldTwo
//                                                       : index == 5
//                                                           ? onChangedBoxSixTimeSlotSixTextFieldTwo
//                                                           : (val) {},
//                                   onChangedTextFieldThree: index == 0
//                                       ? onChangedBoxSixTimeSlotOneTextFieldThree
//                                       : index == 1
//                                           ? onChangedBoxSixTimeSlotTwoTextFieldThree
//                                           : index == 2
//                                               ? onChangedBoxSixTimeSlotThreeTextFieldThree
//                                               : index == 3
//                                                   ? onChangedBoxSixTimeSlotFourTextFieldThree
//                                                   : index == 4
//                                                       ? onChangedBoxSixTimeSlotFiveTextFieldThree
//                                                       : index == 5
//                                                           ? onChangedBoxSixTimeSlotSixTextFieldThree
//                                                           : (val) {},
//                                   onChangedTextFieldFour: index == 0
//                                       ? onChangedBoxSixTimeSlotOneTextFieldFour
//                                       : index == 1
//                                           ? onChangedBoxSixTimeSlotTwoTextFieldFour
//                                           : index == 2
//                                               ? onChangedBoxSixTimeSlotThreeTextFieldFour
//                                               : index == 3
//                                                   ? onChangedBoxSixTimeSlotFourTextFieldFour
//                                                   : index == 4
//                                                       ? onChangedBoxSixTimeSlotFiveTextFieldFour
//                                                       : index == 5
//                                                           ? onChangedBoxSixTimeSlotSixTextFieldFour
//                                                           : (val) {},
//                                   onChangedTextFieldFive: index == 0
//                                       ? onChangedBoxSixTimeSlotOneTextFieldFive
//                                       : index == 1
//                                           ? onChangedBoxSixTimeSlotTwoTextFieldFive
//                                           : index == 2
//                                               ? onChangedBoxSixTimeSlotThreeTextFieldFive
//                                               : index == 3
//                                                   ? onChangedBoxSixTimeSlotFourTextFieldFive
//                                                   : index == 4
//                                                       ? onChangedBoxSixTimeSlotFiveTextFieldFive
//                                                       : index == 5
//                                                           ? onChangedBoxSixTimeSlotSixTextFieldFive
//                                                           : (val) {},
//                                   onChangedTextFieldSix: index == 0
//                                       ? onChangedBoxSixTimeSlotOneTextFieldSix
//                                       : index == 1
//                                           ? onChangedBoxSixTimeSlotTwoTextFieldSix
//                                           : index == 2
//                                               ? onChangedBoxSixTimeSlotThreeTextFieldSix
//                                               : index == 3
//                                                   ? onChangedBoxSixTimeSlotFourTextFieldSix
//                                                   : index == 4
//                                                       ? onChangedBoxSixTimeSlotFiveTextFieldSix
//                                                       : index == 5
//                                                           ? onChangedBoxSixTimeSlotSixTextFieldSix
//                                                           : (val) {},
//                                 ),

//                                 const SB(height: 5),

//                                 Divider(color: CFGColor.lightGrey, height: 0),
//                               ],
//                             );
//                           }),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // const SB(height: 20),

//             //Add Signature widget here
//             FormSignature(onChangedSignaturePngData: onChangedSignature),

//             Container(
//               color: CFGTheme.bgColorScreen,
//               padding: const EdgeInsets.only(top: 20, bottom: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   //Cancel Button
//                   TextButton(
//                     style: ButtonStyle(
//                       fixedSize: const WidgetStatePropertyAll(Size(130, 44)),
//                       backgroundColor:
//                           WidgetStatePropertyAll(CFGColor.lightGrey),
//                       overlayColor:
//                           WidgetStatePropertyAll(CFGTheme.buttonOverlay),
//                       shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(CFGTheme.buttonRadius))),
//                     ),
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text("Cancel",
//                         style: TextStyle(
//                           fontSize: CFGFont.subTitleFontSize,
//                           fontWeight: CFGFont.regularFontWeight,
//                           color: CFGFont.defaultFontColor,
//                         )),
//                   ),

//                   //Save Button
//                   TextButton(
//                     style: ButtonStyle(
//                       fixedSize: const WidgetStatePropertyAll(Size(130, 44)),
//                       backgroundColor:
//                           WidgetStatePropertyAll(CFGTheme.button),
//                       overlayColor:
//                           WidgetStatePropertyAll(CFGTheme.buttonOverlay),
//                       shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(CFGTheme.buttonRadius))),
//                     ),
//                     onPressed: () async {
//                       await onSave();
//                     },
//                     child: Text("Save",
//                         style: TextStyle(
//                           fontSize: CFGFont.subTitleFontSize,
//                           fontWeight: CFGFont.regularFontWeight,
//                           color: CFGFont.whiteFontColor,
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ),
//     ));
//   }
// }
