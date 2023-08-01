import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';

import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';
import '../../../core/utils/multi_languages.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../steps_controller.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key? key,
    required this.stepsController,
    required this.isDisable,
  }) : super(key: key);
  final StepsController stepsController;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    // String languageCode = MultiLanguages.of(context)!.locale.languageCode;  //todo
    String languageCode = 'en';
    double height = MediaQuery.of(context).size.height;
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return SizedBox(
      child: MyElevatedButton(
        height: deviceType.isTablet ? height * 0.06 : 40,
        width: deviceType.isTablet ? 200 : 120,
        bgColor: MyColors.white,
        function: () {
          if (!isDisable) {
            stepsController.decreaseStep();
          }
        },
        buttonText: '',
        child: Row(
          children: [
            RotationTransition(
              turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                MenuIcons.iconLeftArrow,
                color: isDisable ? MyColors.sonicSilver.withOpacity(0.5) : MyColors.sonicSilver,
                size: deviceType.isTablet ? 20 : 14,
              ),
            ),
            Container(
              margin: languageCode == "en" ? const EdgeInsets.only(left: 4) : const EdgeInsets.only(right: 4),
              child: Text(
                "Previous".translate(context),
                style: TextStyle(
                  fontSize:deviceType.isPhone ? 15: deviceType.isTablet ? 20 : 12,
                  color: isDisable ? MyColors.sonicSilver.withOpacity(0.5) : MyColors.sonicSilver,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
