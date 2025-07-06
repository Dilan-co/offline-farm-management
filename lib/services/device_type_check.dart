import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:farm_management/controller/state_controller.dart';

final StateController stateController = Get.find();

class DeviceTypeCheck {
  Future<bool> isTablet(BuildContext context) async {
    var size = MediaQuery.of(context).size;
    var diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));
    debugPrint("Device Size = $diagonal");

    // A common diagonal threshold for determining if it's a tablet (in inches)
    return diagonal > 1100.0; // Adjust this value based on your needs
  }

  checkDeviceType(BuildContext context) async {
    bool logic = await isTablet(context);
    if (logic) {
      stateController.setDeviceAppBarMultiplier(1.3);
    } else {
      stateController.setDeviceAppBarMultiplier(1.0);
    }
  }
}
