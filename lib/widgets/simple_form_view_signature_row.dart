import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/widgets/sized_box.dart';

class FormViewSignatureRow extends StatelessWidget {
  final String label;
  final String? signatureFileName;
  const FormViewSignatureRow({
    super.key,
    required this.label,
    required this.signatureFileName,
  });

  @override
  Widget build(BuildContext context) {
    final StateController stateController = Get.find();
    Size mediaQuerySize = MediaQuery.of(context).size;

    String signatureSubfolderPath =
        '${stateController.getDocumentsDirectoryPath()}/${CFGString().signatureSubfolderName}';

    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          SB(
            width: mediaQuerySize.width * 0.32,
            child: Text(label,
                style: TextStyle(
                  height: 2,
                  fontSize: CFGFont.defaultFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(":",
                style: TextStyle(
                  height: 2,
                  fontSize: CFGFont.defaultFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
          ),

          Flexible(
            child: Container(
              width: double.infinity,
              height: mediaQuerySize.width * 0.2,
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 170),
              decoration: BoxDecoration(
                color: CFGColor.lightGrey,
                borderRadius:
                    BorderRadius.all(Radius.circular(CFGTheme.buttonRadius)),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: signatureFileName != null
                    ?
                    // Text("$signatureSubfolderPath/$signatureFileName")
                    Image.file(
                        File("$signatureSubfolderPath/$signatureFileName"),
                        fit: BoxFit.contain,
                      )
                    : const SB(),
              )),
            ),
          ),

          // Text(data.toString(),
          //     style: TextStyle(
          //       height: 2,
          //       fontSize: CFGFont.defaultFontSize,
          //       fontWeight: CFGFont.lightFontWeight,
          //       color: CFGFont.defaultFontColor,
          //     )),
        ],
      ),
    );
  }
}
