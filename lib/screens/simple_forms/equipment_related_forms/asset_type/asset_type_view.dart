import 'package:flutter/material.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/models/table_models/org/org_equipment_type_model.dart';
import 'package:farm_management/widgets/simple_forms_app_bar.dart';
import 'package:farm_management/widgets/sized_box.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class AssetTypeView extends StatelessWidget {
  final String updateRouter;
  final OrgEquipmentTypeModel data;
  final Function(bool, OrgEquipmentTypeModel) onDelete;
  const AssetTypeView({
    super.key,
    required this.updateRouter,
    required this.data,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(updateRouter);
    // Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        drawerEnableOpenDragGesture: false,
        appBar: SimpleFormsAppBar(title: "Asset Type", isView: true),
        //
        body: Padding(
          padding: EdgeInsets.only(
            left: CFGTheme.bodyLRPadding,
            right: CFGTheme.bodyLRPadding,
            // top: CFGTheme.bodyTBPadding,
            bottom: CFGTheme.bodyTBPadding,
          ),
          child: ListView(
            children: [
              //
              const SB(height: 10),

              FormViewTextRow(
                label: "Asset Type",
                data: data.name,
              ),
              FormViewTextRow(
                label: "Description",
                data: data.description,
              ),
              FormViewTextRow(
                label: "Status",
                data: data.status == 1 ? "Active" : "Inactive",
              ),

              FormViewTextRow(
                label: "Deleted",
                data: data.deleted == 1 ? "YES" : "NO",
              ),

              //
              // Padding(
              //   padding: const EdgeInsets.only(top: 10, bottom: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       SB(
              //         height: 36,
              //         width: 36,
              //         child: IconButton(
              //           padding: EdgeInsets.zero,
              //           style: ButtonStyle(
              //               backgroundColor: WidgetStatePropertyAll(
              //                   CFGTheme.bgColorScreen),
              //               shape:
              //                   const WidgetStatePropertyAll(CircleBorder())),
              //           onPressed: () {
              //             Get.toNamed(
              //               updateRouter,
              //               arguments: data,
              //             );
              //           },
              //           icon: SvgPicture.asset(
              //             CFGImage.edit,
              //             colorFilter: ColorFilter.mode(
              //                 CFGTheme.button, BlendMode.srcIn),
              //             // color: Colors.white,
              //             height: 20,
              //             width: 20,
              //           ),
              //         ),
              //       ),

              //       //
              //       const SB(width: 20),

              //       SB(
              //         height: 36,
              //         width: 36,
              //         child: IconButton(
              //           padding: EdgeInsets.zero,
              //           style: ButtonStyle(
              //               backgroundColor: WidgetStatePropertyAll(
              //                   CFGTheme.bgColorScreen),
              //               shape:
              //                   const WidgetStatePropertyAll(CircleBorder())),
              //           onPressed: () {
              //             // Get.to(() => SimpleFormsDelete());

              //             showDialog(
              //               barrierDismissible: true,
              //               barrierColor: const Color(0x60000000),
              //               context: context,
              //               builder: (BuildContext context) {
              //                 return AlertDialog(
              //                   elevation: 0,
              //                   actionsAlignment: MainAxisAlignment.center,
              //                   backgroundColor: CFGTheme.bgColorScreen,
              //                   titlePadding: const EdgeInsets.only(top: 30),
              //                   contentPadding:
              //                       const EdgeInsets.only(top: 15, bottom: 30),
              //                   // actionsPadding: const EdgeInsets.only(bottom: 30),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(
              //                           CFGTheme.cardRadius)),
              //                   title: Text(
              //                     "Delete",
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       fontSize: CFGFont.titleFontSize,
              //                       fontWeight: CFGFont.mediumFontWeight,
              //                       color: CFGFont.defaultFontColor,
              //                     ),
              //                   ),
              //                   content: Container(
              //                     constraints: BoxConstraints(
              //                         minWidth: mediaQuerySize.width * 0.3),
              //                     child: Text(
              //                       "Are you sure?",
              //                       textAlign: TextAlign.center,
              //                       style: TextStyle(
              //                         fontSize: CFGFont.smallTitleFontSize,
              //                         fontWeight: CFGFont.regularFontWeight,
              //                         color: CFGFont.defaultFontColor,
              //                       ),
              //                     ),
              //                   ),
              //                   actions: <Widget>[
              //                     TextButton(
              //                       style: ButtonStyle(
              //                         fixedSize: const WidgetStatePropertyAll(
              //                             Size(80, 40)),
              //                         overlayColor: WidgetStatePropertyAll(
              //                             CFGTheme.buttonOverlay),
              //                         backgroundColor: WidgetStatePropertyAll(
              //                             CFGTheme.button),
              //                         shape: WidgetStatePropertyAll(
              //                           RoundedRectangleBorder(
              //                               borderRadius: BorderRadius.circular(
              //                                   CFGTheme.buttonRadius)),
              //                         ),
              //                       ),
              //                       child: Text(
              //                         'Yes',
              //                         style: TextStyle(
              //                           height: 0,
              //                           fontSize: CFGFont.defaultFontSize,
              //                           fontWeight: CFGFont.mediumFontWeight,
              //                           color: CFGFont.whiteFontColor,
              //                         ),
              //                       ),
              //                       onPressed: () {
              //                         onDelete(true, data);
              //                         Get.close(2);
              //                       },
              //                     ),

              //                     const SB(width: 10),

              //                     //
              //                     TextButton(
              //                       style: ButtonStyle(
              //                         fixedSize: const WidgetStatePropertyAll(
              //                             Size(80, 40)),
              //                         overlayColor: WidgetStatePropertyAll(
              //                             CFGTheme.buttonOverlay),
              //                         backgroundColor: WidgetStatePropertyAll(
              //                             CFGColor.lightGrey),
              //                         shape: WidgetStatePropertyAll(
              //                           RoundedRectangleBorder(
              //                               borderRadius: BorderRadius.circular(
              //                                   CFGTheme.buttonRadius)),
              //                         ),
              //                       ),
              //                       child: Text(
              //                         'No',
              //                         style: TextStyle(
              //                           height: 0,
              //                           fontSize: CFGFont.defaultFontSize,
              //                           fontWeight: CFGFont.mediumFontWeight,
              //                           color: CFGFont.defaultFontColor,
              //                         ),
              //                       ),
              //                       onPressed: () {
              //                         Get.back();
              //                       },
              //                     ),
              //                   ],
              //                 );
              //               },
              //             );
              //           },
              //           icon: SvgPicture.asset(
              //             CFGImage.delete,
              //             colorFilter: ColorFilter.mode(
              //                 CFGTheme.button, BlendMode.srcIn),
              //             // color: Colors.white,
              //             height: 20,
              //             width: 20,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
