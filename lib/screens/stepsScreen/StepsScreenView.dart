import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/widgets/UserTextInput.dart';
import '../../screens/seatsStepScreen/SeatsStepView.dart';
import '../../screens/paymentStepScreen/PaymentStepView.dart';
import '../../screens/receiptStepScreen/ReceipStepView.dart';
import '../../screens/upgradesStepScreen/UpgradesStepView.dart';
import '../../screens/passportStepScreen/PassportStepView.dart';
import '../../screens/rulesStepScreen/RulesStepView.dart';
import '../../screens/visaStepScreen/VisaStepView.dart';
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

  StepsScreenView(MainModel model) : myStepsScreenController = Get.put(StepsScreenController(model));

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    // double width = Get.width;
    // double height = Get.height;
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
                  TopOfPage(height: height, width: width),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => LeftSideOFPage(
                            height: height,
                            step: myStepsScreenController.step,
                            myStepsScreenController: myStepsScreenController,
                          ),
                        ),
                        Obx(
                          () => Container(
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
                                    for (int i = 0; i <= 8; i++) StepWidget(step: myStepsScreenController.step, index: i),
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
                                  padding: EdgeInsets.only(top: 50, left: 30, right: 30),
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
                                                      : myStepsScreenController.step == 5
                                                          ? UpgradesStepView(model)
                                                          : myStepsScreenController.step == 6
                                                              ? SeatsStepView(model)
                                                              : myStepsScreenController.step == 7
                                                                  ? PaymentStepView(model)
                                                                  : myStepsScreenController.step == 8
                                                                      ? ReceiptStepView(model)
                                                                      : Container(),
                                ),
                                BottomOfPage(height: height, myStepsScreenController: myStepsScreenController),
                              ],
                            ),
                          ),
                        ),
                      ],
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
    required this.step,
    required this.myStepsScreenController,
  }) : super(key: key);

  final double height;
  final int step;
  final StepsScreenController myStepsScreenController;

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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWidget(
                    title: "Travellers",
                    width: 190,
                  ),
                  if (myStepsScreenController.step == 6)
                    Container(
                      width: 112,
                      child: Row(
                        children: [
                          Container(
                            width: 2,
                            height: double.infinity,
                            color: Color(0xffededed),
                          ),
                          TitleWidget(
                            title: "Seat",
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffeaeaea),
            ),
            Obx(
              () => Container(
                height: height * 0.9 - 65 - 13.5,
                child: ListView.builder(
                  itemCount: myStepsScreenController.travellers.length,
                  itemBuilder: (ctx, index) => TravellerItem(
                    step: step,
                    index: index,
                    myStepsScreenController: myStepsScreenController,
                  ),
                ),
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
  const TravellerItem({
    Key? key,
    required this.step,
    required this.index,
    required this.myStepsScreenController,
  }) : super(key: key);
  final int step;
  final int index;
  final StepsScreenController myStepsScreenController;

  @override
  Widget build(BuildContext context) {
    bool isTravellerSelected = myStepsScreenController.travellers[index].seatId == "--" ? false : true;
    return Expanded(
      child: Obx(
        () => Container(
          color: myStepsScreenController.whoseTurnToSelect.value == index && step == 6 ? const Color(0xffffae2c).withOpacity(0.5) : Colors.white,
          height: 60,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        myStepsScreenController.travellers[index].lastName,
                        style: TextStyle(
                          color: Color(0xff424242),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    step == 0
                        ? IconButton(
                            onPressed: () => myStepsScreenController.removeFromTravellers(index),
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          )
                        : step == 6
                            ? Container(
                                width: 112,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 2,
                                      height: double.infinity,
                                      color: Color(0xffededed),
                                    ),
                                    myStepsScreenController.whichOneToEdit == index
                                        ? Row(
                                            children: [
                                              Container(
                                                width: 45,
                                                color: Colors.grey,
                                                child: TextField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  controller: myStepsScreenController.editSeatC,
                                                  maxLength: 3,
                                                  decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.all(10.0), border: InputBorder.none, counterText: "", hintText: myStepsScreenController.travellers[index].seatId),
                                                ),
                                              ),
                                              Container(
                                                width: 30,
                                                child: IconButton(onPressed: () {
                                                  myStepsScreenController.setWhichOneToEdit(-1);
                                                  myStepsScreenController.changeTravellerSeat(index);
                                                }, icon: Icon(Icons.check), color: Colors.green),
                                              ),
                                              Container(
                                                width: 30,
                                                child: IconButton(
                                                  onPressed: () {
                                                    myStepsScreenController.setWhichOneToEdit(-1);
                                                  },
                                                  icon: Icon(Icons.close),
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              TitleWidget(
                                                title: myStepsScreenController.travellers[index].seatId,
                                                width: 75,
                                                textColor: isTravellerSelected ? Color(0xff48c0a2) : Color(0xff424242),
                                              ),
                                              Container(
                                                width: 35,
                                                child: IconButton(
                                                  onPressed: () {
                                                    myStepsScreenController.setWhichOneToEdit(index);
                                                  },
                                                  icon: Icon(Icons.edit),
                                                  color: myStepsScreenController.whichOneToEdit == index ? Colors.green : Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              )
                            : Container(),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0xffeaeaea),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SeatWidget extends StatelessWidget {
//   const SeatWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: 100,
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         border: BorderDirectional(
//           bottom: BorderSide(
//             width: 1,
//             color: Color(0xffeaeaea),
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "5E",
//             style: TextStyle(
//               fontSize: 20,
//               color: Color(0xfff5ad2f),
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.edit,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    required this.width,
    this.textColor = const Color(0xff424242),
  }) : super(key: key);

  final String title;
  final double width;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
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
        'assets/images/company-logo-blue.png',
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
        sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
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
    required this.myStepsScreenController,
  }) : super(key: key);

  final double height;
  final StepsScreenController myStepsScreenController;

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
            PreviousButton(
              myStepsScreenController: myStepsScreenController,
            ),
            Obx(
              () => myStepsScreenController.step == 8
                  ? ReceiptStepButtons()
                  : MyElevatedButton(
                      height: 40,
                      width: 300,
                      buttonText: myStepsScreenController.buttonText[myStepsScreenController.step],
                      bgColor: Color(0xff4c6ef6),
                      fgColor: Colors.white,
                      function: myStepsScreenController.increaseStep,
                      isDisable: myStepsScreenController.isNextButtonDisable,
                    ),
            ),
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
            buttonText: "Download",
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
            buttonText: "Print",
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
            buttonText: "Sent to Mobile",
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
  }) : super(key: key);
  final StepsScreenController myStepsScreenController;

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
        onPressed: () {
          int currStep = myStepsScreenController.step;
          if (currStep > 0) {
            myStepsScreenController.setStep(currStep - 1);
          }
        },
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
