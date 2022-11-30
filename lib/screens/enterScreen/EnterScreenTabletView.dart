
import 'package:flutter/material.dart';
import 'package:onlinecheckin/widgets/LanguagePicker.dart';
import '../../widgets/UserTextInput.dart';
import '../../screens/enterScreen/EnterScreenController.dart';
import '../../global/MainModel.dart';
import '../../utility/Constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EnterScreenTabletView extends StatelessWidget {
  final EnterScreenController myEnterScreenController;

  EnterScreenTabletView(MainModel model) : myEnterScreenController = Get.put(EnterScreenController(model));

  @override
  Widget build(BuildContext context) {
    // MainModel model = context.watch<MainModel>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackgroundImage(width: width, height: height),
            Foreground(
              width: width,
              height: height,
              myEnterScreenController: myEnterScreenController,
            ),
          ],
        ),
      ),
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({
    Key? key,
    required this.width,
    required this.height,
    required this.myEnterScreenController,
  }) : super(key: key);
  final double width;
  final double height;
  final EnterScreenController myEnterScreenController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LanguagePicker(
                textColor: Colors.white,
                mainController: myEnterScreenController,
                width: double.infinity,
              ),
              CheckInForm(myEnterScreenController: myEnterScreenController),
            ],
          ),
        ));
  }
}

class CheckInForm extends StatelessWidget {
  const CheckInForm({
    Key? key,
    required this.myEnterScreenController,
  }) : super(key: key);

  final EnterScreenController myEnterScreenController;

  @override
  Widget build(BuildContext context) {
    double height =   400 <= Get.height * 0.5 ? 400 : Get.height * 0.5;
    return Container(
      height: height,
      // width: 400,
      color: Colors.white,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Online Check-in".tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff424242),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "Input Requested info in order to continue".tr,
                              style: TextStyle(
                                color: Color(0xff808080),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Obx(
                        () => Container(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserTextInput(
                                controller: myEnterScreenController.lastNameC,
                                hint: "Last Name".tr,
                                errorText: "Last Name can't be empty".tr,
                                isEmpty: myEnterScreenController.isLastNameEmpty.value,
                                width: Get.width,
                              ),
                              UserTextInput(
                                controller: myEnterScreenController.bookingRefNameC,
                                hint: "Booking reference name".tr,
                                errorText: "Booking reference name can't be empty".tr,
                                isEmpty: myEnterScreenController.isBookingRefNameEmpty.value,
                                obscureText: true,
                                width: Get.width,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CheckInButton(
                        myEnterScreenController: myEnterScreenController,
                      )
                    ],
                  ),
                ),
                CopyRightText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffebebeb),
    );
  }
}

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    Key? key,
    required this.myEnterScreenController,
  }) : super(key: key);
  final EnterScreenController myEnterScreenController;

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeaeaea),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: ElevatedButton(
        onPressed: model.requesting
            ? null
            : () async {
                bool checkBoxesValidation = await myEnterScreenController.checkBoxesValidation();
                if (checkBoxesValidation) {
                  bool isValid = await myEnterScreenController.loginValidation();
                  if (isValid) {
                    Get.toNamed(RouteNames.steps);
                  } else {}
                }
              },
        child: Text(
          "Check-in".tr,
        ),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(
            Color(0xff4c6ef6),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CopyRightText extends StatelessWidget {
  const CopyRightText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text("© Copyright 2021 Abomis All rights reserved".tr),
        ),
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: width,
        height: height,
        child: Image.asset(
          'assets/images/abomis-bg.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class Texts extends StatelessWidget {
  const Texts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0),
      height: 295,
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ready to go?".tr,
                  style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "There are a few things to know before boarding.".tr,
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 48, bottom: 16, left: 5),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    MenuIcons.iconEvent,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 15),
                ),
                Text(
                  "When can I check in?".tr,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 42, left: 5),
            child: Text(
              "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.".tr,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PrevButton(),
                NextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0)),
      ),
      onPressed: null,
      child: Row(
        children: [
          Container(
            margin: languageCode == "en" ? EdgeInsets.only(right: 18) : EdgeInsets.only(left: 18),
            child: Text(
              "Next".tr,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          RotationTransition(
            turns: languageCode == "en" ? AlwaysStoppedAnimation(0 / 360) : AlwaysStoppedAnimation(180 / 360),
            child: Icon(
              MenuIcons.iconRight,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class PrevButton extends StatelessWidget {
  const PrevButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0)),
        ),
        onPressed: null,
        child: Row(
          children: [
            RotationTransition(
              turns: languageCode == "en" ? AlwaysStoppedAnimation(0 / 360) : AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                MenuIcons.iconLeft,
                color: Colors.white,
              ),
            ),
            Container(
              margin: languageCode == "en" ? EdgeInsets.only(left: 18) : EdgeInsets.only(right: 18),
              child: Text(
                "Previous".tr,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      margin: languageCode == "en" ? EdgeInsets.only(right: 85) : EdgeInsets.only(left: 85),
    );
  }
}
