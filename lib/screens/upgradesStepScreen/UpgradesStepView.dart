import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/MyElevatedButton.dart';
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
          WinesAndDrinksList(
            upgradesStepController: myUpgradesStepController,
          ),
          SizedBox(
            height: 10,
          ),
          Entertainment(
            upgradesStepController: myUpgradesStepController,
          ),
        ],
      ),
    );
  }
}

class WinesAndDrinksList extends StatefulWidget {
  const WinesAndDrinksList({
    Key? key,
    required this.upgradesStepController,
  }) : super(key: key);

  final UpgradesStepController upgradesStepController;

  @override
  State<WinesAndDrinksList> createState() => _WinesAndDrinksListState();
}

class _WinesAndDrinksListState extends State<WinesAndDrinksList> {
  final scrollDirection = Axis.horizontal;

  late AutoScrollController controller;

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
                  Obx(
                    () => Expanded(
                      child: Container(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: scrollDirection,
                          controller: controller,
                          children: widget.upgradesStepController.winesList.map((value) {
                            int index = widget.upgradesStepController.winesList.indexOf(value);
                            return AutoScrollTag(
                              key: ValueKey(index),
                              controller: controller,
                              index: index,
                              child: UpgradeItemWidget(
                                index: index,
                                value: value,
                                upgradesStepController: widget.upgradesStepController,
                              ),
                              highlightColor: Colors.black.withOpacity(0.1),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      if (rightIndex < widget.upgradesStepController.winesList.length - 1) {
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
    required this.upgradesStepController,
    required this.index,
  }) : super(key: key);

  final Map<String, dynamic> value;
  final bool isPrinter;
  final UpgradesStepController upgradesStepController;
  final int index;

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
            color: (value["color"]! as Color).withOpacity(0.1),
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
                value["numberOfSelected"] == 0
                    ? MyElevatedButton(
                        width: 80,
                        height: 30,
                        fgColor: Colors.white,
                        bgColor: value["color"]!,
                        buttonText: "Add",
                        function: () {
                          isPrinter ? upgradesStepController.addEntertainment(index) : upgradesStepController.addWine(index);
                        },
                      )
                    : ChangeNumOfSelected(
                        value: value,
                        index: index,
                        upgradesStepController: upgradesStepController,
                        isPrinter: isPrinter,
                      ),
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
    required this.upgradesStepController,
    required this.index,
    required this.isPrinter,
  }) : super(key: key);

  final Map<String, dynamic> value;
  final UpgradesStepController upgradesStepController;
  final int index;
  final bool isPrinter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 25,
            child: Material(
              color: (value["color"]! as Color).withOpacity(0.5),
              child: InkWell(
                onTap: () {
                  isPrinter ? upgradesStepController.removeEntertainment(index) : upgradesStepController.removeWine(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    ), // icon// text
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 30,
            color: (value["color"]! as Color).withOpacity(0.7),
            child: Center(
              child: Text(
                "${value["numberOfSelected"]}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            width: 25,
            child: Material(
              color: value["color"]!,
              child: InkWell(
                onTap: () {
                  isPrinter ? upgradesStepController.addEntertainment(index) : upgradesStepController.addWine(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ), // icon// text
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
    required this.upgradesStepController,
  }) : super(key: key);

  final UpgradesStepController upgradesStepController;

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
            Obx(
              () => Expanded(
                child: UpgradeItemWidget(
                  value: upgradesStepController.entertainmentsList[0],
                  index: 0,
                  upgradesStepController: upgradesStepController,
                  isPrinter: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
