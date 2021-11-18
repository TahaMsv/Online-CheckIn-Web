import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    required this.height,
    required this.width,
    required this.buttonText,
    required this.bgColor,
    required this.fgColor,
    required this.function,
    this.isDisable = false,
  }) : super(key: key);

  final double height;
  final double width;
  final String buttonText;
  final Color bgColor;
  final Color fgColor;
  final VoidCallback function;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isDisable ? null : function,
        child: Text(buttonText),
        style: isDisable
            ? ButtonStyle(
                foregroundColor: MaterialStateProperty.all(fgColor.withOpacity(0.2)),
                backgroundColor: MaterialStateProperty.all(bgColor.withOpacity(0.2)),
                textStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.white.withOpacity(0.2)),
                ),
              )
            : ButtonStyle(
                foregroundColor: MaterialStateProperty.all(fgColor),
                backgroundColor: MaterialStateProperty.all(bgColor),
                textStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
