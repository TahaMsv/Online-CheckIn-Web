import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:provider/provider.dart';

import '../core/constants/ui.dart';
import '../core/dependency_injection.dart';
import '../core/platform/device_info.dart';
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
    required this.isCompleted,
  }) : super(key: key);
  final int index;

  final bool isTabletMode;
  final bool isPassportStep;
  final bool isCompleted;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    PassportState passportState = context.watch<PassportState>();
    VisaState visaState = context.watch<VisaState>();
    StepsState stepsState = context.watch<StepsState>();

    Color textColor = isCompleted ? MyColors.white : MyColors.darkGrey;

    return Container(
      padding: isTabletMode ? const EdgeInsets.symmetric(vertical: 10, horizontal: 45) : const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      width: isTabletMode ? null : 315,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: isCompleted ? MyColors.oceanGreen : MyColors.white, border: Border.all(color: MyColors.lightGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.warning_amber_sharp,
                color: isCompleted ? MyColors.transparent : MyColors.begonia,
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
                isPassportStep ? "${passportState.travelers[index].flightInformation.passengers.last.id}" : "${visaState.travelers[index].flightInformation.passengers.last.id}",
                style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 20),
          isCompleted ? EditIPassInfo(index: index, isPassportStep: isPassportStep) : AddPassInfo(index: index, isPassportStep: isPassportStep),
        ],
      ),
    );
  }
}

class AddPassInfo extends StatelessWidget {
  const AddPassInfo({
    Key? key,
    required this.index,
    required this.isPassportStep,
  }) : super(key: key);

  final bool isPassportStep;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PassportController passportController = getIt<PassportController>();
    final VisaController visaController = getIt<VisaController>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return InkWell(
      onTap: () {
        if (isPassportStep) {
          deviceType.isTablet || deviceType.isPhone
              ? passportController.showBottomSheetForm(
                  context,
                  height,
                  width,
                  index,
                )
              : passportController.showPassportDialog(index);
        } else {
          deviceType.isTablet || deviceType.isPhone ? visaController.showBottomSheetForm(context, height, width, index) : visaController.showVisaDialog(index);
        }
      },
      child: Row(
        children: [
          Icon(Icons.add_circle_outline_rounded,
              color: MyColors.myBlue,
              size: deviceType.isPhone
                  ? 20
                  : deviceType.isTablet
                      ? 30
                      : 18),
          SizedBox(width: deviceType.isTablet ? 10 : 5),
          Text(isPassportStep ? "Add Passport Info".translate(context) : "Add Visa Info".translate(context),
              style: deviceType.isPhone
                  ? MyTextTheme.myBlue15W500
                  : deviceType.isTablet
                      ? MyTextTheme.myBlue22W500
                      : MyTextTheme.myBlue12W500),
        ],
      ),
    );
  }
}

class EditIPassInfo extends StatelessWidget {
  const EditIPassInfo({
    Key? key,
    required this.index,
    required this.isPassportStep,
  }) : super(key: key);
  final bool isPassportStep;
  final int index;

  @override
  Widget build(BuildContext context) {
    final PassportController passportController = getIt<PassportController>();
    final VisaController visaController = getIt<VisaController>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.check,
                color: MyColors.white,
                size: deviceType.isPhone
                    ? 20
                    : deviceType.isTablet
                        ? 30
                        : 18),
            SizedBox(width: deviceType.isTablet ? 10 : 5),
          ],
        ),
        InkWell(
          onTap: () {
            if (isPassportStep) {
              deviceType.isTablet || deviceType.isPhone ? passportController.showBottomSheetForm(context, height, width, index) : passportController.showPassportDialog(index);
            } else {
              deviceType.isTablet || deviceType.isPhone ? visaController.showBottomSheetForm(context, height, width, index) : visaController.showVisaDialog(index);
            }
          },
          child: Icon(MenuIcons.iconEdit,
              color: MyColors.white,
              size: deviceType.isPhone
                  ? 20
                  : deviceType.isTablet
                      ? 30
                      : 18),
        )
      ],
    );
  }
}
