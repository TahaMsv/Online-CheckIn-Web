import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/core/constants/ui.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/upgrades_controller.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/upgrades_state.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/widgets/entertainments.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/widgets/upgrade_items_widget.dart';
import '../../core/classes/extra.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class UpgradesViewTablet extends StatelessWidget {
  UpgradesViewTablet({Key? key}) : super(key: key);
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
                StepsScreenTitle(title: "Upgrades", description: "", fontSize: 45),
                SizedBox(height: 20),
                Text("All upgrades are non-refundable", style: MyTextTheme.black25W300),
                SizedBox(height: 20),
                WinesAndDrinksList(),
                SizedBox(height: 20),
                Entertainment(isTabletMode: true),
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
          const Text("Wines & Drinks", style: MyTextTheme.darkGreyW70025),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: upgradesState.winesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UpgradeItemWidget(
                    index: index,
                    value: upgradesState.winesList[index],
                    isPrinter: false,
                    isTabletMode: true,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
