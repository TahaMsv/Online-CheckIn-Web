import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/widgets/upgrade_items_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/ui.dart';
import '../upgrades_state.dart';

class Entertainment extends StatelessWidget {
  const Entertainment({
    Key? key, required this.isTabletMode,
  }) : super(key: key);
  final bool isTabletMode;
  @override
  Widget build(BuildContext context) {
    UpgradesState upgradesState = context.watch<UpgradesState>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Entertainment", style:isTabletMode?MyTextTheme.darkGreyW70025: MyTextTheme.darkGreyW80013),
          const SizedBox(height: 15),
          Expanded(child: UpgradeItemWidget(value: upgradesState.entertainmentsList[0], index: 0, isPrinter: true, isTabletMode: isTabletMode,)),
        ],
      ),
    );
  }
}
