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

import '../../core/utils/multi_languages.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class UpgradesViewWeb extends ConsumerWidget {
  UpgradesViewWeb({Key? key}) : super(key: key);
  final UpgradesController upgradesController = getIt<UpgradesController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    UpgradesState upgradesState = ref.watch(upgradesProvider);
    return Scaffold(
        backgroundColor: MyColors.white,
        body: upgradesState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepsScreenTitle(title: "Upgrades".translate(context), description: "All upgrades are non-refundable".translate(context)),
                  SizedBox(height: 10),
                  WinesAndDrinksList(),
                  SizedBox(height: 10),
                  Entertainment(),
                ],
              ));
  }
}

class WinesAndDrinksList extends ConsumerStatefulWidget {
  const WinesAndDrinksList({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<WinesAndDrinksList> createState() => _WinesAndDrinksListState();
}

class _WinesAndDrinksListState extends ConsumerState<WinesAndDrinksList> {
  final UpgradesController upgradesController = getIt<UpgradesController>();
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: Axis.horizontal);
  }

  @override
  Widget build(BuildContext context) {
    UpgradesState upgradesState = ref.watch(upgradesProvider);
    // String languageCode = MultiLanguages.of(context)!.locale.languageCode;  //todo
    List<Extra> winesList = ref.watch(winesListProvider)!;

    String languageCode = 'en';
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Wines & Drinks".translate(context), style: MyTextTheme.darkGreyW80013),
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
                      itemCount: winesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AutoScrollTag(
                          key: ValueKey(index),
                          controller: controller,
                          index: index,
                          highlightColor: Colors.black.withOpacity(0.1),
                          child: UpgradeItemWidget(index: index, value: winesList[index], isPrinter: false),
                        );
                      }),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    if (upgradesState.rightIndex < winesList.length - 1) {
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
//     UpgradesState upgradesState = ref.watch(upgradesProvider);
//         // String languageCode = MultiLanguages.of(context)!.locale.languageCode;  //todo
    String languageCode = 'en';
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
