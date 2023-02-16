import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:online_check_in/core/platform/device_info.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/my_app.dart';

class CopyrightText extends StatelessWidget {
  const CopyrightText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text("© Copyright 2021 Abomis All rights reserved".translate(context), style: deviceType.isPhone? MyTextTheme.lightGrey14 :MyTextTheme.lightGrey20 , ),
        ),
      ],
    );
  }
}