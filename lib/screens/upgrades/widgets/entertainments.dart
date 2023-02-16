import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/upgrades/widgets/upgrade_items_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';
import '../upgrades_state.dart';

class Entertainment extends StatelessWidget {
  const Entertainment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpgradesState upgradesState = context.watch<UpgradesState>();
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Entertainment".translate(context), style:deviceType.isPhone?MyTextTheme.darkGreyW70020: deviceType.isTablet ? MyTextTheme.darkGreyW70025 : MyTextTheme.darkGreyW80013),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: upgradesState.entertainmentsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UpgradeItemWidget(index: index, value: upgradesState.entertainmentsList[index], isPrinter: true);
                }),
          ),
        ],
      ),
    );
  }
}
