import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/Passport/passport_controller.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../core/platform/device_info.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/info_card.dart';

class PassportView extends ConsumerWidget {
  PassportView({Key? key}) : super(key: key);
  final PassportController passportController = getIt<PassportController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    PassportState passportState = ref.watch(passportProvider);
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StepsScreenTitle(title: "Passport".translate(context), description: "", fontSize: 25),
              MyElevatedButton(
                  height: deviceType.isPhone ? 35 : 50,
                  width: deviceType.isPhone ? 130 : 230,
                  buttonText: "Scan doc",
                  bgColor: MyColors.myBlue,
                  fgColor: MyColors.white,
                  fontSize: deviceType.isPhone ? 17 : 23,
                  // borderColor: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Scan doc."),
                      Icon(
                        Icons.document_scanner_rounded,
                        size: 18,
                      )
                    ],
                  ),
                  function: () {}),
            ],
          ),
          const SizedBox(height: 5),
          Text("Enter passport data (DOCS) for all the passengers.".translate(context), style: MyTextTheme.black17W300),
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
