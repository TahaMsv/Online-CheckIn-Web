import 'package:hooks_riverpod/hooks_riverpod.dart';
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
import '../../core/classes/flight_information.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import 'add_traveler_controller.dart';
import 'add_traveler_state.dart';

class AddTravelerViewWeb extends ConsumerWidget {
  AddTravelerViewWeb({Key? key}) : super(key: key);
  final AddTravelerController addTravelerController = getIt<AddTravelerController>();
  final StepsController stepsController = getIt<StepsController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    StepsState stepsState = ref.watch(stepsProvider);
    // FlightInformation flightInformation = stepsState.flightInformation!;
    FlightInformation flightInformation = ref.watch(flightInformationProvider)!;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Center(
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
                flight: flightInformation.flight[0],
              ),
              const AirplaneImage(),
              FLightExtraDetails(
                flightInformation: flightInformation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
