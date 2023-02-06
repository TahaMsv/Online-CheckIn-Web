import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/classes/extra.dart';
import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../upgrades_controller.dart';
import '../upgrades_state.dart';

class UpgradeItemWidget extends StatelessWidget {
  const UpgradeItemWidget({
    Key? key,
    required this.value,
    required this.isPrinter,
    required this.index,
    required this.isTabletMode,
  }) : super(key: key);

  final Extra value;
  final bool isPrinter;
  final int index;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    final UpgradesController upgradesController = getIt<UpgradesController>();
    UpgradesState upgradesState = context.watch<UpgradesState>();
    Color color;
    if (isPrinter) {
      color = upgradesState.colors[4];
    } else {
      color = upgradesState.colors[index % 4];
    }
    return Container(
      width: isTabletMode ? 600 : 330,
      margin: isTabletMode ? const EdgeInsets.only(left: 10, right: 10) : const EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Container(
            height: isTabletMode ? 300 : 180,
            color: (color).withOpacity(0.1),
            padding: isTabletMode ? const EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 100) : const EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 50),
            margin: isTabletMode ? const EdgeInsets.only(left: 60) : const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.title, style: isTabletMode ? MyTextTheme.darkGreyBold25 : MyTextTheme.boldDarkGray12),
                        Text("${"Starts from"} \$ ${value.price}", style: isTabletMode ? MyTextTheme.darkGrey25W300 : MyTextTheme.darkGreyW30012),
                      ],
                    ),
                    Text(value.description, overflow: TextOverflow.clip, style: isTabletMode ? MyTextTheme.darkGrey25W300 : MyTextTheme.boldDarkGray12),
                  ] +
                  [
                    (isPrinter ? upgradesState.entertainmentsNumberOfSelected[index] : upgradesState.winesNumberOfSelected[index]) == 0
                        ? MyElevatedButton(
                            width: isTabletMode ? 110 : 80,
                            height: isTabletMode ? 50 : 30,
                            fontSize: isTabletMode ? 25 : 15,
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
                            isTabletMode: isTabletMode,
                          )
                  ],
            ),
          ),
          Positioned(
            left: isPrinter ? -5 : -30,
            child: SizedBox(
              height: isTabletMode ? 300 : 180,
              child: Center(
                child: SizedBox(
                  height: isTabletMode ? (isPrinter ? 200 : 230) : (isPrinter ? 100 : 130),
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
    required this.isTabletMode,
  }) : super(key: key);

  final Extra value;
  final int index;
  final int numberOfSelected;
  final bool isPrinter;
  final bool isTabletMode;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final UpgradesController upgradesController = getIt<UpgradesController>();
    return Container(
      width: isTabletMode ? 110 : 80,
      height: isTabletMode ? 50 : 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: isTabletMode ? 35 : 25,
            color: color,
            child: InkWell(
              onTap: () {
                isPrinter ? upgradesController.removeEntertainment(index) : upgradesController.removeWine(index);
              },
              child: Center(child: Icon(Icons.remove, color: MyColors.white, size: isTabletMode ? 22 : 18)),
            ),
          ),
          Container(
            width: isTabletMode ? 40 : 30,
            color: (color).withOpacity(0.7),
            alignment: Alignment.center,
            child: Text("$numberOfSelected", style: TextStyle(fontSize: isTabletMode ? 22 : 15, color: MyColors.white)),
          ),
          Container(
            width: isTabletMode ? 35 : 25,
            color: color,
            child: InkWell(
              onTap: () {
                isPrinter ? upgradesController.addEntertainment(index) : upgradesController.addWine(index);
              },
              child: Center(child: Icon(Icons.add, color: MyColors.white, size: isTabletMode ? 22 : 18)),
            ),
          ),
        ],
      ),
    );
  }
}
