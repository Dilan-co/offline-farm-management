import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SB extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const SB({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}

// SizedBox sb({double? height, double? width, Widget? child}) {
//   return SizedBox(
//     height: height,
//     width: width,
//     child: child,
//   );
// }
