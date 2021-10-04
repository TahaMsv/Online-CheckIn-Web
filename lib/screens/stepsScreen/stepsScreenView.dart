import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/screens/stepsScreen/stepsScreenController.dart';
import 'package:onlinecheckin/widgets/CountryListPicker/country.dart';
import 'package:onlinecheckin/widgets/CountryListPicker/country_picker_dropdown.dart';
import 'package:onlinecheckin/widgets/CountryListPicker/utils/utils.dart';
import '../../global/MainModel.dart';
import '../../utility/Constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.blue,
      // ),
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
                    children: [
                      LeftSideOFPage(height: height),
                      Container(
                        width: width * 0.80,
                        child: Column(children: [
                          Container(
                            height: height * 0.77,
                            child: Center(),
                          ),
                          BottomOfPage(height: height),
                        ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
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
        height: height * 0.9,
        child: Column(
          children: [
            TravellersTitleWidget(),
            Container(
              height: height * 0.9 - 65,
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        shape: BoxShape.rectangle,
      ),
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        shape: BoxShape.rectangle,
      ),
      height: height * 0.13,
      padding: EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PreviousButton(),
          CheckPandemicButton(),
        ],
      ),
    );
  }
}

class CheckPandemicButton extends StatelessWidget {
  const CheckPandemicButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      child: ElevatedButton(
        onPressed: null,
        child: Text("Check Pandemic Safety"),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Color(0xff4c6ef6)),
            textStyle:
                MaterialStateProperty.all(TextStyle(color: Colors.white))),
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
