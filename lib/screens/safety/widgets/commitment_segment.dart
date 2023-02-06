import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_check_in/core/constants/my_list.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../widgets/MtDottedLine.dart';
import '../../steps/steps_controller.dart';
import '../safety_controller.dart';
import '../safety_state.dart';

class CommitmentSegment extends StatelessWidget {
  const CommitmentSegment({
    Key? key,
    required this.safetyState,
    required this.isTabletMode,
  }) : super(key: key);
  final SafetyState safetyState;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Row(
                children: [
                  Text(
                    "Your Commitment to Safety",
                    style: isTabletMode ? MyTextTheme.darkGreyBold25 : MyTextTheme.darkGreyBold15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
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
                return PolicyWidget(isTabletMode: isTabletMode, index: i, normalText: MyList.policyWidgetText[i]);
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
                        text: "Please read our",
                        style: isTabletMode ? MyTextTheme.darkGreyW40023 : MyTextTheme.darkGreyW40015,
                      ),
                      TextSpan(
                        text: "travel policy",
                        style: isTabletMode ? const TextStyle(color: MyColors.myBlue, fontSize: 23) : const TextStyle(color: MyColors.myBlue),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: "to delay or cancel your trip if you are unable to accept the above commitments.",
                        style: isTabletMode ? MyTextTheme.darkGreyW40023 : MyTextTheme.darkGreyW40015,
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

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({
    Key? key,
    required this.index,
    required this.normalText,
    required this.isTabletMode,
  }) : super(key: key);
  final int index;
  final String normalText;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    SafetyState safetyState = context.watch<SafetyState>();
    final SafetyController safetyController = getIt<SafetyController>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isTabletMode
              ? Transform.scale(
                  scale: isTabletMode ? 1.5 : 1,
                  child: Checkbox(
                    onChanged: (bool? value) {
                      safetyState.toggleCheckBoxesValue(index);
                      final StepsController stepsController = getIt<StepsController>();
                      stepsController.updateIsNextButtonDisable();
                    },
                    value: safetyState.checkBoxesValue[index],
                  ),
                )
              : Checkbox(
                  onChanged: (bool? value) {
                    safetyState.toggleCheckBoxesValue(index);
                    final StepsController stepsController = getIt<StepsController>();
                    stepsController.updateIsNextButtonDisable();
                  },
                  value: safetyState.checkBoxesValue[index],
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
                    style: isTabletMode ? MyTextTheme.darkGreyW40020 : MyTextTheme.darkGreyW40015,
                  ),
                  TextSpan(
                    text: "Full Policy",
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
