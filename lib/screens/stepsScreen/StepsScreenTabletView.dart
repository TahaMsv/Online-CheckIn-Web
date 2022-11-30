import 'package:flutter/material.dart';
import 'package:onlinecheckin/screens/rulesStepScreen/RulesStepTabletView.dart';
import 'package:onlinecheckin/screens/safetyStepScreen/SafetyStepTabletView.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import 'package:onlinecheckin/widgets/LanguagePicker.dart';
import '../../screens/seatsStepScreen/SeatStepScreenView.dart';

import '../../screens/paymentStepScreen/PaymentStepView.dart';
import '../../screens/receiptStepScreen/ReceipStepView.dart';
import '../../screens/upgradesStepScreen/UpgradesStepView.dart';
import '../../screens/passportStepScreen/PassportStepView.dart';
import '../../screens/rulesStepScreen/RulesStepView.dart';
import '../../screens/visaStepScreen/VisaStepView.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../passportStepScreen/PassportStepTabletView.dart';
import '../travellersStepScreen/TravellerStepScreenTabletView.dart';
import '../upgradesStepScreen/UpgradeStepTabletView.dart';
import '../visaStepScreen/VisaStepScreenTabletView.dart';

class StepsScreenTabletView extends StatelessWidget {
  final StepsScreenController myStepsScreenController;

  StepsScreenTabletView(MainModel model) : myStepsScreenController = Get.put(StepsScreenController(model));

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: model.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: width,
              height: height,
              color: Colors.white,
              child: ListView(
                children: [
                  TopOfPage(
                    height: height,
                    width: width,
                    stepsScreenController: myStepsScreenController,
                  ),

                  // Obx(
                  //   () =>
                  Container(
                    width: width,
                    height: height * 0.81,
                    // color: Colors.green,
                    child: ListView(
                      children: [
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: myStepsScreenController.step == 0
                                    ? MyDottedLine(
                                        lineLength: double.infinity,
                                        color: Color(0xff48c0a2),
                                      )
                                    : Container(
                                        height: 1,
                                        color: Color(0xff48c0a2),
                                      ),
                              ),
                              for (int i = 0; i <= 8; i++)
                                if (myStepsScreenController.isStepNeeded(i))
                                  StepWidget(
                                    step: myStepsScreenController.step,
                                    index: i,
                                    // checkDocs: myStepsScreenController.welcome!.body.flight[0].checkDocs,
                                  ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Color(0xffdbdbdb),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => Container(
                            color: Colors.white,
                            height: height * 0.80 - 30,
                            padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                            child: myStepsScreenController.step == 0
                                ? TravellersStepTabletView(model)
                                : myStepsScreenController.step == 1
                                    ? SafetyStepTabletView(model)
                                    : myStepsScreenController.step == 2
                                        ? RulesStepTabletView(model)
                                        : myStepsScreenController.step == 3
                                            ? PassportStepTabletView(model)
                                            : myStepsScreenController.step == 4
                                                ? VisaStepTabletView(model)
                                                : myStepsScreenController.step == 5
                                                    ? UpgradesStepTabletView(model)
                                                    : myStepsScreenController.step == 6
                                                        ? SeatsStepView(model)
                                                        : myStepsScreenController.step == 7
                                                            ? PaymentStepView(model)
                                                            : myStepsScreenController.step == 8
                                                                ? ReceiptStepView(model)
                                                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  BottomOfPage(height: height, myStepsScreenController: myStepsScreenController),
                ],
              ),
            ),
    );
  }
}

class StepWidget extends StatelessWidget {
  StepWidget({
    Key? key,
    required this.step,
    required this.index,
    // required this.checkDocs,
  }) : super(key: key);

  final int step;
  final int index;

  // final int checkDocs;

  static const titles = [
    "Travellers",
    "Safety",
    "Rules",
    "Passport",
    "Visa",
    "Upgrades",
    "Seats",
    "Payment",
    "Receipt",
  ];

  static const List<IconData> icons = [
    MenuIcons.iconAccount,
    Icons.health_and_safety,
    MenuIcons.iconInfo,
    MenuIcons.iconPassport,
    MenuIcons.iconVisa,
    MenuIcons.star,
    MenuIcons.iconSeat,
    MenuIcons.iconCard,
    MenuIcons.iconTask,
  ];

