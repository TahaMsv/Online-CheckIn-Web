import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/upgrades_controller.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/upgrades_state.dart';
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
                children: [
                  const StepsScreenTitle(title: "Upgrades", description: "All upgrades are non-refundable"),
                  const SizedBox(height: 10),
                  const WinesAndDrinksList(),
                  const SizedBox(height: 10),
                  Entertainment(upgradesController: upgradesController),
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
  final scrollDirection = Axis.horizontal;

  late AutoScrollController controller;
  var leftIndex = 0;
  var rightIndex = 2;
  final UpgradesController upgradesController = getIt<UpgradesController>();

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: scrollDirection);
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
                    if (leftIndex >= 1) {
                      await controller.scrollToIndex(leftIndex - 1, preferPosition: AutoScrollPosition.begin);
                      leftIndex--;
                      rightIndex--;
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
                      scrollDirection: scrollDirection,
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
                          ),
                        );
                      }),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    if (rightIndex < upgradesState.winesList.length - 1) {
                      await controller.scrollToIndex(rightIndex, preferPosition: AutoScrollPosition.begin);
                      leftIndex++;
                      rightIndex++;
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
    Color color;
    if (isPrinter) {
      color = upgradesState.colors[4];
    } else {
      color = upgradesState.colors[index % 4];
    }
    return Container(
      width: 330,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Container(
            height: 180,
            color: (color).withOpacity(0.1),
            padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 50),
            margin: const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.title, style: MyTextTheme.boldDarkGray12),
                        Text("${"Starts from"} \$ ${value.price}", style: MyTextTheme.darkGreyW30012),
                      ],
                    ),
                    Text(value.description, overflow: TextOverflow.clip, style: MyTextTheme.boldDarkGray12),
                  ] +
                  [
                    upgradesState.entertainmentsNumberOfSelected[index] == 0
                        ? MyElevatedButton(
                            width: 80,
                            height: 30,
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
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: isPrinter ? 100 : 130,
                    child: Image.asset(
                      value.imageUrl.substring(1), // To remove "/" from beginning of the url.
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
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
    return Container(
      width: 80,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            child: Material(
              color: (color).withOpacity(0.5),
              child: InkWell(
                onTap: () {
                  isPrinter ? upgradesController.removeEntertainment(index) : upgradesController.removeWine(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.remove, color: MyColors.white, size: 18), // icon// text
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 30,
            color: (color).withOpacity(0.7),
            child: Center(
              child: Text("$numberOfSelected", style: const TextStyle(color: MyColors.white)),
            ),
          ),
          SizedBox(
            width: 25,
            child: Material(
              color: color,
              child: InkWell(
                onTap: () {
                  isPrinter ? upgradesController.addEntertainment(index) : upgradesController.addWine(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.add, color: MyColors.white, size: 18), // icon// text
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Entertainment extends StatelessWidget {
  const Entertainment({
    Key? key,
    required this.upgradesController,
  }) : super(key: key);

  final UpgradesController upgradesController;

  @override
  Widget build(BuildContext context) {
    UpgradesState upgradesState = context.watch<UpgradesState>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Entertainment", style: MyTextTheme.darkGreyW80013),
          const SizedBox(height: 15),
          Expanded(child: UpgradeItemWidget(value: upgradesState.entertainmentsList[0], index: 0, isPrinter: true)),
        ],
      ),
    );
  }
}
