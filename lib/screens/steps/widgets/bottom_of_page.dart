import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import 'package:online_check_in/screens/steps/widgets/previous_button.dart';
import 'package:online_check_in/screens/steps/widgets/receipt_button.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import '../../../core/platform/device_info.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../../seat_map/seat_map_controller.dart';
import '../steps_controller.dart';
import '../steps_state.dart';

class BottomOfPage extends ConsumerWidget {
  const BottomOfPage({
    Key? key,
    required this.height,
    required this.stepsController,
  }) : super(key: key);

  final double height;
  final StepsController stepsController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StepsState stepsState = ref.watch(stepsProvider);
    PassportState passportState = ref.watch(passportProvider);
    VisaState visaState = ref.watch(visaProvider);
    ReceiptState receiptState = ref.watch(receiptProvider);
    final SeatMapController seatMapController = getIt<SeatMapController>();
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        shape: BoxShape.rectangle,
        // color: Colors.red
      ),
      height: height * 0.07,  // height * 0.1 for tablet
      padding: deviceType.isPhone ? const EdgeInsets.symmetric(horizontal: 5) : const EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.grey,
      child: stepsState.showSeatMap
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyElevatedButton(
                  height: deviceType.isTablet ? height * 0.06 : 50,
                  width: deviceType.isPhone ? 150 : 300,
                  fontSize: deviceType.isPhone ? 15 : 20,
                  buttonText: "Close",
                  fgColor: MyColors.black,
                  bgColor: MyColors.white,
                  function: () {
                    seatMapController.getBackFromPlane();
                  },
                  isDisable: false,
                ),
                MyElevatedButton(
                  height: deviceType.isTablet ? height * 0.06 : 50,
                  width: deviceType.isPhone ? 150 : 300,
                  fontSize: deviceType.isPhone ? 15 : 20,
                  buttonText: "Finish",
                  fgColor: stepsState.isNextButtonEnable ? MyColors.white : MyColors.black,
                  bgColor: stepsState.isNextButtonEnable ? MyColors.green : MyColors.grey,
                  // borderColor: Colors.grey,
                  function: () {
                    seatMapController.getBackFromPlane();
                  },
                  isDisable: !stepsState.isNextButtonEnable,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                stepsState.step == 0 || stepsState.step == 8
                    ? Container()
                    : PreviousButton(
                        isDisable: !stepsState.isPreviousButtonEnable,
                        stepsController: stepsController,
                      ),
                stepsState.step == 8
                    ? const ReceiptStepButtons()
                    : MyElevatedButton(
                        height: deviceType.isTablet ? height * 0.06 : 50,
                        width: deviceType.isPhone ? stepsState.buttonText(stepsState.currButtonTextIndex).length * 14.5 : 300,
                        fontSize: deviceType.isPhone ? 15 : 20,
                        buttonText: stepsState.buttonText(stepsState.currButtonTextIndex),
                        bgColor: MyColors.myBlue,
                        fgColor: MyColors.white,
                        function: stepsController.increaseStep,
                        isDisable: !stepsState.isNextButtonEnable,
                        isLoading: stepsState.stepLoading || passportState.loading || visaState.loading || receiptState.loading,
                      ),
              ],
            ),
    );
  }
}