  @override
  Widget build(BuildContext context) {
    var bgColor;
    var frColor;
    var borderColor;
    if (step < index) {
      bgColor = Color(0xffffffff);
      frColor = Color(0xffdbdbdb);
      borderColor = Color(0xffdbdbdb);
    } else if (step == index) {
      bgColor = Color(0xffffffff);
      frColor = Color(0xff48c0a2);
      borderColor = Color(0xff48c0a2);
    } else {
      bgColor = Color(0xff48c0a2);
      frColor = Color(0xffffffff);
      borderColor = Color(0xff48c0a2);
    }

    return Row(
      children: [
        step == index
            ? MyDottedLine(
                lineLength: 25,
                color: Color(0xff48c0a2),
              )
            : Container(
                height: 1,
                width: 25,
                color: step <= index ? Color(0xffdbdbdb) : Color(0xff48c0a2),
              ),
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Icon(
            icons[index],
            size: 30,
            color: frColor,
          ),
        ),
      ],
    );
  }
}

class TopOfPage extends StatelessWidget {
  const TopOfPage({
    Key? key,
    required this.height,
    required this.width,
    required this.stepsScreenController,
  }) : super(key: key);

  final double height;
  final double width;
  final StepsScreenController stepsScreenController;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    return Container(
      height: height * 0.07,
      width: width,
      // color: Colors.red,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // AbomisLogo(),
            LanguagePicker(
              mainController: stepsScreenController,
              width: 200,
              initialValue: languageCode == 'en' ? "GB" : "IR",
            ),
          ],
        ),
      ),
    );
  }
}

class BottomOfPage extends StatelessWidget {
  const BottomOfPage({
    Key? key,
    required this.height,
    required this.myStepsScreenController,
  }) : super(key: key);

  final double height;
  final StepsScreenController myStepsScreenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
          color: Colors.grey,
        )),
        // border: Border.all(color: Colors.black.withOpacity(0.1)),
        shape: BoxShape.rectangle,
        // color: Colors.red
      ),
      height: height * 0.1,
      padding: EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.grey,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myStepsScreenController.step == 0
                ? Container()
                : PreviousButton(
                    height: height * 0.06,
                    myStepsScreenController: myStepsScreenController,
                    isDisable: !myStepsScreenController.isPreviousButtonEnable,
                  ),
            myStepsScreenController.step == 8
                ? ReceiptStepButtons()
                : Obx(
                    () => MyElevatedButton(
                      height: height * 0.06,
                      width: 300,
                      buttonText: myStepsScreenController.buttonsText[myStepsScreenController.currButtonTextIndex.value],
                      fontSize: 20,
                      bgColor: Color(0xff4c6ef6),
                      fgColor: Colors.white,
                      function: myStepsScreenController.increaseStep,
                      isDisable: !myStepsScreenController.isNextButtonEnable,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class ReceiptStepButtons extends StatelessWidget {
  const ReceiptStepButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          MyElevatedButton(
            height: 40,
            width: 100,
            buttonText: "Download".tr,
            bgColor: Color(0xff424242),
            fgColor: Colors.white,
            function: () {},
          ),
          SizedBox(
            width: 15,
          ),
          MyElevatedButton(
            height: 40,
            width: 100,
            buttonText: "Print".tr,
            bgColor: Color(0xff48c0a2),
            fgColor: Colors.white,
            function: () {},
          ),
          SizedBox(
            width: 15,
          ),
          MyElevatedButton(
            height: 40,
            width: 200,
            buttonText: "Sent to Mobile".tr,
            bgColor: Color(0xff4c6ef6),
            fgColor: Colors.white,
            function: () {},
          ),
        ],
      ),
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key? key,
    required this.myStepsScreenController,
    required this.isDisable,
    required this.height,
  }) : super(key: key);
  final StepsScreenController myStepsScreenController;
  final bool isDisable;
  final double height;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    return Container(
      height: height,
      width: 200,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 0),
          ),
        ),
        onPressed: () {
          if (!isDisable) {
            myStepsScreenController.decreaseStep();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RotationTransition(
              turns: languageCode == "en" ? AlwaysStoppedAnimation(0 / 360) : AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                MenuIcons.iconLeftArrow,
                color: isDisable ? Color(0xff767676).withOpacity(0.5) : Color(0xff767676),
                size: 20,
              ),
            ),
            Container(
              margin: languageCode == "en" ? EdgeInsets.only(left: 4) : EdgeInsets.only(right: 4),
              child: Text(
                "Previous".tr,
                style: TextStyle(
                  fontSize: 20,
                  color: isDisable ? Color(0xff767676).withOpacity(0.5) : Color(0xff767676),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
