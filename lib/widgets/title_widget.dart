import 'package:flutter/material.dart';

import '../core/constants/ui.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    required this.width,
    this.textColor = MyColors.darkGrey,
    this.fontSize = 17,
    this.height = 60,
  }) : super(key: key);

  final String title;
  final double height;
  final double width;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
