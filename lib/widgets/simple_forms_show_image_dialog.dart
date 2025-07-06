import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/widgets/snackbar.dart';

void showImageDialog(BuildContext context, String? imageFileName) {
  final StateController stateController = Get.find();

  // final Dio dio = Dio();
  // //
  // Future<bool> saveImage(String url, String fileName) async {
  //   Directory directory;
  //   try {
  //     if (Platform.isAndroid) {
  //       if (await requestPermission(Permission.storage)) {
  //         //
  //         directory = stateController.getDocumentsDirectoryPath();

  //         String newPath = "";

  //         // debugPrint("$directory");

  //         List<String> paths = directory.path.split("/");
  //         for (int x = 1; x < paths.length; x++) {
  //           String folder = paths[x];
  //           if (folder != "Android") {
  //             newPath += "/$folder";
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = "$newPath/FarmManagement";
  //         directory = Directory(newPath);

  //         // debugPrint("$directory");
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       if (await requestPermission(Permission.photos)) {
  //         directory = await getTemporaryDirectory();
  //       } else {
  //         return false;
  //       }
  //     }
  //     File saveFile = File("${directory.path}/$fileName");
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       await dio.download(url, saveFile.path,
  //           onReceiveProgress: (value1, value2) {});
  //       if (Platform.isIOS) {
  //         await ImageGallerySaver.saveFile(saveFile.path,
  //             isReturnPathOfIOS: true);
  //       }
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     // debugPrint("$e");
  //     return false;
  //   }
  // }

  Future<void> saveImageToGallery() async {
    if (imageFileName != null && imageFileName != "") {
      String filePath =
          "${stateController.getDocumentsDirectoryPath()}/$imageFileName";

      // String relativePath = "${stateController.getInternalDownloadPath()}";
      try {
        // Create a File object with the given path
        final file = File(filePath);

        // Check if the file exists
        if (await file.exists()) {
          // Read the file as bytes and save to gallery
          // final result = await SaverGallery.saveImage(
          //   file.readAsBytesSync(),
          //   fileName: imageFileName,
          //   androidRelativePath: relativePath,
          //   skipIfExists: false,
          // );
          final result = await ImageGallerySaverPlus.saveFile(
            filePath,
            name: imageFileName,
          );

          Get.back();

          snackBar(msg: "Image Saved to Gallery", isPass: true);

          debugPrint("Image Saved to Gallery: $imageFileName");
        } else {
          snackBar(msg: "Image Save Failed. Try Again...", isPass: false);
        }
      } catch (e) {
        debugPrint("Error converting image to bytes: $e");
        null;
      }
    } else {
      snackBar(msg: "Image Not Found", isPass: false);
    }
  }

  showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      Size mediaQuerySize = MediaQuery.of(context).size;

      return AlertDialog(
        surfaceTintColor: CFGTheme.bgColorScreen,
        backgroundColor: CFGTheme.bgColorScreen,
        insetPadding: EdgeInsets.only(
          left: CFGTheme.bodyLRPadding,
          right: CFGTheme.bodyLRPadding,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            Flexible(
              child: Text(imageFileName ?? "Image Preview",
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: CFGFont.smallTitleFontSize,
                    fontWeight: CFGFont.mediumFontWeight,
                    color: CFGFont.defaultFontColor,
                  )),
            ),

            //
            Builder(builder: (context) {
              return IconButton.filled(
                  style: ButtonStyle(
                    overlayColor:
                        WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                    backgroundColor: WidgetStatePropertyAll(CFGTheme.button),
                    // iconColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: CFGTheme.appBarButtonImg,
                    size: 24,
                  ));
            }),
          ],
        ),
        content: Container(
          color: CFGTheme.bgColorScreen,
          width: mediaQuerySize.width,
          height: mediaQuerySize.height * 0.55,

          //enable this when DB completed to load file from DB
          child: Image.file(File(
              "${stateController.getDocumentsDirectoryPath()}/$imageFileName")),

          //delete this when DB completed
          // child: Image.asset('images/penergetic_inc_logo.png'),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          //Download Button
          TextButton(
            style: ButtonStyle(
              fixedSize: const WidgetStatePropertyAll(Size(130, 44)),
              backgroundColor: WidgetStatePropertyAll(CFGTheme.button),
              overlayColor: WidgetStatePropertyAll(CFGTheme.buttonOverlay),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(CFGTheme.buttonRadius))),
            ),
            onPressed: () async {
              saveImageToGallery();

              //download & save file
              // await saveImage("imageFile", basename(imageFile.path));
            },
            child: Text("Download",
                style: TextStyle(
                  height: 0,
                  fontSize: CFGFont.subTitleFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.whiteFontColor,
                )),
          ),
        ],
      );
    },
  );
}
