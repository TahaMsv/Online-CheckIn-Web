import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/upgrades/upgrades_controller.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';
import 'package:online_check_in/screens/upgrades/widgets/entertainments.dart';
import 'package:online_check_in/screens/upgrades/widgets/upgrade_items_widget.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class UpgradesView extends StatelessWidget {
  UpgradesView({Key? key}) : super(key: key);
  final UpgradesController upgradesController = getIt<UpgradesController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    UpgradesState upgradesState = context.watch<UpgradesState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: upgradesState.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                StepsScreenTitle(title: "Upgrades", description: "", fontSize: 25),
                SizedBox(height: 5),
                Text("All upgrades are non-refundable", style: MyTextTheme.black17W300),
                SizedBox(height: 5),
                WinesAndDrinksList(),
                SizedBox(height: 5),
                Entertainment(),
              ],
            ),
    );
  }
}

class WinesAndDrinksList extends StatelessWidget {
  const WinesAndDrinksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final UpgradesController upgradesController = getIt<UpgradesController>();
    UpgradesState upgradesState = context.watch<UpgradesState>();
    return SizedBox(
      height: height * 0.3,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Wines & Drinks", style: MyTextTheme.darkGreyW70020),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: upgradesState.winesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UpgradeItemWidget(index: index, value: upgradesState.winesList[index], isPrinter: false);
                }),
          ),
        ],
      ),
    );
  }
}
