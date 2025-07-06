import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<bool> checkNetworkConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    // Connected to mobile network
    debugPrint("Connected to Mobile Network");
    return true;
  } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    // Connected to Wi-Fi
    debugPrint("Connected to Wi-Fi");
    return true;
  } else {
    // No network connection
    debugPrint("No Internet Connection");
    return false;
  }
}
