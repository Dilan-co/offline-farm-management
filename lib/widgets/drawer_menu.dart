import 'package:farm_management/screens/task/task_main_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/image.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/screens/dashboard.dart';
import 'package:farm_management/screens/signin.dart';
import 'package:farm_management/screens/simple_forms_menu.dart';
import 'package:farm_management/screens/super_admin_signin.dart';
import 'package:farm_management/services/api_data_service.dart';
import 'package:farm_management/services/check_connectivity.dart';
import 'package:farm_management/widgets/drawer_list_tile.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/snackbar.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key});

  final StateController stateController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Drawer(
      surfaceTintColor: CFGTheme.bgColorScreen,
      elevation: 0,
      backgroundColor: CFGTheme.bgColorScreen,
      width: mediaQuerySize.width * 0.75,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: mediaQuerySize.width * 0.05,
                        width: mediaQuerySize.width * 0.05,
                        constraints:
                            const BoxConstraints(minHeight: 50, minWidth: 50),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CFGTheme.logoColorsGreen,
                            width: 1,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: ClipOval(
                            child: Image(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(CFGImage.profileImage),
                            ),
                            // child: Image.network(
                            //   'https://oflutter.com/wp-content/uploads/2024/02/girl-profile.png',
                            //   fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),

                      //
                      SB(width: mediaQuerySize.width * 0.025),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stateController.getLoggedUserName(),
                            style: TextStyle(
                              fontWeight: CFGFont.mediumFontWeight,
                              fontSize: CFGFont.subTitleFontSize,
                              color: CFGFont.defaultFontColor,
                            ),
                          ),

                          //
                          const SB(height: 2),

                          Text(
                            stateController.getLoggedUserType(),
                            style: TextStyle(
                              fontWeight: CFGFont.lightFontWeight,
                              fontSize: CFGFont.defaultFontSize,
                              color: CFGFont.defaultFontColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //Close Button
                  IconButton(
                      padding: EdgeInsets.all(
                          stateController.getDeviceAppBarMultiplier() != 1.0
                              ? 5 * stateController.getDeviceAppBarMultiplier()
                                  as double
                              : 0),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(CFGTheme.buttonLightGrey),
                          shape: const WidgetStatePropertyAll(CircleBorder())),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30 * stateController.getDeviceAppBarMultiplier()
                            as double,
                        color: CFGTheme.button,
                      )),
                ],
              ),
            ),

            //
            Divider(color: CFGColor.midGrey, endIndent: 15, thickness: 1.5),

            //
            Expanded(
              child: ListView(
                // physics: const BouncingScrollPhysics(),
                children: [
                  //
                  Visibility(
                    visible: stateController.getLoggedUserType() == "worker",
                    child: DrawerListTile(
                        imageAsset: CFGImage.dashboard,
                        widget: Text(
                          'Worker Dashboard',
                          style: TextStyle(
                            fontWeight: CFGFont.mediumFontWeight,
                            fontSize: CFGFont.titleFontSize,
                            color: CFGFont.defaultFontColor,
                          ),
                        ),
                        onTap: () {
                          Get.back();
                          Get.to(() => const Dashboard());
                        }),
                  ),

                  Visibility(
                    visible: stateController.getLoggedUserType() ==
                            "superAdmin" ||
                        stateController.getLoggedUserType() == "supervisor" ||
                        stateController.getLoggedUserType() == "qaOfficer",
                    child: DrawerListTile(
                        imageAsset: CFGImage.clipboard,
                        widget: Text(
                          'Form Submission',
                          style: TextStyle(
                            fontWeight: CFGFont.mediumFontWeight,
                            fontSize: CFGFont.titleFontSize,
                            color: CFGFont.defaultFontColor,
                          ),
                        ),
                        onTap: () async {}),
                  ),

                  Visibility(
                    visible: stateController.getLoggedUserType() ==
                            "superAdmin" ||
                        stateController.getLoggedUserType() == "supervisor" ||
                        stateController.getLoggedUserType() == "qaOfficer",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                          imageAsset: CFGImage.forms,
                          widget: Text(
                            'Simple Forms',
                            style: TextStyle(
                              fontWeight: CFGFont.mediumFontWeight,
                              fontSize: CFGFont.subTitleFontSize,
                              color: CFGFont.defaultFontColor,
                            ),
                          ),
                          onTap: () async {
                            Get.back();
                            Get.to(() => const SimpleFormsMenu());
                          }),
                    ),
                  ),

                  Visibility(
                    visible: stateController.getLoggedUserType() ==
                            "superAdmin" ||
                        stateController.getLoggedUserType() == "supervisor" ||
                        stateController.getLoggedUserType() == "qaOfficer",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Opacity(
                        opacity: 0.5,
                        child: DrawerListTile(
                            imageAsset: CFGImage.forms,
                            widget: Text(
                              'Management',
                              style: TextStyle(
                                fontWeight: CFGFont.mediumFontWeight,
                                fontSize: CFGFont.subTitleFontSize,
                                color: CFGFont.defaultFontColor,
                              ),
                            ),
                            onTap: () async {
                              // Get.back();
                              // Get.to(() => null);
                            }),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: stateController.getLoggedUserType() ==
                            "superAdmin" ||
                        stateController.getLoggedUserType() == "supervisor" ||
                        stateController.getLoggedUserType() == "qaOfficer",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Opacity(
                        opacity: 0.5,
                        child: DrawerListTile(
                            imageAsset: CFGImage.forms,
                            widget: Text(
                              'Operational',
                              style: TextStyle(
                                fontWeight: CFGFont.mediumFontWeight,
                                fontSize: CFGFont.subTitleFontSize,
                                color: CFGFont.defaultFontColor,
                              ),
                            ),
                            onTap: () async {
                              // Get.back();
                              // Get.to(() => null);
                            }),
                      ),
                    ),
                  ),

                  Visibility(
                    visible:
                        stateController.getLoggedUserType() == "superAdmin" ||
                            stateController.getLoggedUserType() == "supervisor",
                    child: DrawerListTile(
                        imageAsset: CFGImage.addTask,
                        widget: Text(
                          'Task Allocation'.tr,
                          style: TextStyle(
                            fontWeight: CFGFont.mediumFontWeight,
                            fontSize: CFGFont.titleFontSize,
                            color: CFGFont.defaultFontColor,
                          ),
                        ),
                        onTap: () async {
                          Get.back();
                          Get.to(() => const TaskMainTileView());
                        }),
                  ),

                  Opacity(
                    opacity: 0.5,
                    child: DrawerListTile(
                        imageAsset: CFGImage.settings,
                        widget: Text(
                          'App Settings'.tr,
                          style: TextStyle(
                            fontWeight: CFGFont.mediumFontWeight,
                            fontSize: CFGFont.titleFontSize,
                            color: CFGFont.defaultFontColor,
                          ),
                        ),
                        onTap: () async {
                          // Get.back();
                          // Get.to(() => null);
                        }),
                  ),

                  DrawerListTile(
                      imageAsset: CFGImage.sync,
                      widget: Text(
                        'Sync Now'.tr,
                        style: TextStyle(
                          fontWeight: CFGFont.mediumFontWeight,
                          fontSize: CFGFont.titleFontSize,
                          color: CFGFont.defaultFontColor,
                        ),
                      ),
                      onTap: () async {
                        //Check internet status
                        bool haveInternet = await checkNetworkConnectivity();

                        if (haveInternet) {
                          String? accessToken =
                              stateController.getAccessToken();
                          if (accessToken != "" && accessToken != null) {
                            //Sync Data using APIs
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
                                            color: CFGTheme
                                                .circularProgressIndicator,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );

                            try {
                              // Perform sync operations
                              bool sync =
                                  await ApiDataService().syncPushApiData();

                              // Dismiss the dialog and show completion Snackbar
                              Get.back();

                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                sync
                                    ? snackBar(
                                        msg: "Sync Successful.", isPass: true)
                                    : snackBar(
                                        msg: "Sync Failed. Try Again...",
                                        isPass: false);
                              });
                            } catch (e, stackTrace) {
                              debugPrint(
                                  "Error occurred while syncing data: $e");
                              debugPrint("StackTrace: $stackTrace");
                              // Handle sync error
                              Get.back();

                              snackBar(
                                  msg: "Sync Failed. Try Again...",
                                  isPass: false);
                            }
                          } else {
                            //Redirecting to Super Admin Login
                            Get.to(() => SuperAdminSignIn(isSyncOut: true));
                          }
                        } else {
                          //Show "No Internet"
                          snackBar(
                              msg:
                                  "No Internet. Connect to Wi-Fi or Mobile network.",
                              isPass: false);
                        }
                      }),

                  DrawerListTile(
                      imageAsset: CFGImage.logOut,
                      widget: Text(
                        'Log Out'.tr,
                        style: TextStyle(
                          fontWeight: CFGFont.mediumFontWeight,
                          fontSize: CFGFont.titleFontSize,
                          color: CFGFont.defaultFontColor,
                        ),
                      ),
                      onTap: () async {
                        // Get.back();
                        //Clear Access Token & User Details
                        stateController.setAccessToken("");
                        stateController.setLoggedUserId(0);
                        stateController.setLoggedUserName("");
                        stateController.setLoggedUserType("");

                        Get.to(() => SignIn());
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
