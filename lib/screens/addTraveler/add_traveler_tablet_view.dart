import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/screens/addTraveler/widgets/airplane_image.dart';
import 'package:online_check_in/screens/addTraveler/widgets/dates_and_fornat_to_city.dart';
import 'package:online_check_in/screens/addTraveler/widgets/flight_extra_details.dart';
import 'package:online_check_in/screens/addTraveler/widgets/travellers_list.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../core/platform/device_info.dart';
import '../steps/steps_state.dart';
import 'add_traveler_controller.dart';

class AddTravelerViewTablet extends ConsumerWidget {
  AddTravelerViewTablet({Key? key}) : super(key: key);
  final AddTravelerController addTravelerController = getIt<AddTravelerController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StepsState stepsState = ref.watch(stepsProvider);
    // FlightInformation flightInformation = stepsState.flightInformation!;
    FlightInformation flightInformation = ref.watch(flightInformationProvider)!;

    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ListView(
        children: [
          TravellersList(
            width: width,
            step: stepsState.step,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              const AddNewTraveller(),
              SizedBox(height: deviceType.isPhone ? 10 : 20),
              Container(
                width: width * 0.8,
                height: 450,
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
            ],
          ),
        ],
      ),
    );
  }
}
