import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
class MyDottedLine extends StatelessWidget {
  const MyDottedLine({
    Key? key,
    this.lineLength, required this.color,
  }) : super(key: key);

  final lineLength;
final Color color;
  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: lineLength,
      lineThickness: 1.0,
      dashLength: 1.0,
      dashColor: color,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}