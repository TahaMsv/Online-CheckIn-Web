import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/info_card.dart';
import '../steps/steps_state.dart';

class VisaView extends ConsumerWidget {
  VisaView({Key? key}) : super(key: key);
  final VisaController visaController = getIt<VisaController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    VisaState visaState = ref.watch(visaProvider);
    StepsState stepsState = ref.watch(stepsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: !stepsState.isDocoNecessary
          ? const Center(child: Text("No need to add visa"))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StepsScreenTitle(title: "Visa", description: "", fontSize: 25),
                const SizedBox(height: 5),
                const Text("Enter visa data (DOCO) for all the passengers.", style: MyTextTheme.black17W300),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    children: visaState.travelers.asMap().entries.map(
                      (entry) {
                        int idx = entry.key;
                        return InfoCard(
                          index: idx,
                          fontSize: 17,
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
