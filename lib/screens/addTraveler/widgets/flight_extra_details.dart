import 'package:flutter/material.dart';

import 'detail_part.dart';

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

