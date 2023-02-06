import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/addTraveler/widgets/airplane_image.dart';
import 'package:online_check_in/screens/addTraveler/widgets/dates_and_fornat_to_city.dart';
import 'package:online_check_in/screens/addTraveler/widgets/flight_extra_details.dart';
import 'package:online_check_in/screens/addTraveler/widgets/travellers_list.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/widgets/MyDivider.dart';
import '../../core/classes/flight.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/UserTextInput.dart';
import '../../widgets/title_widget.dart';
import '../steps/steps_state.dart';
import '../steps/steps_view_web.dart';
import 'add_traveler_controller.dart';
import 'add_traveler_state.dart';

class AddTravelerViewTablet extends StatelessWidget {
  AddTravelerViewTablet({Key? key}) : super(key: key);
  final AddTravelerController addTravelerController = getIt<AddTravelerController>();


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StepsState stepsState = context.watch<StepsState>();
    Flight flightInformation = stepsState.flightInformation!.flight[0];

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

