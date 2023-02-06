import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/Passport/passport_controller.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import 'package:online_check_in/widgets/info_card.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../core/utils/getTranslatedWord.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';

class PassportViewWeb extends StatelessWidget {
  PassportViewWeb({Key? key}) : super(key: key);
  final PassportController passportController = getIt<PassportController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    PassportState passportState = context.watch<PassportState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body:passportState.loading
          ? const Center(child: CircularProgressIndicator())
          :  Column(
        children: [
          const StepsScreenTitle(title: "Passport", description: "Enter passport data (DOCS) for all the passengers."),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              // crossAxisSpacing: 60,
              childAspectRatio: 315 / 193,
              children: passportState.travelers.asMap().entries.map(
                (entry) {
                  int idx = entry.key;
                  return InfoCard(index: idx, isTabletMode: false, isPassportStep: true, isCompleted: passportState.travelers[idx].passportInfo.isPassInfoCompleted,);
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

