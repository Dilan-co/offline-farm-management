import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:farm_management/configs/nav_route.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/user/user.dart';
import 'package:farm_management/lists/time_slot.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';
import 'package:farm_management/screens/signin.dart';
import 'package:farm_management/screens/splash_screen.dart';
import 'package:farm_management/screens/super_admin_signin.dart';
import 'package:farm_management/services/database_service.dart';
import 'package:farm_management/services/device_type_check.dart';
import 'package:farm_management/services/local_storage_path.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initialization();
  runApp(const FarmManagement());
}

initialization() async {
  //This is where you can initialize the resources needed by your app while the splash screen is displayed.

  //Status Bar & Nav Bar colors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    statusBarColor: CFGTheme.bgColorScreen,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: CFGTheme.bgColorScreen,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  //Initialize GetX State Controller
  Get.put(StateController());
  //Initialize SQFLite Database
  await DatabaseService().database;
  //Initialize GetStorage before running the app
  await GetStorage.init();
  //Removing Splash Screen after initializing
  FlutterNativeSplash.remove();
}

class FarmManagement extends StatefulWidget {
  const FarmManagement({super.key});

  @override
  State<FarmManagement> createState() => _FarmManagementState();
}

class _FarmManagementState extends State<FarmManagement> {
  @override
  void initState() {
    super.initState();

    initialization();

    //Checking User Data Availability and Navigate
    checkIfUserDataAvailable();
  }

  // void initialization() async {
  //   //This is where you can initialize the resources needed by your app while the splash screen is displayed.

  //   //Status Bar & Nav Bar colors
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: CFGTheme.bgColorScreen,
  //     statusBarBrightness: Brightness.dark,
  //     statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarColor: CFGTheme.bgColorScreen,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ));
  //   //Initialize GetX State Controller
  //   Get.put(StateController());
  //   //Initialize SQFLite Database
  //   await DatabaseService().database;
  //   //Initialize GetStorage before running the app
  //   await GetStorage.init();
  //   //Removing Splash Screen after initializing
  //   FlutterNativeSplash.remove();
  //   //Checking User Data Availability and Navigate
  //   checkIfUserDataAvailable();
  // }

  Future<void> checkIfUserDataAvailable() async {
    List<UserModel> userData = await User().fetchAllRecords();
    debugPrint("User data length: ${userData.length}");
    if (userData.isNotEmpty) {
      Get.to(() => const SignIn());
      // Get.to(() => const SuperAdminSignIn());
    } else {
      Get.to(() => const SuperAdminSignIn());
    }
  }

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    //Device Type Check (Tablet or Mobile)
    DeviceTypeCheck().checkDeviceType(context);
    //Initializing MediaQuery for padding
    CFGTheme().init(context);
    //Generating Lists
    TimeSlotList().generateTimeSlots();
    //Getting Local Storage Path
    localStoragePath();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Oswald',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true),
      home: SplashScreen(),
      getPages: navRoute,
    );
  }
}
