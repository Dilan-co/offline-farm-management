import 'package:flutter/material.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/sized_box.dart';

class FormViewResultRow extends StatelessWidget {
  final String label;
  final String result;
  final bool extendTextHeight;
  final bool isFormView;
  const FormViewResultRow({
    super.key,
    required this.label,
    required this.result,
    this.extendTextHeight = true,
    this.isFormView = true,
  });

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: extendTextHeight ? 5 : 0,
        bottom: extendTextHeight ? 5 : 0,
      ),
      child: Row(
        children: [
          //
          SB(
            width: isFormView
                ? mediaQuerySize.width * 0.32
                : mediaQuerySize.width * 0.2,
            child: Text(label,
                style: TextStyle(
                  // height: extendTextHeight ? 2.2 : null,
                  fontSize: CFGFont.defaultFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(":",
                style: TextStyle(
                  // height: extendTextHeight ? 2.2 : null,
                  fontSize: CFGFont.defaultFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
          ),

          Container(
            height: 44,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: result == "PASS"
                  ? CFGTheme.pass
                  : result == "ALERT"
                      ? CFGTheme.alert
                      : CFGTheme.fail,
            ),
            child: Center(
              child: Text(result.toString(),
                  style: TextStyle(
                    height: 0,
                    fontSize: CFGFont.smallTitleFontSize,
                    fontWeight: CFGFont.regularFontWeight,
                    color: CFGFont.whiteFontColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
