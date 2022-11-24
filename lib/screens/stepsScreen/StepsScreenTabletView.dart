import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/screens/enterScreen/EnterScreenController.dart';
import 'package:onlinecheckin/screens/travellersStepScreen/NewTravellersStepScreen.dart';
import 'package:onlinecheckin/screens/travellersStepScreen/TravellersStepController.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import 'package:onlinecheckin/widgets/LanguagePicker.dart';
import 'package:onlinecheckin/widgets/UserTextInput.dart';
import '../../screens/seatsStepScreen/SeatStepScreenView.dart';

import '../../screens/paymentStepScreen/PaymentStepView.dart';
import '../../screens/receiptStepScreen/ReceipStepView.dart';
import '../../screens/upgradesStepScreen/UpgradesStepView.dart';
import '../../screens/passportStepScreen/PassportStepView.dart';
import '../../screens/rulesStepScreen/RulesStepView.dart';
import '../../screens/visaStepScreen/VisaStepView.dart';
import '../../screens/safetyStepScreen/SafetyStepView.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../widgets/CountryListPicker/country.dart';
import '../../widgets/CountryListPicker/country_picker_dropdown.dart';
import '../../widgets/CountryListPicker/utils/utils.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'StepsScreenView.dart';

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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Obx(
                        //       () =>
                        Container(
                          height: height * 0.4,
                          color: Colors.green,
                          //         Container(
                          //   width: width * 0.80,
                          //   height: height * 0.4,
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Expanded(
                          //             child: myStepsScreenController.step == 0
                          //                 ? MyDottedLine(
                          //               lineLength: double.infinity,
                          //               color: Color(0xff48c0a2),
                          //             )
                          //                 : Container(
                          //               height: 1,
                          //               color: Color(0xff48c0a2),
                          //             ),
                          //           ),
                          //           for (int i = 0; i <= 8; i++)
                          //             if (myStepsScreenController.isStepNeeded(i))
                          //               StepWidget(
                          //                 step: myStepsScreenController.step,
                          //                 index: i,
                          //                 checkDocs: myStepsScreenController.welcome!.body.flight[0].checkDocs,
                          //               ),
                          //           Expanded(
                          //             child: Container(
                          //               height: 1,
                          //               color: Color(0xffdbdbdb),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Container(
                          //         color: Colors.white,
                          //         height: height * 0.77,
                          //         padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                          //         child: myStepsScreenController.step == 0
                          //             ? TravellersStepView(model)
                          //             : myStepsScreenController.step == 1
                          //             ? SafetyStepView(model)
                          //             : myStepsScreenController.step == 2
                          //             ? RulesStepView(model)
                          //             : myStepsScreenController.step == 3
                          //             ? PassportStepView(model)
                          //             : myStepsScreenController.step == 4
                          //             ? VisaStepView(model)
                          //             : myStepsScreenController.step == 5
                          //             ? UpgradesStepView(model)
                          //             : myStepsScreenController.step == 6
                          //             ? SeatsStepView(model)
                          //             : myStepsScreenController.step == 7
                          //             ? PaymentStepView(model)
                          //             : myStepsScreenController.step == 8
                          //             ? ReceiptStepView(model)
                          //             : Container(),
                          //       ),
                          //       BottomOfPage(height: height, myStepsScreenController: myStepsScreenController),
                          //     ],
                          //   ),
                          // ),
                        ),
                        Obx(
                          () => TravellersList(
                            height: height * 0.4,
                            width: width,
                            step: myStepsScreenController.step,
                            myStepsScreenController: myStepsScreenController,
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
    required this.checkDocs,
  }) : super(key: key);

  final int step;
  final int index;
  final int checkDocs;

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
                titles[index].tr,
                style: TextStyle(color: frColor),
              ),
            ],
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
      height: height * 0.1,
      width: width,
      color: Colors.red,
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
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.rectangle,
        ),
        // height: height * 0.13,
        padding: EdgeInsets.symmetric(horizontal: 20),
        // color: Colors.grey,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PreviousButton(
                myStepsScreenController: myStepsScreenController,
                isDisable: !myStepsScreenController.isPreviousButtonEnable,
              ),
              myStepsScreenController.step == 8
                  ? ReceiptStepButtons()
                  : Obx(
                      () => MyElevatedButton(
                        height: 40,
                        width: 300,
                        buttonText: myStepsScreenController.buttonsText[myStepsScreenController.currButtonTextIndex.value],
                        bgColor: Color(0xff4c6ef6),
                        fgColor: Colors.white,
                        function: myStepsScreenController.increaseStep,
                        isDisable: !myStepsScreenController.isNextButtonEnable,
                      ),
                    )
            ],
          ),
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
  }) : super(key: key);
  final StepsScreenController myStepsScreenController;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
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
          if (!isDisable) {
            myStepsScreenController.decreaseStep();
          }
        },
        child: Row(
          children: [
            RotationTransition(
              turns: languageCode == "en" ? AlwaysStoppedAnimation(0 / 360) : AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                MenuIcons.iconLeftArrow,
                color: isDisable ? Color(0xff767676).withOpacity(0.5) : Color(0xff767676),
                size: 14,
              ),
            ),
            Container(
              margin: languageCode == "en" ? EdgeInsets.only(left: 4) : EdgeInsets.only(right: 4),
              child: Text(
                "Previous".tr,
                style: TextStyle(
                  fontSize: 12,
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

class TravellersList extends StatelessWidget {
  const TravellersList({
    Key? key,
    required this.height,
    required this.width,
    required this.step,
    required this.myStepsScreenController,
  }) : super(key: key);

  final double height;
  final double width;
  final int step;
  final StepsScreenController myStepsScreenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        shape: BoxShape.rectangle,
        // color: Colors.blue,
      ),
      height: height,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(
                title: "Travellers".tr,
                width: width * 0.5,
                height: 100,
                fontSize: 40,
              ),
              if (step == 6)
                Container(
                  width: 112,
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        height: 60,
                        color: Color(0xffededed),
                      ),
                      TitleWidget(
                        title: "Seat".tr,
                        width: 100,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          // Container(
          //   // width: width,
          //   height: 1,
          //   color: Color(0xffeaeaea),
          // ),
          Obx(
            () => Container(
              width: width,
              height: height -105,
              // color: Colors.yellow,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: myStepsScreenController.travellers.length,
                itemBuilder: (ctx, index) {
                  return TravellerItem(
                    step: step,
                    index: index,
                    myStepsScreenController: myStepsScreenController,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // color: Colors.red,
    );
  }
}

class AddNewTraveller extends StatelessWidget {
  const AddNewTraveller({
    Key? key,
    required this.myStepsScreenController,
  }) : super(key: key);
  final StepsScreenController myStepsScreenController;

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    TravellersStepScreenController myTravellersStepScreenController = Get.put(TravellersStepScreenController(model));
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                myStepsScreenController.changeStateOFAddingBox();
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    myStepsScreenController.isAddingBoxOpen.value
                        ? RotationTransition(
                            turns: AlwaysStoppedAnimation(45 / 360),
                            child: Icon(
                              MenuIcons.iconAdd,
                              color: Color(0xff48c0a2),
                              size: 20,
                            ),
                          )
                        : Icon(
                            MenuIcons.iconAdd,
                            color: Color(0xff48c0a2),
                            size: 20,
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Add Travellers".tr,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff48c0a2),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (myStepsScreenController.isAddingBoxOpen.value)
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add all passengers to the list on the left here".tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff808080),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => UserTextInput(
                      controller: myTravellersStepScreenController.lastNameC,
                      hint: "Last Name".tr,
                      errorText: "Last Name can't be empty".tr,
                      isEmpty: myTravellersStepScreenController.isLastNameEmpty.value,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => UserTextInput(
                      controller: myTravellersStepScreenController.ticketNumberC,
                      hint: "Reservation ID / Ticket Number".tr,
                      errorText: "Reservation ID / Ticket Number can't be empty".tr,
                      isEmpty: myTravellersStepScreenController.isTicketNumberEmpty.value,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  AddToTravellersButton(
                    myTravellersStepScreenController: myTravellersStepScreenController,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class AddToTravellersButton extends StatelessWidget {
  const AddToTravellersButton({
    Key? key,
    required this.myTravellersStepScreenController,
  }) : super(key: key);
  final TravellersStepScreenController myTravellersStepScreenController;

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    return MyElevatedButton(
      height: 40,
      width: double.infinity,
      buttonText: "Add to Travellers".tr,
      bgColor: Color(0xff00bfa2),
      fgColor: Colors.white,
      function: model.requesting ? () {} : myTravellersStepScreenController.addTraveller,
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
    String languageCode = Get.locale!.languageCode;
    bool isTravellerSelected = myStepsScreenController.travellers[index].seatId == "--" ? false : true;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.rectangle,
        color: myStepsScreenController.whoseTurnToSelect.value == index && step == 6 ? const Color(0xffffae2c).withOpacity(0.5) : Colors.white,
      ),
      height: 100,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                  child: Text(
                    myStepsScreenController.travellers[index].getFullNameWithGender(),
                    style: TextStyle(
                      color: Color(0xff424242),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                step == 0
                    ? IconButton(
                        onPressed: () => myStepsScreenController.removeFromTravellers(index),
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 40,
                        ),
                      )
                    : step == 6
                        ? Container(
                            width: 112,
                            child: Row(
                              children: [
                                Container(
                                  width: 2,
                                  height: 100,
                                  color: Color(0xffededed),
                                ),
                                Row(
                                  children: [
                                    TitleWidget(
                                      title: myStepsScreenController.travellers[index].seatId,
                                      width: 75,
                                      textColor: isTravellerSelected ? Color(0xff48c0a2) : Color(0xff424242),
                                    ),
                                    Container(
                                      width: 35,
                                      // child: IconButton(
                                      //   onPressed: () {
                                      //     myStepsScreenController.setWhichOneToEdit(index);
                                      //   },
                                      //   icon: Icon(Icons.edit),
                                      //   color: myStepsScreenController.whichOneToEdit == index ? Colors.green : Colors.blue,
                                      // ),
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
        ],
      ),
    );
  }
}
