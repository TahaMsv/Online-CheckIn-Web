import 'package:flutter/material.dart';

import '../core/constants/ui.dart';
import '../core/platform/device_info.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    required this.width,
    this.textColor = MyColors.darkGrey,
    this.fontSize = 17,
    this.height = 60,
  }) : super(key: key);

  final String title;
  final double height;
  final double width;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      height: height,
      width: width,
      padding:  EdgeInsets.symmetric(vertical:deviceType.isPhone?10: 20, horizontal: deviceType.isPhone?10: 20),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
