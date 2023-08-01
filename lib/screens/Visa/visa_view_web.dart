import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../core/utils/get_translated_word.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/info_card.dart';

class VisaViewWeb extends ConsumerWidget {
  VisaViewWeb({Key? key}) : super(key: key);
  final VisaController visaController = getIt<VisaController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    VisaState visaState = ref.watch(visaProvider);
    StepsState stepsState = ref.watch(stepsProvider);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: visaState.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !stepsState.isDocoNecessary
              ? Center(
                  child: Text("No need to add visa".translate(context)),
                )
              : Column(
                  children: [
                    StepsScreenTitle(
                      title: "Visa".translate(context),
                      description: "Enter visa data (DOCO) for all the passengers.".translate(context),
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
