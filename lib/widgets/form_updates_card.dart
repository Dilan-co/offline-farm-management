import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/widgets/sized_box.dart';

class FormUpdatesCard extends StatelessWidget {
  final String formType;
  final String formName;
  final String lastModifiedDate;
  const FormUpdatesCard({
    super.key,
    required this.formType,
    required this.formName,
    required this.lastModifiedDate,
  });

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 5),
      width: mediaQuerySize.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: CFGColor.darkGrey),
        borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
        color: CFGTheme.bgColorScreen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formType,
              style: TextStyle(
                fontSize: CFGFont.smallTitleFontSize,
                fontWeight: CFGFont.mediumFontWeight,
                color: CFGFont.defaultFontColor,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: Text(formName,
                style: TextStyle(
                  fontSize: CFGFont.smallTitleFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: "Last Modified",
                  style: TextStyle(
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.regularFontWeight,
                    color: CFGFont.defaultFontColor,
                  )),
              //
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(":",
                      style: TextStyle(
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                ),
              ),

              TextSpan(
                  text: lastModifiedDate.toString(),
                  style: TextStyle(
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.lightFontWeight,
                    color: CFGFont.defaultFontColor,
                  )),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SB(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                        shape: const WidgetStatePropertyAll(CircleBorder())),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      CFGImage.view,
                      colorFilter:
                          ColorFilter.mode(CFGTheme.button, BlendMode.srcIn),
                      // color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),

                //
                const SB(width: 5),

                SB(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                        shape: const WidgetStatePropertyAll(CircleBorder())),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      CFGImage.edit,
                      colorFilter:
                          ColorFilter.mode(CFGTheme.button, BlendMode.srcIn),
                      // color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),

                //
                const SB(width: 5),

                SB(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                        shape: const WidgetStatePropertyAll(CircleBorder())),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      CFGImage.delete,
                      colorFilter:
                          ColorFilter.mode(CFGTheme.button, BlendMode.srcIn),
                      // color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
