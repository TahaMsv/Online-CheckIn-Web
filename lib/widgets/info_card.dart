import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:provider/provider.dart';

import '../core/constants/ui.dart';
import '../core/dependency_injection.dart';
import '../screens/Visa/visa_controller.dart';
import '../screens/Passport/passport_controller.dart';
import '../screens/Passport/passport_state.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.index,
    required this.isTabletMode,
    this.fontSize = 15,
    required this.isPassportStep,
  }) : super(key: key);
  final int index;

  final bool isTabletMode;
  final bool isPassportStep;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    PassportState passportState = context.watch<PassportState>();
    VisaState visaState = context.watch<VisaState>();
    StepsState stepsState = context.watch<StepsState>();

    Color textColor;
    Color bgColor;
    if (passportState.travelers[index].passportInfo.isPassInfoCompleted) {
      textColor = MyColors.white;
      bgColor = MyColors.oceanGreen;
    } else {
      textColor = MyColors.darkGrey;
      bgColor = MyColors.white;
    }
    return Container(
      padding: isTabletMode ? const EdgeInsets.symmetric(vertical: 10, horizontal: 45) : const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      width: isTabletMode ? null : 315,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bgColor, border: Border.all(color: MyColors.white)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.warning_amber_sharp,
                color: isPassportStep
                    ? (passportState.travelers[index].passportInfo.isPassInfoCompleted ? MyColors.transparent : MyColors.begonia)
                    : (visaState.travelers[index].visaInfo.isVisaInfoCompleted ? MyColors.transparent : MyColors.begonia),
                size: isTabletMode ? fontSize + 10 : 20,
              )
            ],
          ),
          Text(
            isPassportStep ? passportState.travelers[index].getFullNameWithGender() : visaState.travelers[index].getFullNameWithGender(),
            style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: isTabletMode ? 80 : 45),
          Row(
            children: [
              Text(
                "${"ID"}: ",
                style: TextStyle(color: textColor, fontSize: fontSize - 2, fontWeight: FontWeight.w400),
              ),
              Text(
                isPassportStep ? "${passportState.travelers[index].flightInformation.passengers[0].id}" : "${visaState.travelers[index].flightInformation.passengers[0].id}",
                style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 20),
          (isPassportStep && passportState.travelers[index].passportInfo.isPassInfoCompleted) || (!isPassportStep && visaState.travelers[index].visaInfo.isVisaInfoCompleted)
              ? EditIPassInfo(
                  index: index,
                  isTabletMode: isTabletMode,
                  isPassportStep: isPassportStep,
                )
              : AddPassInfo(
                  index: index,
                  isTabletMode: isTabletMode,
                  isPassportStep: isPassportStep,
                ),
        ],
      ),
    );
  }
}

class AddPassInfo extends StatelessWidget {
  const AddPassInfo({
    Key? key,
    required this.isTabletMode,
    required this.index,
    required this.isPassportStep,
  }) : super(key: key);

  final bool isTabletMode;
  final bool isPassportStep;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PassportController passportController = getIt<PassportController>();
    final VisaController visaController = getIt<VisaController>();
    return GestureDetector(
      onTap: () {
        if (isPassportStep) {
          isTabletMode
              ? passportController.showBottomSheetForm(
                  context,
                  index,
                )
              : passportController.showPassportDialog(index);
        } else {
          visaController.showVisaDialog(index);
        }
      },
      child: Row(
        children: [
          Icon(Icons.add_circle_outline_rounded, color: MyColors.myBlue, size: isTabletMode ? 30 : 18),
          SizedBox(width: isTabletMode ? 10 : 5),
          Text(isPassportStep ? "Add Passport Info" : "Add Visa Info", style: isTabletMode ? MyTextTheme.myBlue22W500 : MyTextTheme.myBlue12W500),
        ],
      ),
    );
  }
}

class EditIPassInfo extends StatelessWidget {
  const EditIPassInfo({
    Key? key,
    required this.isTabletMode,
    required this.index,
    required this.isPassportStep,
  }) : super(key: key);
  final bool isTabletMode;
  final bool isPassportStep;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PassportController passportController = getIt<PassportController>();
    final VisaController visaController = getIt<VisaController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.check, color: MyColors.white, size: isTabletMode ? 30 : 18),
            SizedBox(width: isTabletMode ? 10 : 5),
          ],
        ),
        GestureDetector(
          onTap: () {
            if (isPassportStep) {
              isTabletMode ? passportController.showBottomSheetForm(context, index) : passportController.showPassportDialog(index);
            } else {
              visaController.showVisaDialog(index);
            }
          },
          child: Icon(MenuIcons.iconEdit, color: MyColors.white, size: isTabletMode ? 30 : 18),
        )
      ],
    );
  }
}
