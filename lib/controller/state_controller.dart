import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class StateController extends GetxController {
  Database? _database;
  RxString externalStoragePath = "".obs;
  RxString internalDownloadsPath = "".obs;
  RxString documentsDirectoryPath = "".obs;
  RxString selectedSimpleFormName = "".obs;
  Future<bool>? loadingFuture;
  Rx<UniqueKey> uniqueKey = UniqueKey().obs;
  //Mobile or Tablet Size
  RxDouble deviceAppBarMultiplier = 1.0.obs;
  //Logged In User ID
  RxInt loggedUserId = 0.obs;
  RxString loggedUserName = "".obs;
  RxString loggedUserType = "".obs;

  //Access Token
  RxString accessToken = "".obs;
  //Base Url for API
  String baseUrl = "http://54.210.55.65/api";

  //Time Slot Lists
  List<String> timeSlotsFifteenMinutes = [];
  List<String> timeSlotsHourly = [];
  List<String> boxTimeSlotsHourly = [];

  //Raw Lists
  // List<OrgClientFarmModel> rawFarmList = [];
  // List<change list model> rawCropList = [];

  //-------------------- Remove after API Integration --------------------

  List<Map<int, String>> clientList = [
    {0: 'Test Client 1'},
  ];
  List<Map<int, String>> farmList = [
    {0: 'Test Farm 1'},
    {1: 'Test Farm 2'},
    {2: 'Test Farm 3'},
    {3: 'Test Farm 4'},
  ];
  List<Map<int, String>> cropList = [
    {19: 'Test Crop 1'},
    {20: 'Test Crop 2'},
    {21: 'Test Crop 3'},
  ];
  List<Map<int, String>> equipmentNameList = [
    {0: 'Test Equipment 1'},
    {1: 'Test Equipment 2'},
    {2: 'Test Equipment 3'},
    {3: 'Test Equipment 4'},
    {4: 'Test Equipment 5'},
  ];
  List<Map<int, String>> assetTypeList = [
    {0: 'Test Asset Type 1'},
    {1: 'Test Asset Type 2'},
    {2: 'Test Asset Type 3'},
    {3: 'Test Asset Type 4'},
  ];
  List<Map<int, String>> equipmentManufacturerNameList = [
    {0: 'Test Equipment Manufacturer 1'},
    {1: 'Test Equipment Manufacturer 2'},
    {2: 'Test Equipment Manufacturer 3'},
    {3: 'Test Equipment Manufacturer 4'},
    {4: 'Test Equipment Manufacturer 5'},
  ];
  List<Map<int, String>> workerList = [
    {6: 'Bron Pressler'},
    {7: 'Rayan Niel'},
  ];

  //----------------------------------------------------------------------

  //Dropdown Lists

  //-------------------- Uncomment after API Integration --------------------

  // List<Map<int, String>> clientList = [];
  // List<Map<int, String>> farmList = [];
  // List<Map<int, String>> cropList = [];
  // // List<Map<int, String>> varietyList = [];  //Moved inside individual forms
  // List<Map<int, String>> equipmentNameList = [];
  // List<Map<int, String>> assetTypeList = [];
  // List<Map<int, String>> equipmentManufacturerNameList = [];
  // List<Map<int, String>> workerList = [];

  //----------------------------------------------------------------------

  List<Map<int, String>> typeList = [
    {0: 'Prepack'},
    {1: 'Bulk'},
  ];
  List<Map<int, String>> resultList = [
    {1: 'PASS'},
    {2: 'ALERT'},
    {3: 'FAIL'},
  ];
  List<Map<int, String>> priorityList = [
    {0: 'CRITICAL'},
    {1: 'MAJOR'},
    {2: 'MINOR'},
    {3: 'LOW'},
  ];
  List<Map<int, String>> methodsOfApplicationList = [
    {0: 'Spreader'},
    {1: 'Banded'},
    {2: 'Fertigation'},
  ];

  setDatabase(Database db) {
    _database = db;
    debugPrint("=========DatabaseSet=========");
  }

  getDatabase() {
    return _database;
  }

  setExternalStoragePath(String path) {
    externalStoragePath(path);
    debugPrint(path);
  }

  getExternalStoragePath() {
    return externalStoragePath();
  }

  setInternalDownloadPath(String path) {
    internalDownloadsPath(path);
    debugPrint(path);
  }

  getInternalDownloadPath() {
    return internalDownloadsPath();
  }

  setDocumentsDirectoryPath(String path) {
    documentsDirectoryPath(path);
    debugPrint(path);
  }

  getDocumentsDirectoryPath() {
    return documentsDirectoryPath();
  }

  setLoggedUserId(int userId) {
    loggedUserId(userId);
    debugPrint("User Logged in. User ID : $userId");
  }

  getLoggedUserId() {
    return loggedUserId();
  }

  setLoggedUserName(String userName) {
    loggedUserName(userName);
    debugPrint("User Logged in. User Name : $userName");
  }

  getLoggedUserName() {
    return loggedUserName();
  }

  setLoggedUserType(String userType) {
    loggedUserType(userType);
    debugPrint("User Logged in. User Type : $userType");
  }

  getLoggedUserType() {
    return loggedUserType();
  }

  setAccessToken(String token) {
    accessToken(token);
    debugPrint(token);
  }

  getAccessToken() {
    return accessToken();
  }

  setSelectedSimpleFormName(String value) {
    selectedSimpleFormName(value);
    debugPrint("=========SelectedSimpleFormName setworks=========");
  }

  getSelectedSimpleFormName() {
    return selectedSimpleFormName();
  }

  setRebuildUI(bool value) {
    loadingFuture = Future.value(value);
    debugPrint("=========UI Rebuild=========");
  }

  getRebuildUI() {
    return loadingFuture;
  }

  setUniqueKey(UniqueKey value) {
    uniqueKey(value);
    debugPrint("=========UniqueKey Set=========");
  }

  getUniqueKey() {
    return uniqueKey();
  }

  setDeviceAppBarMultiplier(double value) {
    deviceAppBarMultiplier(value);
  }

  getDeviceAppBarMultiplier() {
    return deviceAppBarMultiplier();
  }

  void reloadData() {
    setRebuildUI(true);
    // Implement your logic to reload or update data here
    update(); // This triggers a rebuild of the UI
  }
}
