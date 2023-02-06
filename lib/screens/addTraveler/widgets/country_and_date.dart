import 'package:flutter/material.dart';

import '../../../core/platform/device_info.dart';

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
    DeviceType deviceType = DeviceInfo.deviceType(context);

    double fontSize = deviceType.isPhone
        ? 17
        : deviceType.isTablet
            ? 30
            : 22;
    return SizedBox(
      height: deviceType.isPhone
          ? 55
          : deviceType.isTablet
              ? 100
              : 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            city,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          SizedBox(height: deviceType.isPhone ? 0 : 15),
          Text(
            time,
            style: deviceType.isTablet ?  TextStyle(fontWeight: FontWeight.bold, fontSize:deviceType.isPhone? 20 : 25) : null,
          )
        ],
      ),
    );
  }
}
