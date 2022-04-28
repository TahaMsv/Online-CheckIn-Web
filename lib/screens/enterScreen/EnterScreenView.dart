import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../widgets/CustomFlutterWidget.dart';
import '../../widgets/UserTextInput.dart';
import '../../widgets/CountryListPicker/country.dart';
import '../../widgets/CountryListPicker/country_picker_dropdown.dart';
import '../../widgets/CountryListPicker/utils/utils.dart';
import '../../screens/enterScreen/EnterScreenController.dart';
import '../../global/MainModel.dart';
import '../../utility/Constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flash/flash.dart';

class EnterScreenView extends StatelessWidget {
  final EnterScreenController myEnterScreenController;

  EnterScreenView(MainModel model) : myEnterScreenController = Get.put(EnterScreenController(model));

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    // double width = Get.width;
    // double height = Get.height;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.blue,
      // ),
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
                      Container(
                        child: Row(
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
                                SizedBox(
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
                      ),
                      Texts(),
                    ],
                  ),
                ),
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
    return Container(
      height: 710,
      width: 400,
      color: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LanguagePicker(),
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(),
                  Container(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Online Check-in",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff424242),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                "Input Requested info in order to continue",
                                style: TextStyle(
                                  color: Color(0xff808080),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // UserTextInput(
                                //   controller: myEnterScreenController.firstNameC,
                                //   hint: "First Name",
                                //   errorText: "First Name can't be empty",
                                //   isEmpty: myEnterScreenController.isFirstNameEmpty.value,
                                // ),
                                UserTextInput(
                                  controller: myEnterScreenController.lastNameC,
                                  hint: "Last Name",
                                  errorText: "Last Name can't be empty",
                                  isEmpty: myEnterScreenController.isLastNameEmpty.value,
                                ),
                                UserTextInput(
                                  controller: myEnterScreenController.bookingRefNameC,
                                  hint: "Booking reference name",
                                  errorText: "Booking reference name can't be empty",
                                  isEmpty: myEnterScreenController.isBookingRefNameEmpty.value,
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
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

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CountryPickerDropdown(
        initialValue: 'GB-NIR',
        itemBuilder: _buildDropdownItem,
        // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
        priorityList: [
          CountryPickerUtils.getCountryByIsoCode('GB'),
          CountryPickerUtils.getCountryByIsoCode('CN'),
        ],
        sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
        onValuePicked: (Country country) {
          print("${country.name}");
        },
      ),
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
                  } else {

                  }
                }
              },
        child: Text("Check-in"),
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
        Container(margin: EdgeInsets.only(bottom: 20), child: Text("© Copyright 2021 Abomis All rights reserved")),
      ],
    );
  }
}

Widget _buildDropdownItem(Country country) => Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}(${country.isoCode})"),
        ],
      ),
    );

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
                  "Ready to go?",
                  style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "There are a few things to know before boarding.",
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
                  "When can I check in?",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 42, left: 5),
            child: Text(
              "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.",
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
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0)),
      ),
      onPressed: null,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 18),
            child: Text(
              "Next",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Icon(
            MenuIcons.iconRight,
            color: Colors.white,
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
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0)),
        ),
        onPressed: null,
        child: Row(
          children: [
             Icon(
                MenuIcons.iconLeft,
                color: Colors.white,
              ),

            Container(
              margin: EdgeInsets.only(left: 18),
              child: Text(
                "Previous",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.only(right: 85),
    );
  }
}
