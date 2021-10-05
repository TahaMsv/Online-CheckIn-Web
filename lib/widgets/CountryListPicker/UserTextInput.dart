import 'package:flutter/material.dart';
class UserTextInput extends StatelessWidget {
  const UserTextInput({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffeaeaea),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}