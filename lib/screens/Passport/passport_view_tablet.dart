import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/core/constants/ui.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_controller.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_state.dart';
import 'package:online_checkin_web_refactoring/widgets/info_card.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class PassportViewTablet extends StatelessWidget {
  PassportViewTablet({Key? key}) : super(key: key);
  final PassportController passportController = getIt<PassportController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    PassportState passportState = context.watch<PassportState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepsScreenTitle(title: "Passport", description: "", fontSize: 45),
          const SizedBox(height: 10),
          const Text("Enter passport data (DOCS) for all the passengers.", style: MyTextTheme.black25W300),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: passportState.travelers.asMap().entries.map(
                (entry) {
                  int idx = entry.key;
                  return InfoCard(
                    index: idx,
                    fontSize: 25,
                    isTabletMode: true,
                    isPassportStep: true,
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
