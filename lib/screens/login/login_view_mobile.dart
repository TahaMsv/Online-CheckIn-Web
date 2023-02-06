import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/login/widgets/background_image.dart';
import 'package:online_check_in/screens/login/widgets/copyright_widget.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/LanguagePicker.dart';
import '../../widgets/MyElevatedButton.dart';
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
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackgroundImage(width: width, height: height),
            Positioned(
              left: 0,
              top: 0,
              child: Foreground(width: width, height: height),
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
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          LanguagePicker(
              textColor: MyColors.white,
              // mainController: loginController, // rodo
              width: double.infinity),
          SizedBox(
            height: 40,
          ),
          CheckInForm(),
        ],
      ),
    );
  }
}

class CheckInForm extends StatelessWidget {
  const CheckInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = getIt<LoginController>();

    LoginState loginState = context.watch<LoginState>();
    double height = 320 <= Get.height * 0.5 ? 320 : Get.height * 0.5;
    return Container(
      height: height,
      // width: 400,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white),

      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      children: const [
                        Text("Online Check-in", style: MyTextTheme.boldDarkGray18),
                        SizedBox(height: 10),
                        Text("Input Requested info in order to continue", style: MyTextTheme.boldDarkGray12),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserTextInput(
                          height: 40,
                          fontSize: 17,
                          controller: loginState.lastNameC,
                          hint: "Last Name",
                          errorText: "Last Name can't be empty",
                          isEmpty: loginState.isLastNameEmpty,
                          width: Get.width,
                        ),
                        const SizedBox(height: 20),
                        UserTextInput(
                          height: 40,
                          fontSize: 17,
                          controller: loginState.bookingRefNameC,
                          hint: "Booking reference name",
                          errorText: "Booking reference name can't be empty",
                          isEmpty: loginState.isBookingRefNameEmpty,
                          obscureText: true,
                          width: Get.width,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MyElevatedButton(
                      height: 45,
                      width: double.infinity,
                      buttonText: "Check-in",
                      bgColor: MyColors.myBlue,
                      fgColor: MyColors.white,
                      fontSize: 17,
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
                const SizedBox(
                  height: 15,
                ),
                const CopyrightText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}