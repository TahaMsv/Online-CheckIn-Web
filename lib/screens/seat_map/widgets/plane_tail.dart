import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/platform/device_info.dart';
class PlaneTail extends StatelessWidget {
  const PlaneTail({
    Key? key,
    required this.margin,
    required this.height
  }) : super(key: key);

  final double margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Center(
      child: Container(
        margin:deviceType.isTablet ? EdgeInsets.only(top: margin + 230):deviceType.isPhone? EdgeInsets.only(top: margin + 190):languageCode == "en" ? EdgeInsets.only(left: margin + 50) : EdgeInsets.only(right: margin + 50),
        height: height - 15,
        width: deviceType.isTablet || deviceType.isPhone? height - 15 : null,
        child:! (deviceType.isTablet || deviceType.isPhone)?  Image.asset(
         AssetImages.airPlaneTail,
          fit: BoxFit.fill,
        ):RotationTransition(
          turns: languageCode == "en" ? const AlwaysStoppedAnimation(90 / 360) : const AlwaysStoppedAnimation(180 / 360),
          child: Image.asset(AssetImages.airPlaneTail, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
