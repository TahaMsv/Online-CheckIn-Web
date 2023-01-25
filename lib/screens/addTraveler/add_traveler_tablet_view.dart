import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/widgets/airplane_image.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/widgets/dates_and_fornat_to_city.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/widgets/flight_extra_details.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_controller.dart';
import 'package:online_checkin_web_refactoring/widgets/MyDivider.dart';
import '../../core/classes/flight.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/UserTextInput.dart';
import '../../widgets/title_widget.dart';
import '../steps/steps_state.dart';
import '../steps/steps_view.dart';
import 'add_traveler_controller.dart';
import 'add_traveler_state.dart';

class AddTravelerViewTablet extends StatelessWidget {
  AddTravelerViewTablet({Key? key}) : super(key: key);
  final AddTravelerController addTravelerController = getIt<AddTravelerController>();
  final StepsController stepsController = getIt<StepsController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AddTravelerState addTravelerState = context.watch<AddTravelerState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StepsState stepsState = context.watch<StepsState>();
    Flight flightInformation = stepsState.flightInformation!.flight[0];

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: stepsState.stepLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  width: width * 0.8,
                  height: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffECECEC), width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      DatesAndFromToCities(
                        fromCity: flightInformation.fromCity,
                        fromTime: flightInformation.fromTime,
                        toCity: flightInformation.toCity,
                        toTime: flightInformation.toTime,
                        isTabletMode: true,
                      ),
                      const AirplaneImage(),
                      FLightExtraDetails(
                        boardingTime: flightInformation.boardingTime,
                        terminal: flightInformation.terminal,
                        aircraft: flightInformation.aircraft,
                        flightClass: "-",
                        isTabletMode: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TravellersList(
                  height: height * 0.4,
                  width: width,
                  step: stepsState.step,
                  stepsController: stepsController,
                  stepsState: stepsState,
                  addTravelerState: addTravelerState,
                  addTravelerController: addTravelerController,
                ),
              ],
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
    required this.stepsController,
    required this.stepsState,
    required this.addTravelerState,
    required this.addTravelerController,
  }) : super(key: key);

  final double height;
  final double width;
  final int step;
  final StepsController stepsController;
  final StepsState stepsState;
  final AddTravelerState addTravelerState;
  final AddTravelerController addTravelerController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      height: height,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(
                title: "Travellers",
                width: width * 0.5,
                height: 100,
                fontSize: 40,
              ),
              if (step == 6)
                SizedBox(
                  width: 112,
                  child: Row(
                    children: const [
                      MyDivider(width: 2, height: 60),
                      TitleWidget(title: "Seat", width: 100),
                    ],
                  ),
                ),
            ],
          ),
          Container(
            width: width,
            height: height - 105,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: stepsState.travelers.length + 1,
              itemBuilder: (ctx, index) {
                return index < stepsState.travelers.length
                    ? TravellerItem(
                        step: step,
                        index: index,
                        stepsController: stepsController,
                        stepsState: stepsState,
                      )
                    : stepsState.step == 0
                        ? AddNewTraveller(
                            stepsController: stepsController,
                            addTravelerController: addTravelerController,
                            addTravelerState: addTravelerState,
                          )
                        : Container();
              },
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
    required this.stepsController,
    required this.addTravelerController,
    required this.addTravelerState,
  }) : super(key: key);
  final StepsController stepsController;
  final AddTravelerController addTravelerController;
  final AddTravelerState addTravelerState;

  @override
  Widget build(BuildContext context) {
    final StepsState stepsState = getIt<StepsState>();
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
                            color: MyColors.mainColor,
                            size: 30,
                          ),
                        )
                      : const Icon(
                          MenuIcons.iconAdd,
                          color: MyColors.mainColor,
                          size: 30,
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Add Travellers",
                    style: MyTextTheme.w800MainColor22,
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
                  style: MyTextTheme.lightGrey20,
                ),
                const SizedBox(
                  height: 15,
                ),
                UserTextInput(
                  height: 63,
                  fontSize: 22,
                  controller: addTravelerState.lastNameC,
                  hint: "Last Name",
                  errorText: "Last Name can't be empty",
                  isEmpty: addTravelerState.isLastNameEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                UserTextInput(
                  height: 63,
                  fontSize: 22,
                  controller: addTravelerState.ticketNumberC,
                  hint: "Reservation ID / Ticket Number",
                  errorText: "Reservation ID / Ticket Number can't be empty",
                  isEmpty: addTravelerState.isTicketNumberEmpty,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                AddToTravellersButton(
                  height: 50,
                  addTravelerState: addTravelerState,
                  addTravelerController: addTravelerController,
                ),
              ],
            )
        ],
      ),
    );
  }
}

class AddToTravellersButton extends StatelessWidget {
  const AddToTravellersButton({
    Key? key,
    required this.addTravelerController,
    this.height = 40,
    required this.addTravelerState,
  }) : super(key: key);
  final AddTravelerController addTravelerController;
  final AddTravelerState addTravelerState;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MyElevatedButton(
      height: height,
      width: double.infinity,
      buttonText: "Add to Travellers",
      bgColor: const Color(0xff00bfa2),
      fgColor: Colors.white,
      fontSize: 22,
      function: addTravelerState.requesting ? () {} : () => addTravelerController.addTraveller,
    );
  }
}

class TravellerItem extends StatelessWidget {
  const TravellerItem({
    Key? key,
    required this.step,
    required this.index,
    required this.stepsController,
    required this.stepsState,
  }) : super(key: key);
  final int step;
  final int index;
  final StepsController stepsController;
  final StepsState stepsState;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en"; //todo
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.lightGrey),
        color: stepsState.whoseTurnToSelect == index && step == 6 ? MyColors.brightYellow.withOpacity(0.5) : MyColors.white,
      ),
      height: 70,
      margin: const EdgeInsets.only(bottom: 20),
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
                      color: MyColors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                step == 0
                    ? IconButton(
                        onPressed: () => stepsController.removeFromTravelers(index),
                        icon: const Icon(
                          Icons.close,
                          color: MyColors.red,
                          size: 40,
                        ),
                      )
                    : step == 6
                        ? SizedBox(
                            width: 112,
                            child: Row(
                              children: [
                                const MyDivider(
                                  width: 2,
                                  height: 100,
                                ),
                                Row(
                                  children: [
                                    TitleWidget(
                                      title: stepsState.travelers[index].seatId,
                                      width: 75,
                                      textColor: isTravellerSelected ? MyColors.mainColor : MyColors.darkGrey,
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
        ],
      ),
    );
  }
}
