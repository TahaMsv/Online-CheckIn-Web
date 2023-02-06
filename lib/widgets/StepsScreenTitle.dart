import 'package:flutter/material.dart';

import '../core/constants/ui.dart';

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
          style: TextStyle(color: MyColors.darkGrey, fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
        const SizedBox(width: 15),
        Text(
          description,
          style: TextStyle(color: MyColors.darkGrey, fontWeight: FontWeight.w400, fontSize: fontSize - 2),
        ),
      ],
    );
  }
}
