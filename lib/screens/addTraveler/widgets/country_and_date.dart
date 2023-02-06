import 'package:flutter/material.dart';

class CountryAndDate extends StatelessWidget {
  const CountryAndDate({
    Key? key,
    required this.city,
    required this.time, required this.isTabletMode,
  }) : super(key: key);
  final String city;
  final String time;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    double fontSize = isTabletMode ? 30 :22;
    return SizedBox(
      height: isTabletMode? 100 : 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            city,
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(time, style: isTabletMode ?  const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)
              :null,)
        ],
      ),
    );
  }
}