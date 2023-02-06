import 'package:flutter/material.dart';
import 'package:online_check_in/screens/steps/widgets/previous_button.dart';
import 'package:online_check_in/screens/steps/widgets/receipt_button.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../../seat_map/seat_map_controller.dart';
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
    final SeatMapController seatMapController = getIt<SeatMapController>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.rectangle,
        ),
        // height: height * 0.13,  // height * 0.1 for tablet
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // color: Colors.grey,
        child:stepsState.showSeatMap?  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyElevatedButton(
              height: height * 0.06,
              width: 250,
              buttonText: "Close",
              fontSize: 25,
              fgColor: MyColors.black,
              bgColor: MyColors.white,
              function: () {
                seatMapController.getBackFromPlane();
              },
              isDisable: false,
            ),
            MyElevatedButton(
              height: height * 0.06,
              width: 250,
              buttonText: "Finish",
              fontSize: 30,
              fgColor: stepsState.isNextButtonEnable ? MyColors.white : MyColors.black,
              bgColor: stepsState.isNextButtonEnable ? MyColors.green : MyColors.grey,
              // borderColor: Colors.grey,
              function: () {
                seatMapController.getBackFromPlane();
              },
              isDisable: !stepsState.isNextButtonEnable,
            ),
          ],
        ):  Row(
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
              fontSize: 20,
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
