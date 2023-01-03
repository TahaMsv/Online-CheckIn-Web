import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../steps_controller.dart';
class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key? key,
    required this.stepsController,
    required this.isDisable, required this.isTabletMode,
  }) : super(key: key);
  final StepsController stepsController;
  final bool isDisable;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    return SizedBox(
      child: MyElevatedButton(
        height:30,
        width:isTabletMode?200: 105,
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
                size:isTabletMode?20: 14,
              ),
            ),
            Container(
              margin: languageCode == "en" ? const EdgeInsets.only(left: 4) : const EdgeInsets.only(right: 4),
              child: Text(
                "Previous",
                style: TextStyle(
                  fontSize: isTabletMode?20:12,
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
