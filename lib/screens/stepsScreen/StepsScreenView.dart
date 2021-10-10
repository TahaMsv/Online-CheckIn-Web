import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/screens/passportStepScreen/PassportStepView.dart';
import 'package:onlinecheckin/screens/rulesStepScreen/RulesStepView.dart';
import 'package:onlinecheckin/screens/visaStepScreen/VisaStepView.dart';
import '../../screens/safetyStepScreen/SafetyStepView.dart';
import '../../screens/travellersStepScreen/TravellersStepView.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../widgets/CountryListPicker/country.dart';
import '../../widgets/CountryListPicker/country_picker_dropdown.dart';
import '../../widgets/CountryListPicker/utils/utils.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StepsScreenView extends StatelessWidget {
  final StepsScreenController myStepsScreenController;

  StepsScreenView(MainModel model)
      : myStepsScreenController = Get.put(StepsScreenController(model));

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    // double width = Get.width;
    // double height = Get.height;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: ListView(
          children: [
            TopOfPage(height: height, width: width),
            Expanded(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftSideOFPage(height: height),
                    Container(
                      width: width * 0.80,
                      height: height * 0.9,
                      child: Column(
                        children: [
                          Row(
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
                                StepWidget(
                                    step: myStepsScreenController.step,
                                    index: i),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Color(0xffdbdbdb),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            height: height * 0.77,
                            padding: EdgeInsets.symmetric(
                                vertical: 50, horizontal: 30),
                            child: myStepsScreenController.step == 0
                                ? TravellersStepView(model)
                                : myStepsScreenController.step == 1
                                    ? SafetyStepView(model)
                                    : myStepsScreenController.step == 2
                                        ? RulesStepView(model)
                                        : myStepsScreenController.step == 3
                                            ? PassportStepView(model)
                                            : myStepsScreenController.step == 4
                                                ? VisaStepView(model)
                                                : Container(),
                          ),
                          BottomOfPage(height: height),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
  }) : super(key: key);

  final int step;
  final int index;

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
    Icons.person_pin,
    Icons.person_pin,
    Icons.person_pin,
    Icons.person_pin,
    Icons.person_pin,
    Icons.person_pin,
    Icons.person_pin,
    Icons.person_pin,
    Icons.person_pin,
  ];

  var bgColor;
  var frColor;
  var borderColor;

  @override
  Widget build(BuildContext context) {
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
          child: Row(
            children: [
              Icon(
                icons[index],
                size: 15,
                color: frColor,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                titles[index],
                style: TextStyle(color: frColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeftSideOFPage extends StatelessWidget {
  const LeftSideOFPage({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.rectangle,
        ),
        margin: EdgeInsets.only(top: 13.5),
        height: height * 0.9 - 13.5,
        child: Column(
          children: [
            TravellersTitleWidget(),
            Container(
              height: height * 0.9 - 65 - 13.5,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (ctx, index) => TravellerItem(),
              ),
            ),
          ],
        ),
        // color: Colors.red,
      ),
    );
  }
}

class TravellerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            width: 1,
            color: Color(0xffeaeaea),
          ),
        ),
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Mr. Jack Taylor",
              style: TextStyle(
                color: Color(0xff424242),
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TravellersTitleWidget extends StatelessWidget {
  const TravellersTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            width: 1,
            color: Color(0xffeaeaea),
          ),
        ),
      ),
      child: Text(
        "Travellers",
        style: TextStyle(
          color: Color(0xff424242),
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TopOfPage extends StatelessWidget {
  const TopOfPage({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AbomisLogo(),
            LanguagePicker(),
          ],
        ),
      ),
    );
  }
}

class AbomisLogo extends StatelessWidget {
  const AbomisLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/abomis-logo.png',
        fit: BoxFit.fill,
      ),
      height: 60,
      width: 160,
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
      width: 200,
      child: CountryPickerDropdown(
        initialValue: 'GB-NIR',
        itemBuilder: _buildDropdownItem,
        // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
        priorityList: [
          CountryPickerUtils.getCountryByIsoCode('GB'),
          CountryPickerUtils.getCountryByIsoCode('CN'),
        ],
        sortComparator: (Country a, Country b) =>
            a.isoCode.compareTo(b.isoCode),
        onValuePicked: (Country country) {
          print("${country.name}");
        },
      ),
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

class BottomOfPage extends StatelessWidget {
  const BottomOfPage({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.rectangle,
        ),
        // height: height * 0.13,
        padding: EdgeInsets.symmetric(horizontal: 20),
        // color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PreviousButton(),
            MyElevatedButton(
              height: 40,
              width: 300,
              buttonText: "Check Pandemic Safety",
              bgColor: Color(0xff4c6ef6),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 0),
          ),
        ),
        onPressed: null,
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_left,
              color: Color(0xff767676),
            ),
            Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                "Previous",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff767676),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
