import 'package:flutter/material.dart';

class UserTextInput extends StatelessWidget {
  const UserTextInput({
    Key? key,
    required this.controller,
    required this.hint,
    this.height = 40,
     this.errorText="",
     this.isEmpty=false, this.obscureText = false,  this.width = 400,  this.fontSize = 15,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String errorText;
  final bool isEmpty;
  final double height;
  final double width;
  final bool obscureText;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffeaeaea),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: TextField(
          obscureText: obscureText,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          style: TextStyle(
            fontSize: fontSize
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
            hintText: hint,

            errorText: isEmpty ? errorText : null,
          ),
        ),
      ),
    );
  }
}
