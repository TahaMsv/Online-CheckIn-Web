import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/platform/device_info.dart';

class PlaneHead extends StatelessWidget {
  const PlaneHead({
    Key? key,
    required this.height
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);

    String languageCode = "en";
    return Center(
      child: Container(
        height: height,
        width: deviceType.isTablet?height: 390,
        margin:deviceType.isTablet || deviceType.isPhone?null: languageCode == "en" ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
        child:!(deviceType.isTablet || deviceType.isPhone)?Image.asset(
          AssetImages.airPlaneHead,
          fit: BoxFit.fill,
          // height: 350,
        ): RotationTransition(
          turns: languageCode == "en" ? const AlwaysStoppedAnimation(90 / 360) : const AlwaysStoppedAnimation(180 / 360),
          child: Image.asset(AssetImages.airPlaneHead, fit: BoxFit.fill),
        ),
        // width: 400,
      ),
    );
  }
}
