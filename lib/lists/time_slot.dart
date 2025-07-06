import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/controller/state_controller.dart';

class TimeSlotList {
  final StateController stateController = Get.find();

  void generateTimeSlots() async {
    fifteenMinutes();
    hourly();
    boxSlotsHourly();
  }

  void fifteenMinutes() {
    stateController.timeSlotsFifteenMinutes.clear();
    for (var h = 6, m = 0;
        h <= 17 && (h < 17 || (h == 17 && m <= 15));
        m == 45 ? h++ : h, m == 45 ? m = 0 : m += 15) {
      stateController.timeSlotsFifteenMinutes.add(
          "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}-${m == 45 ? (h + 1).toString().padLeft(2, '0') : h.toString().padLeft(2, '0')}:${m == 45 ? 0.toString().padLeft(2, '0') : (m + 15).toString().padLeft(2, '0')}");
      // debugPrint(
      //     "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}-${m == 45 ? (h + 1).toString().padLeft(2, '0') : h.toString().padLeft(2, '0')}:${m == 45 ? 0.toString().padLeft(2, '0') : (m + 15).toString().padLeft(2, '0')}");
    }
    debugPrint(
        "timeSlotsFifteenMinutes ${stateController.timeSlotsFifteenMinutes}");
  }

  void hourly() {
    stateController.timeSlotsHourly.clear();
    for (var h = 6; h < 17; h++) {
      stateController.timeSlotsHourly.add(
          "${h.toString().padLeft(2, '0')}:00-${(h + 1).toString().padLeft(2, '0')}:00");
      // debugPrint(
      //     "${h.toString().padLeft(2, '0')}:00-${(h + 1).toString().padLeft(2, '0')}:00");
    }
    debugPrint("timeSlotsHourly ${stateController.timeSlotsHourly}");
  }

  void boxSlotsHourly() {
    stateController.boxTimeSlotsHourly.clear();
    for (var h = 7; h < 13; h++) {
      stateController.boxTimeSlotsHourly.add(
          "${h.toString().padLeft(2, '0')}:00-${(h + 1).toString().padLeft(2, '0')}:00");
      // debugPrint(
      //     "${h.toString().padLeft(2, '0')}:00-${(h + 1).toString().padLeft(2, '0')}:00");
    }
    debugPrint("boxTimeSlotsHourly ${stateController.boxTimeSlotsHourly}");
  }

  // "06:00-06:15",
  // "06:15-06:30",
  // "06:30-06:45",
  // "06:45-07:00",
  // "07:00-07:15",
  // "07:15-07:30",
  // "07:30-07:45",
  // "07:45-08:00",
  // "08:00-08:15",
  // "08:15-08:30",
  // "08:30-08:45",
  // "08:45-09:00",
  // "09:00-09:15",
  // "09:15-09:30",
  // "09:30-09:45",
  // "09:45-10:00",
  // "10:00-10:15",
  // "10:15-10:30",
  // "10:30-10:45",
  // "10:45-11:00",
  // "11:00-11:15",
  // "11:15-11:30",
  // "11:30-11:45",
  // "11:45-12:00",
  // "12:00-12:15",
  // "12:15-12:30",
  // "12:30-12:45",
  // "12:45-13:00",
  // "13:00-13:15",
  // "13:15-13:30",
  // "13:30-13:45",
  // "13:45-14:00",
  // "14:00-14:15",
  // "14:15-14:30",
  // "14:30-14:45",
  // "14:45-15:00",
  // "15:00-15:15",
  // "15:15-15:30",
  // "15:30-15:45",
  // "15:45-16:00",
  // "16:00-16:15",
  // "16:15-16:30",
  // "16:30-16:45",
  // "16:45-17:00",
  // "17:00-17:15",
  // "17:15-17:30",

  // "06:00-07:00",
  // "07:00-08:00",
  // "08:00-09:00",
  // "09:00-10:00",
  // "10:00-11:00",
  // "11:00-12:00",
  // "12:00-13:00",
  // "13:00-14:00",
  // "14:00-15:00",
  // "15:00-16:00",
  // "16:00-17:00",

  // "07:00-08:00",
  // "08:00-09:00",
  // "09:00-10:00",
  // "10:00-11:00",
  // "11:00-12:00",
  // "12:00-13:00",
}
