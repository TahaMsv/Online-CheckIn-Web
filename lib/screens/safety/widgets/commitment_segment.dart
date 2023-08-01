import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/constants/my_list.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import '../../../core/platform/device_info.dart';
import '../../../widgets/MtDottedLine.dart';
import '../../steps/steps_controller.dart';
import '../safety_controller.dart';
import '../safety_state.dart';

class CommitmentSegment extends StatelessWidget {
  const CommitmentSegment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      margin: EdgeInsets.only(top: deviceType.isPhone ? 10 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Row(
                children: [
                  Text(
                    "Your Commitment to Safety".translate(context),
                    style: deviceType.isTablet ? MyTextTheme.darkGreyBold25 : MyTextTheme.darkGreyBold15,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: MyDottedLine(
                      lineLength: double.infinity,
                      color: MyColors.white1,
                    ),
                  )
                ],
              ),
            ] +
            MyList.policyWidgetText.asMap().entries.map(
              (entry) {
                int i = entry.key;
                // Traveller traveller = entry.value;
                return PolicyWidget(index: i, normalText: MyList.policyWidgetText[i].translate(context));
              },
            ).toList() +
            [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Please read our".translate(context),
                        style: deviceType.isTablet ? MyTextTheme.darkGreyW40023 : MyTextTheme.darkGreyW40015,
                      ),
                      TextSpan(
                        text: "travel policy".translate(context),
                        style: deviceType.isTablet ? const TextStyle(color: MyColors.myBlue, fontSize: 23) : const TextStyle(color: MyColors.myBlue),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: "to delay or cancel your trip if you are unable to accept the above commitments.".translate(context),
                        style: deviceType.isTablet ? MyTextTheme.darkGreyW40023 : MyTextTheme.darkGreyW40015,
                      ),
                    ],
                  ),
                ),
              ),
            ],
      ),
    );
  }
}

class PolicyWidget extends ConsumerWidget {
  const PolicyWidget({
    Key? key,
    required this.index,
    required this.normalText,
  }) : super(key: key);
  final int index;
  final String normalText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          deviceType.isTablet
              ? Transform.scale(
                  scale: deviceType.isTablet ? 1.5 : 1,
                  child: Checkbox(
                    onChanged: (bool? value) {
                      ref.watch(checkBoxesProvider.notifier).toggleCheckBoxesValue(index);
                      final StepsController stepsController = getIt<StepsController>();
                      stepsController.updateIsNextButtonDisable();
                    },
                    value: ref.watch(checkBoxesProvider)[index],
                  ),
                )
              : Checkbox(
                  onChanged: (bool? value) {
                    ref.watch(checkBoxesProvider.notifier).toggleCheckBoxesValue(index);
                    final StepsController stepsController = getIt<StepsController>();
                    stepsController.updateIsNextButtonDisable();
                  },
                  value: ref.watch(checkBoxesProvider)[index],
                ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: normalText,
                    style: deviceType.isTablet ? MyTextTheme.darkGreyW40020 : MyTextTheme.darkGreyW40015,
                  ),
                  TextSpan(
                    text: " ${"Full Policy".translate(context)}",
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
