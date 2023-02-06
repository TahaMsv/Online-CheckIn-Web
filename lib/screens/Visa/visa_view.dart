import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../core/utils/getTranslatedWord.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/info_card.dart';

class VisaView extends StatelessWidget {
  VisaView({Key? key}) : super(key: key);
  final VisaController visaController = getIt<VisaController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    VisaState visaState = context.watch<VisaState>();
    StepsState stepsState = context.watch<StepsState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
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
                        children: visaState.travelers.asMap().entries.map(
                          (entry) {
                            int idx = entry.key;
                            // Traveller traveller = entry.value;
                            return InfoCard(
                              index: idx,
                              isTabletMode: false,
                              isPassportStep: false,
                              isCompleted: visaState.travelers[idx].visaInfo.isVisaInfoCompleted,
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
            function: () => function(),
          ),
        ),
      ],
    );
  }
}
