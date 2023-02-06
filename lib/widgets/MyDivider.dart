import 'package:flutter/material.dart';
import 'package:online_check_in/core/constants/ui.dart';
class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,  this.width = double.infinity,  this.height = 1, this.color = MyColors.white1,
  }) : super(key: key);
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
