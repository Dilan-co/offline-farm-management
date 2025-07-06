import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:path_provider/path_provider.dart';

final StateController stateController = Get.find();

Future<void> localStoragePath() async {
  //Only for Android
  if (Platform.isAndroid) {
    final externalStorageDir = await getExternalStorageDirectory();
    await stateController.setExternalStoragePath(externalStorageDir!.path);
    createExternalStorageFolder();

    // final internalDownloadDir = Directory("/storage/emulated/0/Download");
    // await stateController.setInternalDownloadPath(internalDownloadDir.path);
    // createImageSaveSubFolder();
  }
  //For both IOS and Android
  final appDocumentsDir = await getApplicationDocumentsDirectory();
  await stateController.setDocumentsDirectoryPath(appDocumentsDir.path);

  createSignatureFolder();
}

Future<void> createExternalStorageFolder() async {
  try {
    // Get the application documents directory
    String externalStorageDir = await stateController.getExternalStoragePath();

    // Create a reference to the new folder
    Directory newFolder = Directory(externalStorageDir);

    // Check if the folder already exists
    if (!(await newFolder.exists())) {
      // Create the folder if it doesn't exist
      await newFolder.create(recursive: true);
      debugPrint("Folder created: ${newFolder.path}");
    } else {
      debugPrint("Folder already exists: ${newFolder.path}");
    }
  } catch (e) {
    debugPrint("Error creating folder: $e");
  }
}

Future<void> createSignatureFolder() async {
  try {
    // Get the application documents directory
    String appDocDir = await stateController.getDocumentsDirectoryPath();

    // Create a reference to the new folder
    Directory newFolder =
        Directory('$appDocDir/${CFGString().signatureSubfolderName}');

    // Check if the folder already exists
    if (!(await newFolder.exists())) {
      // Create the folder if it doesn't exist
      await newFolder.create(recursive: true);
      debugPrint("Folder created: ${newFolder.path}");
    } else {
      debugPrint("Folder already exists: ${newFolder.path}");
    }
  } catch (e) {
    debugPrint("Error creating folder: $e");
  }
}

Future<void> createImageSaveSubFolder() async {
  try {
    // Get the downloads directory
    String downloadDir = await stateController.getInternalDownloadPath();

    // Create a reference to the new folder
    Directory newFolder = Directory(downloadDir);

    // Check if the folder already exists
    if (!(await newFolder.exists())) {
      // Create the folder if it doesn't exist
      await newFolder.create(recursive: true);
      debugPrint("Folder created: ${newFolder.path}");
    } else {
      debugPrint("Folder already exists: ${newFolder.path}");
    }
  } catch (e) {
    debugPrint("Error creating folder: $e");
  }
}
