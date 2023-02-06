import 'package:flutter/material.dart';
import 'package:online_check_in/core/constants/assets.dart';
import 'package:online_check_in/screens/addTraveler/add_traveler_state.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/steps/widgets/bottom_of_page.dart';
import 'package:online_check_in/screens/steps/widgets/previous_button.dart';
import 'package:online_check_in/screens/steps/widgets/receipt_button.dart';
import 'package:online_check_in/screens/steps/widgets/step_widget.dart';
import 'package:online_check_in/screens/steps/widgets/top_of_page.dart';
import 'package:online_check_in/widgets/MyDivider.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/UserTextInput.dart';
import '../../widgets/title_widget.dart';
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
      backgroundColor: theme.primaryColor,
      body: stepsState.stepLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                TopOfPage(
                  height: height,
                  width: width,
                  stepsController: stepsController,
                  isTabletMode: false,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftSideOFPage(
                      height: height,
                      width: width * 0.20,
                      step: stepsState.step,
                      stepsController: stepsController,
                    ),
                    SizedBox(
                      width: width * 0.80,
                      height: height * 0.9,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                                  Expanded(
                                    child: stepsState.step == 0
                                        ? const MyDottedLine(
                                            lineLength: double.infinity,
                                            color: MyColors.oceanGreen,
                                          )
                                        : const MyDivider(color: MyColors.oceanGreen),
                                  )
                                ] +
                                stepsController
                                    .stepsToShowList()
                                    .map((i) => StepWidget(
                                          index: i,
                                          isTabletMode: false,
                                        ))
                                    .toList() +
                                [
                                  const Expanded(
                                    child: MyDivider(),
                                  ),
                                ],
                          ),
                          Container(
                            color: MyColors.white,
                            height: height * 0.77,
                            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                            child: childWidget,
                          ),
                          BottomOfPage(height: height, stepsController: stepsController, isTabletMode: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
                const TitleWidget(
                  title: "Travellers",
                  width: 190,
                ),
                if (step == 6)
                  SizedBox(
                    width: 112,
                    child: Row(
                      children: const [
                        MyDivider(
                          width: 2,
                          height: 60,
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
            // const MyDivider(
            //   width: 0
            // ),
            SizedBox(
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
    return Container(
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
                            color: MyColors.oceanGreen,
                            size: 20,
                          ),
                        )
                      : const Icon(
                          MenuIcons.iconAdd,
                          color: MyColors.oceanGreen,
                          size: 20,
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Add Travellers",
                    style: MyTextTheme.w800MainColor15,
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
                const Text(
                  "Add all passengers to the list on the left here",
                  style: MyTextTheme.lightGrey14,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserTextInput(
                  controller: addTravelerState.lastNameC,
                  hint: "Last Name",
                  errorText: "Last Name can't be empty",
                  isEmpty: addTravelerState.isLastNameEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                UserTextInput(
                  controller: addTravelerState.ticketNumberC,
                  hint: "Reservation ID / Ticket Number",
                  errorText: "Reservation ID / Ticket Number can't be empty",
                  isEmpty: addTravelerState.isTicketNumberEmpty,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyElevatedButton(
                  height: 40,
                  width: double.infinity,
                  buttonText: "Add to Travellers",
                  bgColor: const Color(0xff00bfa2),
                  fgColor: MyColors.white,
                  function: () {
                    addTravelerState.requesting ? () {} : addTravelerController.addTraveller(context);
                  },
                ),
              ],
            )
        ],
      ),
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
      color: stepsState.whoseTurnToSelect == index && step == 6 ? MyColors.brightYellow.withOpacity(0.5) : MyColors.white,
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
                    style: MyTextTheme.w300DarkGrey14,
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
                                  color: MyColors.white1,
                                ),
                                Row(
                                  children: [
                                    TitleWidget(
                                      title: stepsState.travelers[index].seatId,
                                      width: 75,
                                      textColor: isTravellerSelected ? MyColors.oceanGreen : MyColors.darkGrey,
                                    ),
                                    Container(
                                      width: 35,
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
          const MyDivider(),
        ],
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
    return SizedBox(
      height: 60,
      width: 160,
      child: Image.asset(
        AssetImages.abomisLogo,
        fit: BoxFit.fill,
      ),
    );
  }
}
