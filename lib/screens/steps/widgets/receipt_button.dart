import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';
import '../../../widgets/MyElevatedButton.dart';

class ReceiptStepButtons extends StatelessWidget {
  const ReceiptStepButtons({
    Key? key, required this.isTabletMode,
  }) : super(key: key);
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyElevatedButton(
          height: 40,
          width: isTabletMode ? 200 : 100,
          fontSize: isTabletMode ? 20 : 15,
          buttonText: "Download",
          bgColor: MyColors.darkGrey,
          fgColor: MyColors.white,
          function: () {},
        ),
        const SizedBox(
          width: 15,
        ),
        MyElevatedButton(
          height: 40,
          width: isTabletMode ? 200 : 100,
          fontSize: isTabletMode ? 20 : 15,
          buttonText: "Print",
          bgColor: MyColors.oceanGreen,
          fgColor: MyColors.white,
          function: () {},
        ),
        const SizedBox(
          width: 15,
        ),
        if (!isTabletMode)
          MyElevatedButton(
            height: 40,
            width: 200,
            buttonText: "Sent to Mobile",
            bgColor: const Color(0xff4c6ef6),
            fgColor: MyColors.white,
            function: () {},
          ),
      ],
    );
  }
}
