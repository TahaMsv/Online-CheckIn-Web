import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/my_list.dart';
import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';
import '../../../widgets/MtDottedLine.dart';
import '../steps_state.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    StepsState stepsState = context.watch<StepsState>();
    int step = stepsState.step;
    Color bgColor;
    Color frColor;
    Color borderColor;
    if (step < index) {
      bgColor = MyColors.white;
      frColor = MyColors.white1;
      borderColor = MyColors.white1;
    } else if (step == index) {
      bgColor = MyColors.white;
      frColor = MyColors.oceanGreen;
      borderColor = MyColors.oceanGreen;
    } else {
      bgColor = MyColors.oceanGreen;
      frColor = MyColors.white;
      borderColor = MyColors.oceanGreen;
    }

    return Row(
      children: [
        step == index
            ? MyDottedLine(
                lineLength: deviceType.isPhone ? 10 : 25,
                color: MyColors.oceanGreen,
              )
            : Container(
                height: 1,
                width: deviceType.isPhone ? 10 : 25,
                color: step <= index ? MyColors.white1 : MyColors.oceanGreen,
              ),
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: deviceType.isTablet || deviceType.isPhone
              ? Icon(
                  MyList.iconsList[index],
                  size: deviceType.isTablet ? 30 : 12,
                  color: frColor,
                )
              : Row(
                  children: [
                    Icon(
                      MyList.iconsList[index],
                      size: 15,
                      color: frColor,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      MyList.titlesList[index],
                      style: TextStyle(color: frColor),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
