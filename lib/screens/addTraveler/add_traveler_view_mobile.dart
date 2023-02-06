import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/addTraveler/widgets/airplane_image.dart';
import 'package:online_check_in/screens/addTraveler/widgets/dates_and_fornat_to_city.dart';
import 'package:online_check_in/screens/addTraveler/widgets/flight_extra_details.dart';
import 'package:online_check_in/screens/addTraveler/widgets/travellers_list.dart';
import '../../core/classes/flight.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../core/platform/device_info.dart';
import '../steps/steps_state.dart';
import 'add_traveler_controller.dart';
import 'add_traveler_state.dart';

class AddTravelerView extends StatelessWidget {
  AddTravelerView({Key? key}) : super(key: key);
  final AddTravelerController addTravelerController = getIt<AddTravelerController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StepsState stepsState = context.watch<StepsState>();
    Flight flightInformation = stepsState.flightInformation!.flight[0];
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ListView(
        children: [
          TravellersList(
            width: width,
            step: stepsState.step,
          ),
          SizedBox(height: deviceType.isPhone ? 10 : 20),
          Container(
            width: deviceType.isPhone ? width : width * 0.8,
            height: deviceType.isPhone ? 200 : 350,
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
        ],
      ),
    );
  }
}
