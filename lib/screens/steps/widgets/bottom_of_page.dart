import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/steps/widgets/previous_button.dart';
import 'package:online_checkin_web_refactoring/screens/steps/widgets/receipt_button.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/ui.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../steps_controller.dart';
import '../steps_state.dart';
class BottomOfPage extends StatelessWidget {
  const BottomOfPage({
    Key? key,
    required this.height,
    required this.stepsController,
    required this.isTabletMode,
  }) : super(key: key);

  final double height;
  final StepsController stepsController;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.rectangle,
        ),
        // height: height * 0.13,  // height * 0.1 for tablet
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            stepsState.step == 0 || stepsState.step == 8
                ? Container()
                : PreviousButton(
              isTabletMode: isTabletMode,
              isDisable: !stepsState.isPreviousButtonEnable,
              stepsController: stepsController,
            ),
            stepsState.step == 8
                ?  ReceiptStepButtons(isTabletMode: isTabletMode,)
                : MyElevatedButton(
              height: isTabletMode ? height * 0.06 : 40,
              width: 300,
              buttonText: stepsState.buttonText(stepsState.currButtonTextIndex),
              bgColor: MyColors.myBlue,
              fgColor: MyColors.white,
              function: stepsController.increaseStep,
              isDisable: !stepsState.isNextButtonEnable,
            ),
          ],
        ),
      ),
    );
  }
}
