import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/add_traveler_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_cotroller.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_cotroller.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_cotroller.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:get/get.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/LanguagePicker.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/UserTextInput.dart';
import '../addTraveler/add_traveler_controller.dart';

class StepsView extends StatelessWidget {
  StepsView({Key? key, required this.childWidget}) : super(key: key);
  final StepsController stepsController = getIt<StepsController>();
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    StepsState stepsState = context.watch<StepsState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: stepsState.stepLoading
          ? const Center(
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
                    stepsController: stepsController,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => LeftSideOFPage(
                          height: height,
                          width: width * 0.20,
                          step: stepsState.step,
                          stepsController: stepsController,
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: width * 0.80,
                          height: height * 0.9,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: stepsState.step == 0
                                        ? const MyDottedLine(
                                            lineLength: double.infinity,
                                            color: Color(0xff48c0a2),
                                          )
                                        : Container(
                                            height: 1,
                                            color: const Color(0xff48c0a2),
                                          ),
                                  ),
                                  for (int i = 0; i <= 8; i++)
                                    if (stepsController.isStepNeeded(i))
                                      StepWidget(
                                        step: stepsState.step,
                                        index: i,
                                      ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: const Color(0xffdbdbdb),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                height: height * 0.77,
                                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                                child: childWidget,
                              ),
                              BottomOfPage(height: height, stepsController: stepsController),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class StepWidget extends StatelessWidget {
  const StepWidget({
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
    Color bgColor;
    Color frColor;
    Color borderColor;
    if (step < index) {
      bgColor = const Color(0xffffffff);
      frColor = const Color(0xffdbdbdb);
      borderColor = const Color(0xffdbdbdb);
    } else if (step == index) {
      bgColor = const Color(0xffffffff);
      frColor = const Color(0xff48c0a2);
      borderColor = const Color(0xff48c0a2);
    } else {
      bgColor = const Color(0xff48c0a2);
      frColor = const Color(0xffffffff);
      borderColor = const Color(0xff48c0a2);
    }

    return Row(
      children: [
        step == index
            ? const MyDottedLine(
                lineLength: 25,
                color: Color(0xff48c0a2),
              )
            : Container(
                height: 1,
                width: 25,
                color: step <= index ? const Color(0xffdbdbdb) : const Color(0xff48c0a2),
              ),
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              Icon(
                icons[index],
                size: 15,
                color: frColor,
              ),
              const SizedBox(
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
    required this.stepsController,
  }) : super(key: key);

  final double height;
  final double width;
  final StepsController stepsController;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AbomisLogo(),
            LanguagePicker(
              // mainController: stepsController,  // todo
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
    required this.stepsController,
  }) : super(key: key);

  final double height;
  final StepsController stepsController;

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.rectangle,
        ),
        // height: height * 0.13,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // color: Colors.grey,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PreviousButton(
                stepsController: stepsController,
                isDisable: !stepsState.isPreviousButtonEnable,
              ),
              stepsState.step == 8
                  ? const ReceiptStepButtons()
                  : Obx(
                      () => MyElevatedButton(
                        height: 40,
                        width: 300,
                        buttonText: stepsState.buttonText(stepsState.currButtonTextIndex),
                        bgColor: const Color(0xff4c6ef6),
                        fgColor: Colors.white,
                        function: stepsController.increaseStep,
                        isDisable: !stepsState.isNextButtonEnable,
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
    return Row(
      children: [
        MyElevatedButton(
          height: 40,
          width: 100,
          buttonText: "Download".tr,
          bgColor: const Color(0xff424242),
          fgColor: Colors.white,
          function: () {},
        ),
        const SizedBox(
          width: 15,
        ),
        MyElevatedButton(
          height: 40,
          width: 100,
          buttonText: "Print".tr,
          bgColor: const Color(0xff48c0a2),
          fgColor: Colors.white,
          function: () {},
        ),
        const SizedBox(
          width: 15,
        ),
        MyElevatedButton(
          height: 40,
          width: 200,
          buttonText: "Sent to Mobile".tr,
          bgColor: const Color(0xff4c6ef6),
          fgColor: Colors.white,
          function: () {},
        ),
      ],
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key? key,
    required this.stepsController,
    required this.isDisable,
  }) : super(key: key);
  final StepsController stepsController;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    return SizedBox(
      height: 30,
      width: 80,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
        onPressed: () {
          if (!isDisable) {
            stepsController.decreaseStep();
          }
        },
        child: Row(
          children: [
            RotationTransition(
              turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
              child: Icon(
                MenuIcons.iconLeftArrow,
                color: isDisable ? const Color(0xff767676).withOpacity(0.5) : const Color(0xff767676),
                size: 14,
              ),
            ),
            Container(
              margin: languageCode == "en" ? const EdgeInsets.only(left: 4) : const EdgeInsets.only(right: 4),
              child: Text(
                "Previous".tr,
                style: TextStyle(
                  fontSize: 12,
                  color: isDisable ? const Color(0xff767676).withOpacity(0.5) : const Color(0xff767676),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeftSideOFPage extends StatelessWidget {
  const LeftSideOFPage({
    Key? key,
    required this.height,
    required this.width,
    required this.step,
    required this.stepsController,
  }) : super(key: key);

  final double height;
  final double width;
  final int step;
  final StepsController stepsController;

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
    return Expanded(
      child: Container(
        // width: width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.rectangle,
        ),
        margin: const EdgeInsets.only(top: 13.5),
        height: height * 0.9 - 13.5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(
                  title: "Travellers".tr,
                  width: 190,
                ),
                if (step == 6)
                  SizedBox(
                    width: 112,
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          height: 60,
                          color: const Color(0xffededed),
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
            Container(
              // width: width,
              height: 1,
              color: const Color(0xffeaeaea),
            ),
            Obx(
              //todo add it
              () => SizedBox(
                width: width,
                height: height * 0.9 - 65 - 13.5,
                child: ListView.builder(
                  itemCount: stepsState.travelers.length + 1,
                  itemBuilder: (ctx, index) {
                    return index < stepsState.travelers.length
                        ? TravellerItem(
                            step: step,
                            index: index,
                            stepsController: stepsController,
                          )
                        : stepsState.step == 0
                            ? AddNewTraveller(
                                stepsController: stepsController,
                              )
                            : Container();
                  },
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

class AddNewTraveller extends StatelessWidget {
  AddNewTraveller({
    Key? key,
    required this.stepsController,
  }) : super(key: key);
  final StepsController stepsController;
  final AddTravelerController addTravelerController = getIt<AddTravelerController>();

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
    AddTravelerState addTravelerState = context.watch<AddTravelerState>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                stepsController.changeStateOFAddingBox();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    stepsState.isAddingBoxOpen
                        ? const RotationTransition(
                            turns: AlwaysStoppedAnimation(45 / 360),
                            child: Icon(
                              MenuIcons.iconAdd,
                              color: Color(0xff48c0a2),
                              size: 20,
                            ),
                          )
                        : const Icon(
                            MenuIcons.iconAdd,
                            color: Color(0xff48c0a2),
                            size: 20,
                          ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Add Travellers".tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff48c0a2),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (stepsState.isAddingBoxOpen)
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add all passengers to the list on the left here".tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => UserTextInput(
                      controller: addTravelerState.lastNameC,
                      hint: "Last Name".tr,
                      errorText: "Last Name can't be empty".tr,
                      isEmpty: addTravelerState.isLastNameEmpty,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => UserTextInput(
                      controller: addTravelerState.ticketNumberC,
                      hint: "Reservation ID / Ticket Number".tr,
                      errorText: "Reservation ID / Ticket Number can't be empty".tr,
                      isEmpty: addTravelerState.isTicketNumberEmpty,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AddToTravellersButton(
                    addTravelerController: addTravelerController,
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
    required this.addTravelerController,
  }) : super(key: key);
  final AddTravelerController addTravelerController;

  @override
  Widget build(BuildContext context) {
    AddTravelerState addTravelerState = context.watch<AddTravelerState>();

    return MyElevatedButton(
      height: 40,
      width: double.infinity,
      buttonText: "Add to Travellers".tr,
      bgColor: const Color(0xff00bfa2),
      fgColor: Colors.white,
      function: () {
        addTravelerState.requesting ? () {} : addTravelerController.addTraveller(context);
      },
    );
  }
}

class TravellerItem extends StatelessWidget {
  const TravellerItem({
    Key? key,
    required this.step,
    required this.index,
    required this.stepsController,
  }) : super(key: key);
  final int step;
  final int index;
  final StepsController stepsController;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    StepsState stepsState = context.watch<StepsState>();
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    return Container(
      color: Colors.white,
      // color: stepsController.whoseTurnToSelect.value == index && step == 6 ? const Color(0xffffae2c).withOpacity(0.5) : Colors.white,//todo
      height: 60,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                  child: Text(
                    stepsState.travelers[index].getFullNameWithGender(),
                    style: const TextStyle(
                      color: Color(0xff424242),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                step == 0
                    ? IconButton(
                        onPressed: () => stepsController.removeFromTravelers(index),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      )
                    : step == 6
                        ? SizedBox(
                            width: 112,
                            child: Row(
                              children: [
                                Container(
                                  width: 2,
                                  height: 100,
                                  color: const Color(0xffededed),
                                ),
                                Row(
                                  children: [
                                    TitleWidget(
                                      title: stepsState.travelers[index].seatId,
                                      width: 75,
                                      textColor: isTravellerSelected ? const Color(0xff48c0a2) : const Color(0xff424242),
                                    ),
                                    Container(
                                      width: 35,
                                      // child: IconButton(
                                      //   onPressed: () {
                                      //     stepsController.setWhichOneToEdit(index);
                                      //   },
                                      //   icon: Icon(Icons.edit),
                                      //   color: stepsController.whichOneToEdit == index ? Colors.green : Colors.blue,
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
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xffeaeaea),
          ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    required this.width,
    this.textColor = const Color(0xff424242),
    this.fontSize = 17,
    this.height = 60,
  }) : super(key: key);

  final String title;
  final double height;
  final double width;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
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
      height: 60,
      width: 160,
      child: Image.asset(
        'assets/images/company-logo-blue.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
