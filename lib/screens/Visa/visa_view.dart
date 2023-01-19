import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_controller.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../core/utils/getTranslatedWord.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';

class VisaView extends StatelessWidget {
  VisaView({Key? key}) : super(key: key);
  final VisaController visaController = getIt<VisaController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    VisaState visaState = context.watch<VisaState>();
    StepsState stepsState = context.watch<StepsState>();
    return Scaffold(
      backgroundColor: MyColors.white,
      body: visaState.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !stepsState.isDocoNecessary
              ? const Center(
                  child: Text("No need to add visa"),
                )
              : Column(
                  children: [
                    const StepsScreenTitle(
                      title: "Visa",
                      description: "Enter visa data (DOCO) for all the passengers.",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        // crossAxisSpacing: 60,
                        childAspectRatio: 315 / 193,
                        children: stepsState.travelers.asMap().entries.map(
                          (entry) {
                            int idx = entry.key;
                            // Traveller traveller = entry.value;
                            return InfoCard(
                              index: idx,
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
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
    Color textColor;
    Color bgColor;
    if (stepsState.travelers[index].visaInfo.isVisaInfoCompleted) {
      textColor = MyColors.white;
      bgColor = MyColors.oceanGreen;
    } else {
      textColor = MyColors.darkGrey;
      bgColor = MyColors.white;
    }
    return Container(
      // height: 300,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      width: 315,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bgColor, border: Border.all(color: MyColors.white1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.warning_amber_sharp, color: stepsState.travelers[index].visaInfo.isVisaInfoCompleted ? MyColors.transparent : MyColors.begonia, size: 20)],
          ),
          Text(
            stepsState.travelers[index].getFullNameWithGender(),
            style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 45),
          Row(
            children: [
              Text("ID: ", style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w400)),
              Text("${stepsState.travelers[index].flightInformation.passengers[0].id}", style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w800)),
              const SizedBox(width: 5),
              Text("Passport No: ", style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 20),
          stepsState.travelers[index].visaInfo.isVisaInfoCompleted ? EditVisaInfo(index: index) : AddVisaInfo(index: index),
        ],
      ),
    );
  }
}

class AddVisaInfo extends StatelessWidget {
  const AddVisaInfo({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    VisaController visaController = getIt<VisaController>();
    return GestureDetector(
      onTap: () {
        visaController.showVisaDialog(index);
      },
      child: Row(
        children: const [
          Icon(Icons.add_circle_outline_rounded, color: MyColors.myBlue, size: 18),
          SizedBox(width: 5),
          Text(
            "Add Visa Info",
            style: TextStyle(color: Color(0xff4d6fff), fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class EditVisaInfo extends StatelessWidget {
  const EditVisaInfo({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    VisaController visaController = getIt<VisaController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.check, color: MyColors.white, size: 18),
            SizedBox(width: 5),
            Text(
              "Visa No: 45687",
              style: TextStyle(color: MyColors.white, fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            visaController.showVisaDialog(index);
          },
          child: const Icon(MenuIcons.iconEdit, color: MyColors.white, size: 18),
        )
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.function,
    this.height = 40,
    this.width = 130,
    this.fontSize = 15,
  }) : super(key: key);
  final Function function;
  final double height;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 1),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(border: Border.all(color: MyColors.blueAccent), borderRadius: BorderRadius.circular(5), color: MyColors.myBlue),
          child: MyElevatedButton(
            height: 50,
            width: 175,
            buttonText: "Submit".tr,
            fontSize: fontSize,
            bgColor: MyColors.white,
            fgColor: MyColors.myBlue,
            function: () {
              function();
            },
          ),
        ),
      ],
    );
  }
}
