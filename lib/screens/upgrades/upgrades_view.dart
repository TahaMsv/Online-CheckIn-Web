import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/upgrades/upgrades_controller.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';
import 'package:online_check_in/screens/upgrades/widgets/entertainments.dart';
import 'package:online_check_in/screens/upgrades/widgets/upgrade_items_widget.dart';
import '../../core/classes/extra.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class UpgradesView extends StatelessWidget {
  UpgradesView({Key? key}) : super(key: key);
  final UpgradesController upgradesController = getIt<UpgradesController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    UpgradesState upgradesState = context.watch<UpgradesState>();
    return Scaffold(
        backgroundColor: MyColors.white,
        body: upgradesState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  StepsScreenTitle(title: "Upgrades", description: "All upgrades are non-refundable"),
                  SizedBox(height: 10),
                  WinesAndDrinksList(),
                  SizedBox(height: 10),
                  Entertainment(isTabletMode: false),
                ],
              ));
  }
}

class WinesAndDrinksList extends StatefulWidget {
  const WinesAndDrinksList({
    Key? key,
  }) : super(key: key);

  @override
  State<WinesAndDrinksList> createState() => _WinesAndDrinksListState();
}

class _WinesAndDrinksListState extends State<WinesAndDrinksList> {
  final UpgradesController upgradesController = getIt<UpgradesController>();
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: Axis.horizontal);
  }

  @override
  Widget build(BuildContext context) {
    UpgradesState upgradesState = context.watch<UpgradesState>();
    String languageCode = "en";
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Wines & Drinks", style: MyTextTheme.darkGreyW80013),
          const SizedBox(height: 15),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    if (upgradesState.leftIndex >= 1) {
                      await controller.scrollToIndex(upgradesState.leftIndex - 1, preferPosition: AutoScrollPosition.begin);
                      upgradesState.setleftIndex(upgradesState.leftIndex - 1);
                      upgradesState.setrightIndex(upgradesState.rightIndex - 1);
                    }
                  },
                  icon: RotationTransition(
                    turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
                    child: const Icon(MenuIcons.iconLeftArrow, size: 35),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      itemCount: upgradesState.winesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AutoScrollTag(
                          key: ValueKey(index),
                          controller: controller,
                          index: index,
                          highlightColor: Colors.black.withOpacity(0.1),
                          child: UpgradeItemWidget(
                            index: index,
                            value: upgradesState.winesList[index],
                            isPrinter: false,
                            isTabletMode: false,
                          ),
                        );
                      }),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    if (upgradesState.rightIndex < upgradesState.winesList.length - 1) {
                      await controller.scrollToIndex(upgradesState.rightIndex, preferPosition: AutoScrollPosition.begin);
                      upgradesState.setleftIndex(upgradesState.leftIndex + 1);
                      upgradesState.setrightIndex(upgradesState.rightIndex + 1);
                    }
                  },
                  icon: RotationTransition(
                    turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
                    child: const Icon(MenuIcons.iconRightArrow, size: 35),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class _WinesAndDrinksListState extends State<WinesAndDrinksList> {
//   final scrollDirection = Axis.horizontal;
//
//   late AutoScrollController controller;
//   var leftIndex = 0;
//   var rightIndex = 2;
//   final UpgradesController upgradesController = getIt<UpgradesController>();
//
//   @override
//   void initState() {
//     super.initState();
//     controller = AutoScrollController(viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: scrollDirection);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     UpgradesState upgradesState = context.watch<UpgradesState>();
//     String languageCode = "en";
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Wines & Drinks", style: MyTextTheme.darkGreyW80013),
//           const SizedBox(height: 15),
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () async {
//                     if (leftIndex >= 1) {
//                       await controller.scrollToIndex(leftIndex - 1, preferPosition: AutoScrollPosition.begin);
//                       leftIndex--;
//                       rightIndex--;
//                     }
//                   },
//                   icon: RotationTransition(
//                     turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
//                     child: const Icon(MenuIcons.iconLeftArrow, size: 35),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: scrollDirection,
//                       controller: controller,
//                       itemCount: upgradesState.winesList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return AutoScrollTag(
//                           key: ValueKey(index),
//                           controller: controller,
//                           index: index,
//                           highlightColor: Colors.black.withOpacity(0.1),
//                           child: UpgradeItemWidget(
//                             index: index,
//                             value: upgradesState.winesList[index],
//                             isPrinter: false,
//                             isTabletMode: false,
//                           ),
//                         );
//                       }),
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   onPressed: () async {
//                     if (rightIndex < upgradesState.winesList.length - 1) {
//                       await controller.scrollToIndex(rightIndex, preferPosition: AutoScrollPosition.begin);
//                       leftIndex++;
//                       rightIndex++;
//                     }
//                   },
//                   icon: RotationTransition(
//                     turns: languageCode == "en" ? const AlwaysStoppedAnimation(0 / 360) : const AlwaysStoppedAnimation(180 / 360),
//                     child: const Icon(MenuIcons.iconRightArrow, size: 35),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
