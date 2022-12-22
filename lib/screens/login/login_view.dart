import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import '../../widgets/LanguagePicker.dart';
import '../../widgets/UserTextInput.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final LoginController loginController = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState loginState = context.watch<LoginState>();
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
              loginController: loginController,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/company-logo-light.png',
                            fit: BoxFit.fill,
                            height: 60,
                            width: 180,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/AppStore.png',
                                fit: BoxFit.fill,
                                height: 40,
                                width: 140,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Image.asset(
                                'assets/images/GooglePlayStore.png',
                                fit: BoxFit.fill,
                                height: 40,
                                width: 140,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Texts(),
                    ],
                  ),
                ),
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
    return Container(
      height: 710,
      width: 400,
      color: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LanguagePicker(
            // mainController: myEnterScreenController, // todo
            width: double.infinity,
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(),
                  SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Online Check-in".tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff424242),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Input Requested info in order to continue".tr,
                                style: const TextStyle(
                                  color: Color(0xff808080),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => SizedBox(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserTextInput(
                                  controller: loginState.lastNameC,
                                  hint: "Last Name".tr,
                                  errorText: "Last Name can't be empty".tr,
                                  isEmpty: loginState.isLastNameEmpty,
                                ),
                                UserTextInput(
                                  controller: loginState.bookingRefNameC,
                                  hint: "Booking reference name".tr,
                                  errorText: "Booking reference name can't be empty".tr,
                                  isEmpty: loginState.isBookingRefNameEmpty,
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        CheckInButton(
                          loginController: loginController,
                        )
                      ],
                    ),
                  ),
                  const CopyRightText(),
                ],
              ),
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
    return Container(
      height: 40,
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
        onPressed: () {
          loginController.login(context,username: "", password: "");
        },
        // onPressed: loginState.requesting
        //     ? null
        //     : () async {
        //         bool checkBoxesValidation = await loginController.checkBoxesValidation();
        //         if (checkBoxesValidation) {
        //           bool isValid = await loginController.loginValidation();
        //           if (isValid) {
        //             Get.toNamed(RouteNames.steps);
        //           } else {}
        //         }
        //       },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(
            const Color(0xff4c6ef6),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
        ),
        child: Text(
          "Check-in".tr,
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
          margin: const EdgeInsets.only(bottom: 20),
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
    // String languageCode = Get.locale!.languageCode; // todo
    String languageCode = "en";
    // String languageCode = "en";
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
    // String languageCode = Get.locale!.languageCode; // todo
    String languageCode = "en";
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
