import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/simple_forms_show_image_dialog.dart';
import 'package:farm_management/widgets/sized_box.dart';

class FormViewTextRow extends StatelessWidget {
  final String label;
  final dynamic data;
  final bool isImage;
  final List<String?> imageFileNames;
  final String? imageFileName;
  final bool extendTextHeight;
  final bool isFormView;
  final bool dataInRed;
  final bool dataBold;
  final int? maxLines;
  const FormViewTextRow({
    super.key,
    required this.label,
    required this.data,
    this.isImage = false,
    this.imageFileNames = const [],
    this.imageFileName,
    this.extendTextHeight = true,
    this.isFormView = true,
    this.dataInRed = false,
    this.dataBold = false,
    this.maxLines,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

          // Visibility(
          //   visible: isImage,
          //   child: Text(data.toString(),
          //       style: TextStyle(
          //         height: 2.2,
          //         fontSize: CFGFont.defaultFontSize,
          //         fontWeight: CFGFont.lightFontWeight,
          //         color: CFGFont.defaultFontColor,
          //       )),
          // ),

          Visibility(
            visible: isImage,
            replacement: Flexible(
              child: Text(data == null ? "" : data.toString(),
                  maxLines: maxLines,
                  style: TextStyle(
                    overflow: maxLines != null ? TextOverflow.ellipsis : null,
                    // height: extendTextHeight ? 2.2 : null,
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: dataBold
                        ? CFGFont.mediumFontWeight
                        : CFGFont.lightFontWeight,
                    color: dataInRed
                        ? CFGFont.redFontColor
                        : CFGFont.defaultFontColor,
                  )),
            ),
            child: Expanded(
                child: Column(
              children: [
                // Use a for loop to create Text widgets from the data list
                if (imageFileNames.isNotEmpty) ...[
                  for (var item in imageFileNames) ...{
                    GestureDetector(
                      child: Container(
                        color: CFGTheme.bgColorScreen,
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                item == null ? "" : item.toString(),
                                style: TextStyle(
                                  fontSize: CFGFont.defaultFontSize,
                                  fontWeight: CFGFont.lightFontWeight,
                                  color: CFGFont.blueFontColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: CFGFont.blueFontColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.download_rounded,
                                size: 18,
                                color: CFGColor.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Open Image
                        if (item != null && item != "") {
                          showImageDialog(context, item);
                        }
                      },
                    ),
                  },
                ] else if (imageFileName != null && imageFileName != "") ...[
                  GestureDetector(
                    child: Container(
                      color: CFGTheme.bgColorScreen,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              imageFileName.toString(),
                              style: TextStyle(
                                fontSize: CFGFont.defaultFontSize,
                                fontWeight: CFGFont.lightFontWeight,
                                color: CFGFont.blueFontColor,
                                decoration: TextDecoration.underline,
                                decorationColor: CFGFont.blueFontColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.download_rounded,
                              size: 18,
                              color: CFGColor.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Open Image
                      if (imageFileName != null) {
                        showImageDialog(context, imageFileName);
                      }
                    },
                  ), // Optional fallback message
                ] else ...[
                  Row(
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.lightFontWeight,
                          color: CFGFont.blueFontColor,
                          decoration: TextDecoration.underline,
                          decorationColor: CFGFont.blueFontColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            )),
          ),
        ],
      ),
    );
  }
}
