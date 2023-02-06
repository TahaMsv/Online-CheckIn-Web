import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';
import '../../../widgets/MyElevatedButton.dart';

class ReceiptStepButtons extends StatelessWidget {
  const ReceiptStepButtons({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Row(
      children: [
        MyElevatedButton(
          height: deviceType.isTablet ? height * 0.06 : 40,
          width: deviceType.isTablet ? 200 : 110,
          fontSize: deviceType.isTablet ? 20 : 15,
          buttonText: "Download",
          bgColor: MyColors.darkGrey,
          fgColor: MyColors.white,
          function: () {},
        ),
         SizedBox(
          width:deviceType.isTablet ? 15:5,
        ),
        MyElevatedButton(
          height: deviceType.isTablet ? height * 0.06 : 40,
          width: deviceType.isTablet ? 200 : 80,
          fontSize: deviceType.isTablet ? 20 : 15,
          buttonText: "Print",
          bgColor: MyColors.oceanGreen,
          fgColor: MyColors.white,
          function: () {},
        ),
         SizedBox(
          width: deviceType.isTablet ?15:5,
        ),
        if (!deviceType.isTablet)
          MyElevatedButton(
            height: deviceType.isTablet ? height * 0.06 : 40,
            width: deviceType.isTablet ?200:140,
            fontSize: deviceType.isTablet ? 20 : 15,
            buttonText: "Sent to Mobile",
            bgColor: const Color(0xff4c6ef6),
            fgColor: MyColors.white,
            function: () {},
          ),
      ],
    );
  }
}
