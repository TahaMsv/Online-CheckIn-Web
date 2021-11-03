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
    {
      "name": "Sparkling Wine",
      "description": "Sparkling wine is a wine with significant levels of carbon dioxide in it. Making it fizzy",
      "imagePath": "assets/images/sparkling-wine.png",
      "color": Color(0xfffffaf2),
    },
    {
      "name": "Prosecco",
      "description": "Prosecco is a sparkling wine that’s often taken for granted",
      "imagePath": "assets/images/prosecco-wine.png",
      "color": Color(0xfff2f3ff),
    },
    {
      "name": "Champagne",
      "description": "Champagne is a French sparkling wine",
      "imagePath": "assets/images/champagne.png",
      "color": Color(0xfffff2f2),
    },

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
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: scrollDirection,
                        controller: controller,
                        children: winesList.map((value) {
                          int index = winesList.indexOf(value);
                          return AutoScrollTag(
                            key: ValueKey(index),
                            controller: controller,
                            index: index,
                            child: UpgradeItemWidget(
                              value: value,
                            ),
                            highlightColor: Colors.black.withOpacity(0.1),
                          );
                        }).toList(),
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
    required this.value,
    this.isPrinter = false,
  }) : super(key: key);

  final Map<String, dynamic> value;
  final bool isPrinter;

  @override
  Widget build(BuildContext context) {
    double margin = isPrinter ? 40 : 30;
    return Container(
        // height: 100,
        width: 330,
        // color: Colors.red,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Stack(
          children: [
            Container(
              height: 180,
              color: value["color"]!,
              padding: EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 50),
              margin: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value["name"]!,
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
                    value["description"]!,
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
                left: isPrinter ? -5 : -30,
                child: Container(
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // width: 150,
                        height: isPrinter ? 100 : 130,
                        // color: Colors.green,
                        child: Image.asset(
                          value["imagePath"]!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
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
            Expanded(
              child: UpgradeItemWidget(
                value: const {
                  "name": "Photo print",
                  "description": "Confirm your flight details and see which extras you already purchased",
                  "imagePath": "assets/images/printer.png",
                  "color": Color(0xfff4f4f4),
                },
                isPrinter: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
