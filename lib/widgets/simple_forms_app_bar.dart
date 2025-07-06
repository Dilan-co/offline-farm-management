import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/controller/state_controller.dart';
import 'package:farm_management/widgets/sized_box.dart';

class SimpleFormsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMainTile;
  final bool isUpdate;
  final bool isView;
  SimpleFormsAppBar({
    super.key,
    required this.title,
    this.isMainTile = false,
    this.isUpdate = false,
    this.isView = false,
  });

  final StateController stateController = Get.find();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight * stateController.getDeviceAppBarMultiplier());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppBar().preferredSize.height *
          stateController.getDeviceAppBarMultiplier(),
      backgroundColor: CFGTheme.bgColorScreen,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: CFGTheme.bodyLRPadding,
      title: isMainTile
          ? Text(title,
              softWrap: true,
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontSize: CFGFont.smallTitleFontSize,
                fontWeight: CFGFont.mediumFontWeight,
                color: CFGFont.defaultFontColor,
              ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Text(title,
                    softWrap: true,
                    style: TextStyle(
                      // overflow: TextOverflow.clip,
                      fontSize: CFGFont.smallTitleFontSize,
                      fontWeight: CFGFont.mediumFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),

                const SB(height: 2),

                Text(
                    isUpdate
                        ? "Update"
                        : isView
                            ? "View"
                            : "Add",
                    style: TextStyle(
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.lightFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ],
            ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: CFGTheme.bodyLRPadding),
          child: Builder(builder: (context) {
            return IconButton.filled(
                padding: EdgeInsets.all(
                    stateController.getDeviceAppBarMultiplier() != 1.0
                        ? 7 * stateController.getDeviceAppBarMultiplier()
                            as double
                        : 0),
                style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(CFGTheme.buttonOverlay),
                  backgroundColor: WidgetStatePropertyAll(CFGTheme.button),
                  // iconColor: WidgetStatePropertyAll(Color(0xFFD9D9D9)),
                ),
                onPressed: () {
                  //Dismiss Keyboard
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.back(result: true);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: CFGTheme.appBarButtonImg,
                  size: 28 * stateController.getDeviceAppBarMultiplier()
                      as double,
                ));
          }),
        ),
      ],
    );
  }
}
