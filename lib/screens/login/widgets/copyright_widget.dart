import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CopyrightText extends StatelessWidget {
  const CopyrightText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text("© Copyright 2021 Abomis All rights reserved".tr),
        ),
      ],
    );
  }
}