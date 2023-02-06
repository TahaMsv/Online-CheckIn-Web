import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/core/classes/flight.dart';
import 'package:online_check_in/core/constants/assets.dart';
import 'package:online_check_in/screens/addTraveler/widgets/airplane_image.dart';
import 'package:online_check_in/screens/addTraveler/widgets/dates_and_fornat_to_city.dart';
import 'package:online_check_in/screens/addTraveler/widgets/detail_part.dart';
import 'package:online_check_in/screens/addTraveler/widgets/flight_extra_details.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
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
    AddTravelerState addTravelerState = context.watch<AddTravelerState>();
    Flight flightInformation = stepsState.flightInformation!.flight[0];
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body:Center(
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
                      fromTime: flightInformation.fromTime,
                      toCity: flightInformation.toCity,
                      toTime: flightInformation.toTime,
                      isTabletMode: false,
                    ),
                    const AirplaneImage(),
                    FLightExtraDetails(
                      boardingTime: flightInformation.boardingTime,
                      terminal: flightInformation.terminal,
                      aircraft: flightInformation.aircraft,
                      flightClass: "-",
                      isTabletMode: false,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
