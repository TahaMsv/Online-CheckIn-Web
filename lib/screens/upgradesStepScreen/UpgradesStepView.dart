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
          SizedBox(
            height: 10,
          ),
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
  var leftIndex = 0;
  var rightIndex = 2;

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
                      if (leftIndex >= 1) {
                        await controller.scrollToIndex(leftIndex - 1, preferPosition: AutoScrollPosition.begin);
                        leftIndex--;
                        rightIndex--;
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: scrollDirection,
                        controller: controller,
                        itemBuilder: (ctx, index) {
                          return AutoScrollTag(
                            key: ValueKey(index),
                            controller: controller,
                            index: index,
                            child: UpgradeItemWidget(),
                            highlightColor: Colors.black.withOpacity(0.1),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      if (rightIndex < winesList.length - 1) {
                        await controller.scrollToIndex(rightIndex, preferPosition: AutoScrollPosition.begin);
                        leftIndex++;
                        rightIndex++;
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

class UpgradeItemWidget extends StatelessWidget {
  const UpgradeItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 100,
        width: 350,
        color: Colors.red,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 90, right: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sparkling Wine",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff424242),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Starts from \$14.00",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff424242),
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Sparkling wine is a wine with significant levels of carbon dioxide in it. Making it fizzy",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff424242),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    color: Colors.amber,
                  )
                ],
              ),
            ),
            Positioned(
                left: 0,
                child: Container(
                  width: 70,
                  height: 200,
                  color: Colors.green,
                ))
          ],
        ));
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
            UpgradeItemWidget()
          ],
        ),
      ),
    );
  }
}
