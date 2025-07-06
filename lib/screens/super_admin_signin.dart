import 'package:farm_management/screens/simple_forms_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/database/tables/user/user.dart';
import 'package:farm_management/models/table_models/user/user_model.dart';
import 'package:farm_management/services/api_data_service.dart';
import 'package:farm_management/services/check_connectivity.dart';
import 'package:farm_management/services/super_admin_api_service.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/snackbar.dart';
import 'package:farm_management/widgets/username_password_card.dart';

class SuperAdminSignIn extends StatefulWidget {
  final bool isSyncOut;
  const SuperAdminSignIn({
    super.key,
    this.isSyncOut = false,
  });

  @override
  State<SuperAdminSignIn> createState() => _SuperAdminSignInState();
}

class _SuperAdminSignInState extends State<SuperAdminSignIn> {
  final StateController stateController = Get.find();
  GetStorage storage = GetStorage();

  bool isLoginFailed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      debugPrint("4 seconds");
      setState(() {
        isLoginFailed = false;
        debugPrint("$isLoginFailed");
      });
    });
  }

  String? username;
  String? pin;

  onChangedUsername(String? output) {
    setState(() {
      username = output;
    });
    debugPrint("$output");
  }

  onChangedPin(String? output) {
    setState(() {
      pin = output;
    });
    debugPrint("$output");
  }

  //Authenticate SignIn
  Future<bool> signInAuthentication() async {
    //------------ Uncomment after API Integration ------------
    // // Use SignIn Authentication
    // bool isSuccess = await SuperAdminApiService()
    //     .superAdminLogin(username: username ?? "", pin: pin ?? "");
    //------------------------------------------------------

    //------------ Remove after API Integration ------------
    late bool isSuccess;
    await Future.delayed(const Duration(milliseconds: 1000), () {
      //
      isSuccess = true;
    });
    //------------------------------------------------------

    isSuccess
        ? snackBar(msg: "Supervisor Signin Successful.", isPass: true)
        : snackBar(
            msg: "Supervisor Signin Failed. Try Again...", isPass: false);

    return isSuccess;
  }

  onSignIn() async {
    //Check internet status
    bool haveInternet = await checkNetworkConnectivity();

    if (haveInternet) {
      bool isSignedIn = await signInAuthentication();

      if (isSignedIn == true) {
        // Show sync progress dialog
        showSyncDialog();

        // Perform sync operations
        bool sync = await performSyncOperation();

        // Dismiss the dialog & previous snackbar
        Get.close(1);

        // Show the completion Snackbar after navigation
        Future.delayed(const Duration(milliseconds: 300), () {
          sync
              ? snackBar(
                  msg: widget.isSyncOut
                      ? "Forms Sync Successful."
                      : "Master Data Sync Successful.",
                  isPass: true)
              : snackBar(msg: "Sync Failed. Try Again...", isPass: false);
        });

        sync ? Get.to(() => const SimpleFormsMenu()) : {};
      } else {
        // Handle login failure
        setState(() {
          isLoginFailed = true;
        });
        startTimer();
      }
    } else {
      //Show "No Internet"
      snackBar(
          msg: "No Internet. Connect to Wi-Fi or Mobile network.",
          isPass: false);
    }
  }

  void showSyncDialog() {
    Get.dialog(
      barrierDismissible: false,
      Stack(
        children: [
          //
          Opacity(
            opacity: 0.4,
            child: ModalBarrier(
              dismissible: false,
              color: CFGColor.black,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sync in progress...",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: CFGFont.regularFontWeight,
                  fontSize: CFGFont.subTitleFontSize,
                  color: CFGFont.whiteFontColor,
                ),
              ),
              //
              const SB(height: 24),

              Center(
                child: SB(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    color: CFGTheme.circularProgressIndicator,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> performSyncOperation() async {
    bool sync = false;
    try {
      //------------ Uncomment after API Integration ------------
      // if (widget.isSyncOut) {
      //   // Add Sync API Data to Backend
      //   sync = await ApiDataService().syncPushApiData();
      // } else {
      //   // Add Sync API Data from Backend
      //   sync = await ApiDataService().superAdminLoginFetchApiData();
      // }
      //------------------------------------------------------

      //------------ Remove after API Integration ------------
      await Future.delayed(const Duration(milliseconds: 2000), () {
        //
        sync = true;
        username = "admin";
      });
      //------------------------------------------------------

      // Get User record from DB
      UserModel? user = await User().fetchByUsername(userName: username!);

      //Setting User Name & User Type
      if (user != null) {
        stateController.setLoggedUserId(user.userId!);
        stateController.setLoggedUserName(user.displayName);
        stateController.setLoggedUserType(user.userType);
      }
      return sync;
    } catch (e, stackTrace) {
      debugPrint("Error occurred while syncing data: $e");
      debugPrint("StackTrace: $stackTrace");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: CFGTheme.bgColorScreen,
      body: Padding(
          padding: EdgeInsets.only(
            left: CFGTheme.bodyLRPadding,
            right: CFGTheme.bodyLRPadding,
            // top: CFGTheme.bodyTBPadding,
            bottom: CFGTheme.bodyTBPadding,
          ),
          child: OrientationBuilder(builder: (cont, orientation) {
            return SingleChildScrollView(
              physics: orientation == Orientation.portrait
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              child: SB(
                height: orientation == Orientation.portrait
                    ? mediaQuerySize.height
                    : null,
                child: Column(
                  children: [
                    //
                    orientation == Orientation.portrait
                        ? const Spacer(flex: 1)
                        : const SB(height: 5),

                    Container(
                      height: mediaQuerySize.height * 0.25,
                      width: mediaQuerySize.height * 0.25,
                      constraints:
                          const BoxConstraints(minHeight: 50, minWidth: 50),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: CFGTheme.bgColorScreen
                          // border: Border.all(
                          //   color: Colors.transparent,
                          //   width: 1,
                          // ),
                          ),
                      child: const ClipOval(
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage(CFGImage.logoBlackText),
                        ),
                        // child: Image.network(
                        //   'https://oflutter.com/wp-content/uploads/2024/02/girl-profile.png',
                        //   fit: BoxFit.contain,
                      ),
                    ),

                    SB(height: mediaQuerySize.height * 0.02),

                    Text(CFGString().farmName,
                        style: TextStyle(
                          fontSize: CFGFont.subTitleFontSize,
                          fontWeight: CFGFont.mediumFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),

                    const SB(height: 4),

                    Text(CFGString().farmLocation,
                        style: TextStyle(
                          fontSize: CFGFont.defaultFontSize,
                          fontWeight: CFGFont.regularFontWeight,
                          color: CFGFont.defaultFontColor,
                        )),

                    SB(height: mediaQuerySize.height * 0.02),

                    UsernamePasswordCard(
                      title: "Supervisor Username",
                      label: "type username here",
                      obscureTextIconIsVisible: false,
                      initialTextFieldData: username,
                      onChangedTextField: onChangedUsername,
                    ),

                    //
                    UsernamePasswordCard(
                      title: "PIN",
                      label: "type PIN here",
                      obscureTextIconIsVisible: true,
                      isPinNumber: false,
                      onChangedTextField: onChangedPin,
                    ),

                    const SB(height: 25),

                    TextButton(
                      style: ButtonStyle(
                        fixedSize: const WidgetStatePropertyAll(Size(150, 44)),
                        backgroundColor: WidgetStatePropertyAll(
                            isLoginFailed ? CFGTheme.fail : CFGTheme.button),
                        overlayColor:
                            WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(CFGTheme.buttonRadius))),
                        // padding: const WidgetStatePropertyAll(
                        //     EdgeInsets.only(left: 40, right: 40)),
                      ),
                      onPressed: () async {
                        await onSignIn();
                      },
                      child: Text(isLoginFailed ? "Sign in Failed" : "Sign in",
                          style: TextStyle(
                            height: 0,
                            fontSize: CFGFont.subTitleFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.whiteFontColor,
                          )),
                    ),

                    // const SB(height: 15),

                    //Login Failed Error Message
                    // Visibility(
                    //   visible: isLoginFailed,
                    //   child: Text("Login Failed",
                    //       style: TextStyle(
                    //         fontSize: CFGFont.subTitleFontSize,
                    //         fontWeight: CFGFont.regularFontWeight,
                    //         color: CFGFont.redFontColor,
                    //       )),
                    // ),

                    //Move Textfield up when keyboard appears
                    orientation == Orientation.portrait
                        ? SB(height: MediaQuery.of(context).viewInsets.bottom)
                        : const SB(),

                    orientation == Orientation.portrait
                        ? (MediaQuery.of(context).viewInsets.bottom == 0
                            ? const Spacer(flex: 10)
                            : const Spacer(flex: 1))
                        : const SB(height: 20),
                  ],
                ),
              ),
            );
          })),
    ));
  }
}
