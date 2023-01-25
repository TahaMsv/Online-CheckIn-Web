import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';

class PlaneHead extends StatelessWidget {
  const PlaneHead({
    Key? key,
    required this.height, required this.isTabletMode,
  }) : super(key: key);

  final double height;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    return Center(
      child: Container(
        height: height,
        width:isTabletMode?height: 390,
        margin:isTabletMode?null: languageCode == "en" ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
        child:isTabletMode?Image.asset(
          "assets/images/Airplane Head-tablet.png",
          fit: BoxFit.fill,
          // height: 350,
        ): RotationTransition(
          turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
          child: Image.asset(AssetImages.AIRPLANE_HEAD, fit: BoxFit.fill),
        ),
        // width: 400,
      ),
    );
  }
}
