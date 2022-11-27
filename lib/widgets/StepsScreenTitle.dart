import 'package:flutter/material.dart';

class StepsScreenTitle extends StatelessWidget {
  const StepsScreenTitle({
    Key? key,
    required this.title,
    required this.description,
    this.fontSize = 17,
  }) : super(key: key);

  final String title;
  final String description;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          description,
          style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.w400, fontSize: fontSize - 2),
        ),
      ],
    );
  }
}
