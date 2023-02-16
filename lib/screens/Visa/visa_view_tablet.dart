import 'package:flutter/material.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/info_card.dart';
import '../steps/steps_state.dart';

class VisaViewTablet extends StatelessWidget {
  VisaViewTablet({Key? key}) : super(key: key);
  final VisaController visaController = getIt<VisaController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    VisaState visaState = context.watch<VisaState>();
    StepsState stepsState = context.watch<StepsState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body:!stepsState.isDocoNecessary
              ?  Center(child: Text("No need to add visa".translate(context)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     StepsScreenTitle(title: "Visa".translate(context), description: "", fontSize: 45),
                    const SizedBox(height: 10),
                     Text("Enter visa data (DOCO) for all the passengers.".translate(context), style: MyTextTheme.black25W300),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView(
                        children: visaState.travelers.asMap().entries.map(
                          (entry) {
                            int idx = entry.key;
                            return InfoCard(
                              index: idx,
                              fontSize: 25,
                              isTabletMode: true,
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
