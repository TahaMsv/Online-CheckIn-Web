import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/core/constants/my_list.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/ui.dart';
import '../../../widgets/MtDottedLine.dart';
import '../safety_controller.dart';
import '../safety_state.dart';

class CommitmentSegment extends StatelessWidget {
  const CommitmentSegment({
    Key? key,
    required this.mySafetyController,
    required this.safetyState,
    required this.isTabletMode,
  }) : super(key: key);
  final SafetyController mySafetyController;
  final SafetyState safetyState;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                "Your Commitment to Safety",
                style: MyTextTheme.darkGreyBold15,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MyDottedLine(
                  lineLength: double.infinity,
                  color: MyColors.white1,
                ),
              )
            ],
          ),
          if (!isTabletMode)
            for (int i = 0; i < MyList.policyWidgetText.length; ++i) PolicyWidget(index: i, mySafetyController: mySafetyController, normalText: MyList.policyWidgetText[i]), //todo change for
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
    required this.mySafetyController,
  }) : super(key: key);
  final int index;
  final String normalText;
  final SafetyController mySafetyController;

  @override
  Widget build(BuildContext context) {
    SafetyState safetyState = context.watch<SafetyState>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            onChanged: (bool? value) {
              safetyState.toggleCheckBoxesValue(index);
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
                    style: MyTextTheme.darkGreyW40015,
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
