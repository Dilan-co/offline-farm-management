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
import 'package:farm_management/screens/dashboard.dart';
import 'package:farm_management/screens/super_admin_signin.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/snackbar.dart';
import 'package:farm_management/widgets/username_password_card.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final StateController stateController = Get.find();
  GetStorage storage = GetStorage();

  bool isRememberMe = false;
  bool isLoginFailed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUsernameFromGetStorage();
  }

  gettingUsernameFromGetStorage() {
    String? uName = storage.read("username");
    if (uName == null) {
      debugPrint("Username not found in storage");
    } else {
      setState(() {
        username = uName;
      });
      debugPrint("Username found: $uName");
    }
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint("3 seconds");
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
    try {
      // Check if username is empty
      if (username == null || username == "") {
        snackBar(msg: "Username empty.", isPass: false);
        return false;
      }

      // Get User record from DB
      UserModel? user = await User().fetchByUsername(userName: username!);

      if (user == null) {
        // Username incorrect
        snackBar(msg: "User Name Incorrect. Try Again...", isPass: false);
        return false;
      }

      // Check if PIN code matches
      if (user.pinCode == pin) {
        // PIN is correct
        snackBar(msg: "User Signin Successful.", isPass: true);
        //Setting User ID & Name to State Controller
        stateController.setLoggedUserId(user.userId!);
        stateController.setLoggedUserName(user.displayName);
        stateController.setLoggedUserType(user.userType);
        return true;
      } else {
        // PIN incorrect
        snackBar(msg: "Pin Code Incorrect. Try Again...", isPass: false);
        return false;
      }
    } catch (e) {
      debugPrint("SignIn Error : $e");
      return false;
    }
  }

  onSignIn() async {
    bool isSignedIn = await signInAuthentication();
    if (isSignedIn == true) {
      if (isRememberMe) {
        await storage.write("username", username);
        debugPrint("Saved username to storage: $username");
      } else {
        await storage.write("username", null);
        debugPrint("Not saved username to storage");
      }
      if (stateController.getLoggedUserType() == "worker") {
        // If user is a worker, redirect to Worker Dashboard
        Get.to(() => const Dashboard());
      } else {
        // If user is a superAdmin/supervisor/qaOfficer, redirect to Simple Forms Menu
        Get.to(() => const SimpleFormsMenu());
      }
    } else if (isSignedIn == false) {
      setState(() {
        isLoginFailed = true;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        debugPrint("Pop Disabled");
      },
      child: SafeArea(
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
                            shape: BoxShape.circle,
                            color: CFGTheme.bgColorScreen
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
                        title: "Username",
                        label: "type username here",
                        obscureTextIconIsVisible: false,
                        //set the username to "initialTextFieldData" when "isRememberMe == true" users (DONE)
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

                      const SB(height: 5),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Theme(
                            data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                    fillColor: WidgetStateProperty.resolveWith(
                                        (states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return CFGTheme.button;
                                      }
                                      return null;
                                    }),
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    side:
                                        BorderSide(color: CFGColor.darkGrey))),
                            child: CheckboxMenuButton(
                              style: const ButtonStyle(
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero),
                                  iconColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                  overlayColor: WidgetStatePropertyAll(
                                      Colors.transparent)),
                              value: isRememberMe,
                              onChanged: (value) {
                                setState(() {
                                  isRememberMe = value!;
                                });
                                debugPrint("$value");
                              },
                              child: Text("Remember me",
                                  style: TextStyle(
                                    fontFamily: "Oswald",
                                    letterSpacing: 0.1,
                                    fontSize: CFGFont.defaultFontSize,
                                    fontWeight: CFGFont.regularFontWeight,
                                    color: CFGFont.defaultFontColor,
                                  )),
                            ),
                          ),

                          // SB(
                          //   width: mediaQuerySize.width * 0.4,
                          //   child: CheckboxListTile(
                          //     visualDensity: const VisualDensity(
                          //         horizontal: VisualDensity.minimumDensity,
                          //         vertical: VisualDensity.minimumDensity),
                          //     value: isChecked,
                          //     contentPadding: EdgeInsets.zero,
                          //     shape: const BeveledRectangleBorder(
                          //         borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          //     overlayColor:
                          //         const WidgetStatePropertyAll(Colors.transparent),
                          //     tileColor: CFGTheme.bgColorScreen,
                          //     dense: true,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         isChecked = value!;
                          //       });
                          //       debugPrint("$value");
                          //     },
                          //     activeColor: CFGTheme.button,
                          //     controlAffinity: ListTileControlAffinity.leading,
                          //     title: Text("Remember me",
                          //         style: TextStyle(
                          //           fontSize: CFGFont.defaultFontSize,
                          //           fontWeight: CFGFont.regularFontWeight,
                          //           color: CFGFont.defaultFontColor,
                          //         )),
                          //   ),
                          // ),

                          Text("Forgot Password?",
                              style: TextStyle(
                                letterSpacing: 0.4,
                                decoration: TextDecoration.underline,
                                decorationColor: CFGFont.blueFontColor,
                                fontSize: CFGFont.defaultFontSize,
                                fontWeight: CFGFont.regularFontWeight,
                                color: CFGFont.blueFontColor,
                              )),
                        ],
                      ),

                      const SB(height: 5),

                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(150, 44)),
                          backgroundColor: WidgetStatePropertyAll(
                              isLoginFailed ? CFGTheme.fail : CFGTheme.button),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  CFGTheme.buttonRadius))),
                          // padding: const WidgetStatePropertyAll(
                          //     EdgeInsets.only(left: 40, right: 40)),
                        ),
                        onPressed: () async {
                          await onSignIn();
                        },
                        child:
                            Text(isLoginFailed ? "Sign in Failed" : "Sign in",
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

                      SB(height: mediaQuerySize.height * 0.02),

                      Text("OR",
                          style: TextStyle(
                            fontSize: CFGFont.subTitleFontSize,
                            fontWeight: CFGFont.regularFontWeight,
                            color: CFGFont.defaultFontColor,
                          )),

                      SB(height: mediaQuerySize.height * 0.02),

                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(150, 44)),
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.bgColorScreen),
                          overlayColor:
                              WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              side: BorderSide(color: CFGTheme.button),
                              borderRadius: BorderRadius.circular(
                                  CFGTheme.buttonRadius))),
                        ),
                        onPressed: () {
                          Get.to(() => const SuperAdminSignIn());
                        },
                        child: Text("Supervisor Login",
                            style: TextStyle(
                              height: 0,
                              fontSize: CFGFont.subTitleFontSize,
                              fontWeight: CFGFont.regularFontWeight,
                              color: CFGFont.defaultFontColor,
                            )),
                      ),

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
      )),
    );
  }
}
