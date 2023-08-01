import 'package:flutter/material.dart';
import 'package:online_check_in/core/classes/flight_information.dart';

import '../../../core/classes/flight.dart';
import 'detail_part.dart';

class FLightExtraDetails extends StatelessWidget {
  const FLightExtraDetails({
    Key? key,
    required this.flightInformation,
  }) : super(key: key);
  final FlightInformation flightInformation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
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
                title: "Flight No",
                description: flightInformation.flight[0].flnb,
              ),
              DetailPart(
                title: "Cabin",
                description: flightInformation.passengers.first.cabin,
              ),
              DetailPart(
                title: "Boarding",
                description: flightInformation.flight[0].boardingTime,
              ),
              DetailPart(
                title: "Terminal",
                description: flightInformation.flight[0].terminal.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
