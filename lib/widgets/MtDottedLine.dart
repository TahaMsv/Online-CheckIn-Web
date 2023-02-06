import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class MyDottedLine extends StatelessWidget {
  const MyDottedLine({
    Key? key,
    required this.lineLength,
    required this.color,
  }) : super(key: key);

  final double lineLength;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: lineLength,
      lineThickness: 1.0,
      dashLength: 5,
      dashColor: color,
      dashRadius: 0.0,
      dashGapLength: 2.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}
