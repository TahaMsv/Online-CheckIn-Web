import 'package:flutter/material.dart';
class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key, required this.width, required this.height, required this.color,
  }) : super(key: key);
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xffebebeb),
    );
  }
}
