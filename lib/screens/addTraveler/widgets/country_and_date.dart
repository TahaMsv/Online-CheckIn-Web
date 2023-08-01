import 'package:flutter/material.dart';

import '../../../core/platform/device_info.dart';

class CountryAndDate extends StatelessWidget {
  const CountryAndDate({
    Key? key,
    required this.city,
    required this.time,
    required this.dateTime,
  }) : super(key: key);
  final String city;
  final String time;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);

    double fontSize = deviceType.isPhone
        ? 17
        : deviceType.isTablet
            ? 30
            : 22;
    return SizedBox(
      // height: deviceType.isPhone
      //     ? 55
      //     : deviceType.isTablet
      //         ? 100
      //         : 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            city,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          // SizedBox(height: deviceType.isPhone ? 0 : 10),
          Text(
            time,
            style: deviceType.isTablet ? TextStyle(fontWeight: FontWeight.bold, fontSize: deviceType.isPhone ? 20 : 25) : null,
          ),
          // SizedBox(height: deviceType.isPhone ? 0 : 10),
          Text(
            dateTime,
            style: deviceType.isTablet ? TextStyle(fontWeight: FontWeight.bold, fontSize: deviceType.isPhone ? 15 : 20) : null,
          )
        ],
      ),
    );
  }
}
