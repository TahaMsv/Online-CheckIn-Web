
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'SafetyStepController.dart';

class SafetyStepTabletView extends StatelessWidget {
  final SafetyStepScreenController mySafetyStepScreenController;

  SafetyStepTabletView(MainModel model) : mySafetyStepScreenController = Get.put(SafetyStepScreenController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
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
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Your Commitment to Safety".tr,
                style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 20),
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
            scale: 2,
            mySafetyStepScreenController: mySafetyStepScreenController,
            fontSize: 23,
            normalText: "In the past 10 days, I/we have not had a COVID-19 diagnosis and have not experienced the onset of any one of the primary symptoms of COVID-19.".tr,
          ),
          PolicyWidget(
            index: 1,
            scale: 2,
            fontSize: 23,
            mySafetyStepScreenController: mySafetyStepScreenController,
            normalText:
            "I/we have not been in close contact with someone who has COVID-19 in the past 10 days. EXCEPTION: I/we have been fully vaccinated for at least 2 weeks or have had COVID-19 within the last 90 days and fully recovered so that I/we are not contagious, and I/we remain symptom free.".tr,
          ),
          PolicyWidget(
            index: 2,
            scale: 2,
            fontSize: 23,
            mySafetyStepScreenController: mySafetyStepScreenController,
            normalText: "I/we will wear a face mask throughout the airport, in Delta Sky Clubs and onboard the aircraft, even if fully vaccinated, unless I meet the criteria for exemptions.".tr,
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Please read our ".tr,
                    style: TextStyle(fontSize: 23, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "travel policy ".tr,
                    style:  TextStyle(color: Colors.blue, fontSize: 23,),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // launch(
                        //     'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                      },
                  ),
                  TextSpan(
                    text: "to delay or cancel your trip if you are unable to accept the above commitments.".tr,
                    style: TextStyle(fontSize: 23, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
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
    required this.mySafetyStepScreenController,  this.fontSize = 15,  this.scale = 1,
  }) : super(key: key);
  final int index;
  final String normalText;
  final SafetyStepScreenController mySafetyStepScreenController;
  final double fontSize ;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
                () => Transform.scale(
                  scale: scale,
                  child: Checkbox(

              onChanged: (bool? value) {
                  mySafetyStepScreenController.changeValue(index, value!);
              },
              value: mySafetyStepScreenController.checkBoxesValue[index],
            ),
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
                    style: TextStyle(fontSize: fontSize, color: Color(0xff3b3b3b), fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "Full Policy".tr,
                    style: new TextStyle(color: Colors.blue , fontSize: fontSize),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepsScreenTitle(
          title: "The Standard For Safer Travel".tr,
          description: "",
          fontSize: 45,
        ),
        Center(
          child: Container(
            width: 250,
            height: 250,
            margin: EdgeInsets.only(right: 20),
            child: Image.asset(
              'assets/images/mask.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delta’s Commitment to You".tr,
                style: TextStyle(
                  color: Color(0xff424242),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: 70,
                width: 650,
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight.".tr,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Color(0xff5e5e5e),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
