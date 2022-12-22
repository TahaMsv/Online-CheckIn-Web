import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/core/classes/flight.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_cotroller.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import 'add_traveler_controller.dart';
import 'add_traveler_state.dart';

class AddTravelerView extends StatelessWidget {
  AddTravelerView({Key? key}) : super(key: key);
  final AddTravelerController addTravelerController = getIt<AddTravelerController>();
  final StepsController stepsController = getIt<StepsController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    StepsState stepsState = context.watch<StepsState>();
    // AddTravelerState addTravelerState = context.watch<AddTravelerState>();
    Flight flightInformation = stepsState.flightInformation!.flight[0];
    return Scaffold(
      // backgroundColor: theme.primaryColor,
      backgroundColor: Colors.white,
      body: stepsState.stepLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                width: 700,
                height: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffECECEC), width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    DatesAndFromToCities(
                      fromCity: flightInformation.fromCity,
                      fromTime: DateFormat('yyyy-MM-dd').format(flightInformation.flightDate),
                      toCity: flightInformation.toCity,
                      toTime: DateFormat('yyyy-MM-dd').format(flightInformation.flightDate),
                    ),
                    const AirplaneImage(),
                    FLightExtraDetails(
                      boardingTime: flightInformation.boardingTime,
                      terminal: flightInformation.terminal,
                      aircraft: flightInformation.aircraft,
                      flightClass: "-",
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class AirplaneImage extends StatelessWidget {
  const AirplaneImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffECECEC),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Image.asset(
              "assets/images/airplane.png",
              fit: BoxFit.fill,
              // height: 350,
            ),
          ),
        ],
      ),
    );
  }
}

class FLightExtraDetails extends StatelessWidget {
  const FLightExtraDetails({
    Key? key,
    required this.boardingTime,
    required this.terminal,
    required this.aircraft,
    required this.flightClass,
  }) : super(key: key);
  final String boardingTime;
  final int terminal;
  final String aircraft;
  final String flightClass;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DetailPart(
                title: "Boarding",
                description: boardingTime,
              ),
              DetailPart(
                title: "Terminal",
                description: terminal.toString(),
              ),
              DetailPart(
                title: "Flight",
                description: aircraft,
              ),
              DetailPart(
                title: "Class",
                description: flightClass,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPart extends StatelessWidget {
  const DetailPart({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black.withOpacity(0.5)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(description)
        ],
      ),
    );
  }
}

class DatesAndFromToCities extends StatelessWidget {
  const DatesAndFromToCities({
    Key? key,
    required this.fromCity,
    required this.fromTime,
    required this.toCity,
    required this.toTime,
  }) : super(key: key);
  final String fromCity;
  final String fromTime;
  final String toCity;
  final String toTime;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          color: const Color(0xff48C0A2).withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CountryAndDate(city: fromCity, time: fromTime),
              Container(
                child: const Icon(
                  MenuIcons.iconRightArrow,
                  color: Color(0xff48C0A2),
                ),
              ),
              CountryAndDate(city: toCity, time: toTime),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryAndDate extends StatelessWidget {
  const CountryAndDate({
    Key? key,
    required this.city,
    required this.time,
  }) : super(key: key);
  final String city;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            city,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(time)
        ],
      ),
    );
  }
}
