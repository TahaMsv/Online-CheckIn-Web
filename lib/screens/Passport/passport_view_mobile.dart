import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/Passport/passport_controller.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/info_card.dart';

class PassportView extends StatelessWidget {
  PassportView({Key? key}) : super(key: key);
  final PassportController passportController = getIt<PassportController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    PassportState passportState = context.watch<PassportState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: passportState.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepsScreenTitle(title: "Passport", description: "", fontSize: 25),
          const SizedBox(height: 5),
          const Text("Enter passport data (DOCS) for all the passengers.", style: MyTextTheme.black17W300),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: passportState.travelers.asMap().entries.map(
                    (entry) {
                  int idx = entry.key;
                  return InfoCard(
                    index: idx,
                    fontSize: 17,
                    isTabletMode: true,
                    isPassportStep: true,
                    isCompleted: passportState.travelers[idx].passportInfo.isPassInfoCompleted,
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