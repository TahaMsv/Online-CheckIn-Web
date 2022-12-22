
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/route_names.dart';
import '../../core/constants/ui.dart';
import 'package:provider/provider.dart';

import '../../core/dependency_injection.dart';
import '../../widgets/LanguagePicker.dart';
import '../../widgets/UserTextInput.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginViewTablet extends StatelessWidget {
  LoginViewTablet({Key? key}) : super(key: key);
  final LoginController loginController = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState loginState = context.watch<LoginState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              BackgroundImage(width: width, height: height),
              Foreground(
                width: width,
                height: height,
                loginController: loginController,
              ),
            ],
          ),
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
    required this.loginController,
  }) : super(key: key);
  final double width;
  final double height;
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LanguagePicker(
                textColor: Colors.white,
                // mainController: loginController, // rodo
                width: double.infinity,
              ),
              CheckInForm(loginController: loginController),
            ],
          ),
        ));
  }
}

class CheckInForm extends StatelessWidget {
  const CheckInForm({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    LoginState loginState = context.watch<LoginState>();
    double height = 500 <= Get.height * 0.5 ? 500 : Get.height * 0.5;
    return Container(
      height: height,
      // width: 400,
      color: Colors.white,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Online Check-in".tr,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff424242),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Input Requested info in order to continue".tr,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xff808080),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserTextInput(
                                height: 60,
                                fontSize: 25,
                                controller: loginState.lastNameC,
                                hint: "Last Name".tr,
                                errorText: "Last Name can't be empty".tr,
                                isEmpty: loginState.isLastNameEmpty,
                                width: Get.width,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              UserTextInput(
                                height: 60,
                                fontSize: 25,
                                controller: loginState.bookingRefNameC,
                                hint: "Booking reference name".tr,
                                errorText: "Booking reference name can't be empty".tr,
                                isEmpty: loginState.isBookingRefNameEmpty,
                                obscureText: true,
                                width: Get.width,
                              ),
                            ],
                          ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CheckInButton(
                      loginController: loginController,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const CopyRightText(),
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
      color: const Color(0xffebebeb),
    );
  }
}

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    Key? key,
    required this.loginController,
  }) : super(key: key);
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {

    LoginState loginState = context.watch<LoginState>();
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffeaeaea),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: ElevatedButton(
        onPressed: loginState.requesting
            ? null
            : () async {
          loginState.setRequesting(true);
          bool checkBoxesValidation = await loginController.checkBoxesValidation();
          if (checkBoxesValidation) {
            bool isValid = await loginController.loginValidation();
            if (isValid) {
              Get.toNamed(RouteNames.steps);
            } else {}
          }
          loginState.setRequesting(false);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(
            loginState.requesting ? const Color(0xff4c6ef6).withOpacity(0.5) : const Color(0xff4c6ef6),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
        ),
        child: Text(
          "Check-in".tr,
          style: const TextStyle(fontSize: 25),
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
        Text(
          "© Copyright 2021 Abomis All rights reserved".tr,
          style: const TextStyle(fontSize: 20),
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
      child: SizedBox(
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
            margin: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ready to go?".tr,
                  style: const TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "There are a few things to know before boarding.".tr,
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48, bottom: 16, left: 5),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: const Icon(
                    MenuIcons.iconEvent,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "When can I check in?".tr,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 42, left: 5),
            child: Text(
              "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.".tr,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              PrevButton(),
              NextButton(),
            ],
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
            margin: languageCode == "en" ? const EdgeInsets.only(right: 18) : const EdgeInsets.only(left: 18),
            child: Text(
              "Next".tr,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          RotationTransition(
            turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
            child: const Icon(
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
      margin: languageCode == "en" ? const EdgeInsets.only(right: 85) : const EdgeInsets.only(left: 85),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0)),
        ),
        onPressed: null,
        child: Row(
          children: [
            RotationTransition(
              turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
              child: const Icon(
                MenuIcons.iconLeft,
                color: Colors.white,
              ),
            ),
            Container(
              margin: languageCode == "en" ? const EdgeInsets.only(left: 18) : const EdgeInsets.only(right: 18),
              child: Text(
                "Previous".tr,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
