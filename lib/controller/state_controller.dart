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

  //Dropdown Lists

  List<Map<int, String>> clientList = [];
  List<Map<int, String>> farmList = [];
  List<Map<int, String>> cropList = [];
  // List<Map<int, String>> varietyList = [];  //Moved inside individual forms
  List<Map<int, String>> equipmentNameList = [];
  List<Map<int, String>> assetTypeList = [];
  List<Map<int, String>> equipmentManufacturerNameList = [];
  List<Map<int, String>> workerList = [];

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
