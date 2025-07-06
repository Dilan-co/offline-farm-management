import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:farm_management/configs/font.dart';

void snackBar({
  required String msg,
  required bool isPass,
  int duration = 2000,
}) {
  Get.snackbar(
    "",
    "",
    messageText: Center(
      child: Text(
        msg,
        style: TextStyle(
          fontSize: CFGFont.smallTitleFontSize,
          fontWeight: CFGFont.mediumFontWeight,
          color: isPass ? CFGFont.defaultFontColor : CFGFont.redFontColor,
        ),
      ),
    ),
    barBlur: 10,
    colorText: CFGFont.defaultFontColor,
    snackPosition: SnackPosition.TOP,
    duration: Duration(milliseconds: duration),
  );
}
