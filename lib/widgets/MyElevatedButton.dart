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
  }) : super(key: key);

  final double height;
  final double width;
  final String buttonText;
  final Color bgColor;
  final Color fgColor;
  final VoidCallback  function;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: function,
        child: Text(buttonText),
        style: ButtonStyle(
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
