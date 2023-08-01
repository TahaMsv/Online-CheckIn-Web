import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/Passport/passport_controller.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import 'package:online_check_in/widgets/info_card.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../core/utils/get_translated_word.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';

class PassportViewWeb extends ConsumerWidget {
  PassportViewWeb({Key? key}) : super(key: key);
  final PassportController passportController = getIt<PassportController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    PassportState passportState = ref.watch(passportProvider);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: passportState.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                StepsScreenTitle(title: "Passport".translate(context), description: "Enter passport data (DOCS) for all the passengers.".translate(context)),
                const SizedBox(height: 10),
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
                          isTabletMode: false,
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
