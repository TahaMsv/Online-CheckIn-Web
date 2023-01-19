import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../core/constants/ui.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    required this.height,
    required this.width,
    required this.buttonText,
    required this.bgColor,
     this.fgColor = MyColors.black,
    required this.function,
    this.textColor = MyColors.white,
    this.isDisable = false,
    this.fontSize = 15,
    this.borderRadius,
    this.borderColor = Colors.transparent,
    this.child,
  }) : super(key: key);

  final double height;
  final double width;
  final String buttonText;
  final Color bgColor;
  final Color fgColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback function;
  final bool isDisable;
  final double fontSize;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: isDisable ? null : function,
        style: isDisable
            ? ElevatedButton.styleFrom(
                foregroundColor: fgColor.withOpacity(0.2),
                backgroundColor: bgColor.withOpacity(0.2),
                textStyle: TextStyle(color: textColor.withOpacity(0.2)),
              )
            : ElevatedButton.styleFrom(
                foregroundColor: fgColor,
                backgroundColor: bgColor,
                textStyle: TextStyle(color: textColor),
              ),
        child: child ??
            Text(
              buttonText ,
              style: TextStyle(fontSize: fontSize),
            ),
      ),
    );
  }
}
