import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/ui.dart';
import '../../../widgets/MtDottedLine.dart';
import '../steps_state.dart';
class StepWidget extends StatelessWidget {
  const StepWidget({
    Key? key,
    required this.step,
    required this.index, required this.isTabletMode,
  }) : super(key: key);

  final int step;
  final int index;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
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
            ? const MyDottedLine(
          lineLength: 25,
          color: MyColors.oceanGreen,
        )
            : Container(
          height: 1,
          width: 25,
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
          child:isTabletMode? Icon(
            stepsState.icons[index],
            size: 30,
            color: frColor,
          ):Row(
            children: [
              Icon(
                stepsState.icons[index],
                size:  15,
                color: frColor,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                stepsState.titles[index].tr,
                style: TextStyle(color: frColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
