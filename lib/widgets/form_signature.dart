import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:signature/signature.dart';

class FormSignature extends StatefulWidget {
  final Function(Uint8List?) onChangedSignaturePngData;
  const FormSignature({
    super.key,
    required this.onChangedSignaturePngData,
  });

  @override
  State<FormSignature> createState() => _FormSignatureState();
}

class _FormSignatureState extends State<FormSignature>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  Uint8List? signatureData;
  String? signatureBase64;
  Uint8List? signatureDataRaw;

  signatureEncode() {
    // Convert Uint8List to Base64 String
    if (signatureData == null) {
      signatureBase64 = null;
      debugPrint("- signature empty -");
    } else {
      signatureBase64 = base64Encode(signatureData!);
      debugPrint(signatureBase64);
      debugPrint("- converted to Base64 String -");
    }
  }

  signatureDecode() {
    // Convert Base64 string back to Uint8List
    signatureDataRaw = Uint8List.fromList(base64Decode(signatureBase64!));
  }

  late SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: CFGColor.black,
    exportBackgroundColor: Colors.transparent,
    onDrawEnd: () {
      // debugPrint("==================");
      saveSignatureData();
    },
  );

  saveSignatureData() async {
    //Signature Data to Uint8List
    signatureData = await signatureController.toPngBytes();
    widget.onChangedSignaturePngData(signatureData);
    //Signature Data to Base64 String
    // signatureEncode();
    debugPrint("--------signature saved--------");

    setState(() {});
  }

  clearSignatureData() async {
    signatureController.clear();
    signatureData = await signatureController.toPngBytes();
    widget.onChangedSignaturePngData(signatureData);
    // signatureEncode();
    debugPrint("--------signature cleared--------");

    setState(() {});
  }

  @override
  void dispose() {
    // Access the saved reference to the ancestor widget safely in dispose()
    // You can now use _ancestor to perform any necessary cleanup or access its properties.
    // Clean up resources, close controllers, cancel subscriptions, etc. Example :- controller.dispose();

    signatureController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Divider(color: CFGColor.lightGrey, height: 0),

          const SB(height: 10),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text("Please sign here",
                  style: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.regularFontWeight,
                    color: CFGFont.defaultFontColor,
                  )),

              //Clear Button
              TextButton(
                style: ButtonStyle(
                  fixedSize: const WidgetStatePropertyAll(Size(100, 38)),
                  minimumSize: const WidgetStatePropertyAll(Size(100, 38)),
                  backgroundColor: WidgetStatePropertyAll(CFGColor.darkGrey),
                  overlayColor:
                      WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(CFGTheme.buttonRadius))),
                ),
                onPressed: () {
                  clearSignatureData();
                },
                child: Text("Clear",
                    style: TextStyle(
                      height: 0,
                      letterSpacing: 0.5,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.whiteFontColor,
                    )),
              ),
            ],
          ),

          Container(
            margin: const EdgeInsets.only(top: 10),
            width: mediaQuerySize.width,
            height: mediaQuerySize.width * 0.45,
            decoration: BoxDecoration(
                color: CFGColor.lightGrey,
                borderRadius: BorderRadius.circular(CFGTheme.cardRadius)),
            child: Signature(
              controller: signatureController,
              width: mediaQuerySize.width - (CFGTheme.bodyLRPadding * 2),
              height: mediaQuerySize.width * 0.45,
              backgroundColor: Colors.transparent,
            ),
          ),

          // if (signatureData != null)
          //   SB(
          //     width: mediaQuerySize.width,
          //     child: Image.memory(signatureData!),
          //   ),
        ],
      ),
    );
  }
}
