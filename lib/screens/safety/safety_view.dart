import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/safety/safety_controller.dart';
import 'package:online_checkin_web_refactoring/screens/safety/safety_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/MtDottedLine.dart';
import '../../widgets/StepsScreenTitle.dart';

class SafetyView extends StatelessWidget {
  SafetyView({Key? key}) : super(key: key);
  final SafetyController safetyController = getIt<SafetyController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SafetyState safetyState = context.watch<SafetyState>();
    return Scaffold(
      backgroundColor: MyColors.white,
      body:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdviseSegment(),
            CommitmentSegment(
              mySafetyController: safetyController,
            ),
          ],
        ),
      ),
    );
  }
}

class CommitmentSegment extends StatelessWidget {
  const CommitmentSegment({
    Key? key,
    required this.mySafetyController,
  }) : super(key: key);
  final SafetyController mySafetyController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Your Commitment to Safety".tr,
                style: const TextStyle(color: MyColors.darkGrey, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: MyDottedLine(
                  lineLength: double.infinity,
                  color: Color(0xffcecece),
                ),
              )
            ],
          ),
          PolicyWidget(
            index: 0,
            mySafetyController: mySafetyController,
            normalText: "In the past 10 days, I/we have not had a COVID-19 diagnosis and have not experienced the onset of any one of the primary symptoms of COVID-19.".tr,
          ),
          PolicyWidget(
            index: 1,
            mySafetyController: mySafetyController,
            normalText:
            "I/we have not been in close contact with someone who has COVID-19 in the past 10 days. EXCEPTION: I/we have been fully vaccinated for at least 2 weeks or have had COVID-19 within the last 90 days and fully recovered so that I/we are not contagious, and I/we remain symptom free.".tr,
          ),
          PolicyWidget(
            index: 2,
            mySafetyController: mySafetyController,
            normalText: "I/we will wear a face mask throughout the airport, in Delta Sky Clubs and onboard the aircraft, even if fully vaccinated, unless I meet the criteria for exemptions.".tr,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Please read our".tr,
                    style: const TextStyle(fontSize: 15, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "travel policy".tr,
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // launch(
                        //     'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                      },
                  ),
                  TextSpan(
                    text: "to delay or cancel your trip if you are unable to accept the above commitments.".tr,
                    style: const TextStyle(fontSize: 15, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
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
          Obx(
                () => Checkbox(
              onChanged: (bool? value) {
                mySafetyController.changeValue(index, value!);
              },
              value: safetyState.checkBoxesValue[index],
            ),
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
                    style: const TextStyle(fontSize: 15, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "Full Policy".tr,
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // launch(
                        //     'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                      },
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

class AdviseSegment extends StatelessWidget {
  const AdviseSegment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(
            title: "The Standard For Safer Travel".tr,
            description: "",
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/images/mask.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delta’s Commitment to You".tr,
                      style: const TextStyle(
                        color: MyColors.darkGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 650,
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight.".tr,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          color: MyColors.darkGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
