import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/core/constants/assets.dart';
import 'package:online_check_in/core/utils/MultiLanguages.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/login/widgets/background_image.dart';
import 'package:online_check_in/screens/login/widgets/copyright_widget.dart';
import 'package:online_check_in/widgets/MyElevatedButton.dart';
import 'package:provider/provider.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import '../../widgets/LanguagePicker.dart';
import '../../widgets/MyDivider.dart';
import '../../widgets/UserTextInput.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginViewWeb extends StatelessWidget {
  LoginViewWeb({Key? key}) : super(key: key);
  final LoginController loginController = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState loginState = context.watch<LoginState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackgroundImage(width: width, height: height),
            Positioned(
              left: 0,
              top: 0,
              child: Foreground(
                width: width,
                height: height,
                loginController: loginController,
              ),
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
    return Container(
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
                        AssetImages.lightCompanyLogo,
                        fit: BoxFit.fill,
                        height: 60,
                        width: 180,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AssetImages.appStore,
                            fit: BoxFit.fill,
                            height: 40,
                            width: 140,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            AssetImages.googlePlayStore,
                            fit: BoxFit.fill,
                            height: 40,
                            width: 140,
                          ),
                        ],
                      )
                    ],
                  ),
                  const _Texts(),
                ],
              ),
            ),
          ),
          CheckInForm(loginController: loginController),
        ],
      ),
    );
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
      color: MyColors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LanguagePicker(
            width: double.infinity,
          ),
          const MyDivider(),
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
                              "Online Check-in".translate(context),
                              style: MyTextTheme.boldDarkGray18,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child:  Text(
                                "Input Requested info in order to continue".translate(context),
                                style: TextStyle(
                                  color: MyColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserTextInput(
                                controller: loginState.lastNameC,
                                hint: "Last Name".translate(context),
                                errorText: "Last Name can't be empty".translate(context),
                                isEmpty: loginState.isLastNameEmpty,
                              ),
                              UserTextInput(
                                controller: loginState.bookingRefNameC,
                                hint: "Booking reference name".translate(context),
                                errorText: "Booking reference name can't be empty".translate(context),
                                isEmpty: loginState.isBookingRefNameEmpty,
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        MyElevatedButton(
                          height: 40,
                          width: double.infinity,
                          buttonText: loginState.requesting ? "" : "Check-in",
                          bgColor: MyColors.myBlue,
                          fgColor: MyColors.white,
                          isLoading: loginState.requesting,
                          function: () => loginController.login(username: "", password: ""),
                          textColor: MyColors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderColor: MyColors.white1,
                        )
                      ],
                    ),
                  ),
                  const CopyrightText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Texts extends StatelessWidget {
  const _Texts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  "Ready to go?".translate(context),
                  style: MyTextTheme.boldWhite24,
                ),
                Text(
                  "There are a few things to know before boarding.".translate(context),
                  style: MyTextTheme.boldWhite16,
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
                    color: MyColors.white,
                  ),
                ),
                Text(
                  "When can I check in?".translate(context),
                  style: MyTextTheme.white16,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 42, left: 5),
            child: Text(
              "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.".translate(context),
              style: MyTextTheme.white12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              _NextPrevButton(
                icon: MenuIcons.iconLeft,
                text: "Previous".translate(context),
              ),
              _NextPrevButton(
                icon: MenuIcons.iconRight,
                text: "Next".translate(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextPrevButton extends StatelessWidget {
  const _NextPrevButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    String languageCode = MultiLanguages.of(context)!.locale.languageCode;
    return Container(
      margin: languageCode == "en" ? const EdgeInsets.only(right: 85) : const EdgeInsets.only(left: 85),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        onPressed: null,
        child: Row(
          children: [
            RotationTransition(
              turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                icon,
                color: MyColors.white,
              ),
            ),
            Container(
              margin: languageCode == "en" ? const EdgeInsets.only(left: 18) : const EdgeInsets.only(right: 18),
              child: Text(
                text,
                style: MyTextTheme.white12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
