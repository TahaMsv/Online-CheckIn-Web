import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'SafetyStepController.dart';

class SafetyStepView extends StatelessWidget {
  final SafetyStepScreenController mySafetyStepScreenController;

  SafetyStepView(MainModel model) : mySafetyStepScreenController = Get.put(SafetyStepScreenController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdviseSegment(),
            CommitmentSegment(
              mySafetyStepScreenController: mySafetyStepScreenController,
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
    required this.mySafetyStepScreenController,
  }) : super(key: key);
  final SafetyStepScreenController mySafetyStepScreenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Your Commitment to Safety",
                style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MyDottedLine(
                  lineLength: double.infinity,
                  color: Color(0xffcecece),
                ),
              )
            ],
          ),
          PolicyWidget(
            index: 0,
            mySafetyStepScreenController: mySafetyStepScreenController,
            normalText: "In the past 10 days, I/we have not had a COVID-19 diagnosis and have not experienced the onset of any one of the primary symptoms of COVID-19. ",
          ),
          PolicyWidget(
            index: 1,
            mySafetyStepScreenController: mySafetyStepScreenController,
            normalText:
                "I/we have not been in close contact with someone who has COVID-19 in the past 10 days. EXCEPTION: I/we have been fully vaccinated for at least 2 weeks or have had COVID-19 within the last 90 days and fully recovered so that I/we are not contagious, and I/we remain symptom free. ",
          ),
          PolicyWidget(
            index: 2,
            mySafetyStepScreenController: mySafetyStepScreenController,
            normalText: "I/we will wear a face mask throughout the airport, in Delta Sky Clubs and onboard the aircraft, even if fully vaccinated, unless I meet the criteria for exemptions. ",
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Please read our ",
                    style: TextStyle(fontSize: 15, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "travel policy",
                    style: new TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // launch(
                        //     'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                      },
                  ),
                  TextSpan(
                    text: " to delay or cancel your trip if you are unable to accept the above commitments.",
                    style: TextStyle(fontSize: 15, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
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
    required this.mySafetyStepScreenController,
  }) : super(key: key);
  final int index;
  final String normalText;
  final SafetyStepScreenController mySafetyStepScreenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Checkbox(
              onChanged: (bool? value) {
                mySafetyStepScreenController.changeValue(index, value!);
              },
              value: mySafetyStepScreenController.checkBoxesValue[index],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: normalText,
                    style: TextStyle(fontSize: 15, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "Full Policy",
                    style: new TextStyle(color: Colors.blue),
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
            title: "The Standard For Safer Travel",
            description: "",
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Color(0xff90d3f9),
                  margin: EdgeInsets.only(right: 20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delta’s Commitment to You",
                      style: TextStyle(
                        color: Color(0xff424242),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 650,
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight.",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Color(0xff424242),
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
