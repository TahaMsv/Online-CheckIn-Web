import 'package:flutter/material.dart';

import '../../../core/classes/flight.dart';
import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';
import 'country_and_date.dart';

class DatesAndFromToCities extends StatelessWidget {
  const DatesAndFromToCities({Key? key, required this.flight}) : super(key: key);
  final Flight flight;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          color: MyColors.oceanGreen.withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceType.isPhone ? 10 : 70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CountryAndDate(
                city: flight.fromCity,
                time: flight.fromTime,
                dateTime: flight.flightDateString,
              ),
              const Icon(
                MenuIcons.iconRightArrow,
                color: MyColors.oceanGreen,
                size: 20,
              ),
              CountryAndDate(
                city: flight.toCity,
                time: flight.toTime,
                dateTime: flight.flightDateString,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
