import 'package:flutter/material.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CFGTheme.bgColorScreen,
        body: Padding(
          padding: EdgeInsets.only(
            left: mediaQuerySize.width * 0.22,
            right: mediaQuerySize.width * 0.22,
            bottom: mediaQuerySize.height * 0.03,
          ),
          child: const Center(
            child: Image(
              image: AssetImage(CFGImage.logoBlackText),
            ),
          ),
        ),
      ),
    );
  }
}
