import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
class PlaneTail extends StatelessWidget {
  const PlaneTail({
    Key? key,
    required this.margin,
    required this.height, required this.isTabletMode,
  }) : super(key: key);

  final double margin;
  final double height;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    return Center(
      child: Container(
        margin:isTabletMode? EdgeInsets.only(top: margin + 230):languageCode == "en" ? EdgeInsets.only(left: margin + 50) : EdgeInsets.only(right: margin + 50),
        height: height,
        width: isTabletMode? height - 15 : null,
        child: isTabletMode?  Image.asset(
         AssetImages.airplaneTailTablet,
          fit: BoxFit.fill,
        ):RotationTransition(
          turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
          child: Image.asset(AssetImages.airPlaneTail, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
