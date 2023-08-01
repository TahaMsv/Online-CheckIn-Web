import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/upgrades/upgrades_controller.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';
import 'package:online_check_in/screens/upgrades/widgets/entertainments.dart';
import 'package:online_check_in/screens/upgrades/widgets/upgrade_items_widget.dart';
import '../../core/classes/extra.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class UpgradesView extends ConsumerWidget {
  UpgradesView({Key? key}) : super(key: key);
  final UpgradesController upgradesController = getIt<UpgradesController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    UpgradesState upgradesState = ref.watch(upgradesProvider);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: upgradesState.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepsScreenTitle(title: "Upgrades".translate(context), description: "", fontSize: 25),
                SizedBox(height: 5),
                Text("All upgrades are non-refundable".translate(context), style: MyTextTheme.black17W300),
                SizedBox(height: 5),
                WinesAndDrinksList(),
                SizedBox(height: 5),
                Entertainment(),
              ],
            ),
    );
  }
}

class WinesAndDrinksList extends ConsumerWidget {
  const WinesAndDrinksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Extra> winesList = ref.watch(winesListProvider)!;
    return SizedBox(
      height: height * 0.3,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Wines & Drinks".translate(context), style: MyTextTheme.darkGreyW70020),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: winesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UpgradeItemWidget(index: index, value: winesList[index], isPrinter: false);
                }),
          ),
        ],
      ),
    );
  }
}
