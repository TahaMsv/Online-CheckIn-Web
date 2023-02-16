import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:provider/provider.dart';

import '../../../core/classes/extra.dart';
import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../core/platform/device_info.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../upgrades_controller.dart';
import '../upgrades_state.dart';

class UpgradeItemWidget extends StatelessWidget {
  const UpgradeItemWidget({
    Key? key,
    required this.value,
    required this.isPrinter,
    required this.index,
  }) : super(key: key);

  final Extra value;
  final bool isPrinter;
  final int index;

  @override
  Widget build(BuildContext context) {
    final UpgradesController upgradesController = getIt<UpgradesController>();
    UpgradesState upgradesState = context.watch<UpgradesState>();
    DeviceType deviceType = DeviceInfo.deviceType(context);

    Color color;
    if (isPrinter) {
      color = upgradesState.colors[4];
    } else {
      color = upgradesState.colors[index % 4];
    }
    return Container(
      width: deviceType.isTablet ? 600 : 330,
      margin: deviceType.isTablet ? const EdgeInsets.only(left: 10, right: 10) : const EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Container(
            height: deviceType.isTablet ? 300 : 180,
            color: (color).withOpacity(0.1),
            padding: deviceType.isTablet ? const EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 100) : const EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 50),
            margin: deviceType.isTablet ? const EdgeInsets.only(left: 60) : const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.title, style: deviceType.isTablet ? MyTextTheme.darkGreyBold25 : MyTextTheme.boldDarkGray12),
                        Text("${"Starts from".translate(context)} \$ ${value.price}", style: deviceType.isTablet ? MyTextTheme.darkGrey25W300 : MyTextTheme.darkGreyW30012),
                      ],
                    ),
                    Text(value.description, overflow: TextOverflow.clip, style: deviceType.isTablet ? MyTextTheme.darkGrey25W300 : MyTextTheme.boldDarkGray12),
                  ] +
                  [
                    (isPrinter ? upgradesState.entertainmentsNumberOfSelected[index] : upgradesState.winesNumberOfSelected[index]) == 0
                        ? MyElevatedButton(
                            width: deviceType.isTablet ? 110 : 80,
                            height: deviceType.isTablet ? 50 : 30,
                            fontSize: deviceType.isTablet ? 25 : 15,
                            fgColor: MyColors.white,
                            bgColor: color,
                            buttonText: "Add",
                            function: () {
                              isPrinter ? upgradesController.addEntertainment(index) : upgradesController.addWine(index);
                            },
                          )
                        : ChangeNumOfSelected(
                            value: value,
                            index: index,
                            isPrinter: isPrinter,
                            color: color,
                            numberOfSelected: isPrinter ? upgradesState.entertainmentsNumberOfSelected[index] : upgradesState.winesNumberOfSelected[index],
                          )
                  ],
            ),
          ),
          Positioned(
            left: isPrinter ? -5 : -30,
            child: SizedBox(
              height: deviceType.isTablet ? 300 : 180,
              child: Center(
                child: SizedBox(
                  height: deviceType.isTablet ? (isPrinter ? 200 : 230) : (isPrinter ? 100 : 130),
                  child: Image.asset(
                    value.imageUrl.substring(1), // To remove "/" from beginning of the url.
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeNumOfSelected extends StatelessWidget {
  const ChangeNumOfSelected({
    Key? key,
    required this.value,
    required this.index,
    required this.isPrinter,
    required this.color,
    required this.numberOfSelected,
  }) : super(key: key);

  final Extra value;
  final int index;
  final int numberOfSelected;
  final bool isPrinter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final UpgradesController upgradesController = getIt<UpgradesController>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      width: deviceType.isTablet ? 110 : 80,
      height: deviceType.isTablet ? 50 : 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: deviceType.isTablet ? 35 : 25,
            color: color,
            child: InkWell(
              onTap: () {
                isPrinter ? upgradesController.removeEntertainment(index) : upgradesController.removeWine(index);
              },
              child: Center(child: Icon(Icons.remove, color: MyColors.white, size: deviceType.isTablet ? 22 : 18)),
            ),
          ),
          Container(
            width: deviceType.isTablet ? 40 : 30,
            color: (color).withOpacity(0.7),
            alignment: Alignment.center,
            child: Text("$numberOfSelected", style: TextStyle(fontSize: deviceType.isTablet ? 22 : 15, color: MyColors.white)),
          ),
          Container(
            width: deviceType.isTablet ? 35 : 25,
            color: color,
            child: InkWell(
              onTap: () {
                isPrinter ? upgradesController.addEntertainment(index) : upgradesController.addWine(index);
              },
              child: Center(child: Icon(Icons.add, color: MyColors.white, size: deviceType.isTablet ? 22 : 18)),
            ),
          ),
        ],
      ),
    );
  }
}
