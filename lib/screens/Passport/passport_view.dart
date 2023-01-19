import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_controller.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../core/utils/getTranslatedWord.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';

class PassportView extends StatelessWidget {
  PassportView({Key? key}) : super(key: key);
  final PassportController passportController = getIt<PassportController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    PassportState passportState = context.watch<PassportState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        children: [
          const StepsScreenTitle(
            title: "Passport" ,
            description: "Enter passport data (DOCS) for all the passengers." ,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              // crossAxisSpacing: 60,
              childAspectRatio: 315 / 193,
              children: passportState.travelers.asMap().entries.map(
                (entry) {
                  int idx = entry.key;
                  return InfoCard(
                    index: idx,
                    myPassportController: passportController,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.myPassportController,
    required this.index,
  }) : super(key: key);
  final int index;

  final PassportController myPassportController;

  @override
  Widget build(BuildContext context) {
    PassportState passportState = context.watch<PassportState>();
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
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      width: 315,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: MyColors.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.warning_amber_sharp,
                color: passportState.travelers[index].passportInfo.isPassInfoCompleted ? MyColors.transparent : MyColors.begonia,
                size: 20,
              )
            ],
          ),
          Text(
            passportState.travelers[index].getFullNameWithGender(),
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Row(
            children: [
              Text(
                "${"ID" }: ",
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${passportState.travelers[index].flightInformation.passengers[0].id}",
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          passportState.travelers[index].passportInfo.isPassInfoCompleted
              ? EditIPassInfo(
                  index: index,
                  myPassportController: myPassportController,
                )
              : AddPassInfo(
                  index: index,
                  myPassportController: myPassportController,
                ),
        ],
      ),
    );
  }
}

class AddPassInfo extends StatelessWidget {
  const AddPassInfo({
    Key? key,
    required this.myPassportController,
    required this.index,
  }) : super(key: key);

  final PassportController myPassportController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // myPassportController.showBottomSheetForm(context, index);
        myPassportController.showPassportDialog(index);
      },
      child: Row(
        children: const [
          Icon(
            Icons.add_circle_outline_rounded,
            color: MyColors.myBlue,
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Add Passport Info" ,
            style: TextStyle(
              color: MyColors.myBlue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class EditIPassInfo extends StatelessWidget {
  const EditIPassInfo({
    Key? key,
    required this.myPassportController,
    required this.index,
  }) : super(key: key);
  final PassportController myPassportController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(
              Icons.check,
              color: MyColors.white,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // myPassportController.showDOCSPopup(context,index);
            myPassportController.showPassportDialog(index);
          },
          child: const Icon(
            MenuIcons.iconEdit,
            color: MyColors.white,
            size: 18,
          ),
        )
      ],
    );
  }
}

