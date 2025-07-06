import 'package:flutter/material.dart';

import 'package:farm_management/configs/color.dart';

class CFGTheme {
  static Color logoColorsGreen = CFGColor.greenL;
  static Color logoColorsOrange = CFGColor.orangeL;
  static Color logoColorsRed = CFGColor.redL;
  static Color bgColorScreen = CFGColor.white;
  static Color button = CFGColor.greyBlack;
  static Color buttonOverlay = CFGColor.midDarkGrey; //On Press
  static Color appBarButtonImg = CFGColor.white;
  static Color buttonLightGrey = CFGColor.bLightGrey;
  static Color circularProgressIndicator = CFGColor.white;
  static Color pass = CFGColor.green;
  static Color alert = CFGColor.yellow;
  static Color fail = CFGColor.red;

  static double bodyLRPadding = 25;
  static double bodyTBPadding = 10;
  static double buttonRadius = 8;
  static double cardRadius = 10;

  void init(BuildContext context) {
    bodyLRPadding = MediaQuery.of(context).size.width * 0.07;
    debugPrint('bodyLRPadding: $bodyLRPadding');
  }
}
