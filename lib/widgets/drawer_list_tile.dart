import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:farm_management/configs/color.dart';

class DrawerListTile extends StatelessWidget {
  final String imageAsset;
  final Widget widget;
  final void Function()? onTap;
  const DrawerListTile(
      {super.key,
      required this.imageAsset,
      required this.widget,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        dense: true,
        leading: SvgPicture.asset(
          imageAsset,
          colorFilter: ColorFilter.mode(CFGColor.black, BlendMode.srcIn),
          height: 24,
          width: 24,
        ),
        title: widget,
        onTap: onTap,
      ),
    );
  }
}
