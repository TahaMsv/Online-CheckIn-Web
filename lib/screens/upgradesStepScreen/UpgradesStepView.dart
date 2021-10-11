import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../screens/upgradesStepScreen/UpgradesStepController.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class UpgradesStepView extends StatelessWidget {
  final UpgradesStepController myUpgradesStepController;

  UpgradesStepView(MainModel model) : myUpgradesStepController = Get.put(UpgradesStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(
            title: "Upgrades",
            description: "All upgrades are non-refundable",
          ),
          SizedBox(
            height: 10,
          ),
          WinesAndDrinksList(),
          Entertainment(),
        ],
      ),
    );
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
  late List<List<int>> randomList;

  var winesList = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  var currIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: scrollDirection);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wines & Drinks",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: Color(
                  0xff424242,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      if (currIndex >= 0) {
                        await controller.scrollToIndex(currIndex--, preferPosition: AutoScrollPosition.begin);
                      }
                    },
                    icon: Icon(
                      Icons.navigate_before,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: ListView(
                        scrollDirection: scrollDirection,
                        controller: controller,
                        children: <Widget>[
                          ...List.generate(winesList.length, (index) {
                            return AutoScrollTag(
                              key: ValueKey(index),
                              controller: controller,
                              index: index,
                              child: Container(
                                height: 100,
                                width: 400,
                                color: Colors.red,
                                margin: EdgeInsets.all(10),
                                child: Center(child: Text('index: $index')),
                              ),
                              highlightColor: Colors.black.withOpacity(0.1),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      if (currIndex < winesList.length - 1) {
                        await controller.scrollToIndex(currIndex++, preferPosition: AutoScrollPosition.begin);
                      }
                    },
                    icon: Icon(
                      Icons.navigate_next,
                      size: 35,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Entertainment extends StatelessWidget {
  const Entertainment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Entertainment",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: Color(
                  0xff424242,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 150,
                  width: 280,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
