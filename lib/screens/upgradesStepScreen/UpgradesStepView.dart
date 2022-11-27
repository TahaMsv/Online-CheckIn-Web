import 'package:flutter/material.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import '../../global/Classes.dart';
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
      body:Obx(() => !myUpgradesStepController.loading.value
          ? Center(
        child: CircularProgressIndicator(),
      )
          :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(
            title: "Upgrades".tr,
            description: "All upgrades are non-refundable".tr,
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
      ),)

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
    String languageCode = Get.locale!.languageCode;
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wines & Drinks".tr,
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

                    icon:RotationTransition(
                      turns: languageCode == "en" ? AlwaysStoppedAnimation(0 / 360) : AlwaysStoppedAnimation(180 / 360),
                      child: Icon(
                        MenuIcons.iconLeftArrow,
                        size: 35,
                      ),
                    ),


                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Obx(
                        () => Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: scrollDirection,
                          controller: controller,
                          itemCount: widget.upgradesStepController.winesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AutoScrollTag(
                              key: ValueKey(index),
                              controller: controller,
                              index: index,
                              child: UpgradeItemWidget(
                                index: index,
                                value: widget.upgradesStepController.winesList[index],
                                upgradesStepController: widget.upgradesStepController,
                                isPrinter: false,
                              ),
                              highlightColor: Colors.black.withOpacity(0.1),
                            );
                          }),
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
                    icon:RotationTransition(
                      turns: languageCode == "en" ? AlwaysStoppedAnimation(0 / 360) : AlwaysStoppedAnimation(180 / 360),
                      child: Icon(
                        MenuIcons.iconRightArrow,
                        size: 35,
                      ),
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
    required this.isPrinter,
    required this.upgradesStepController,
    required this.index,
  }) : super(key: key);

  final Extra value;
  final bool isPrinter;
  final UpgradesStepController upgradesStepController;
  final int index;

  @override
  Widget build(BuildContext context) {
    Color color;
    if (isPrinter) {
      color = upgradesStepController.colors[4];
    } else {
      color = upgradesStepController.colors[index % 4];
    }
    return Container(
      // height: 100,
      width: 330,
      // color: Colors.red,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Container(
            height: 180,
            color: (color).withOpacity(0.1),
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
                      value.title,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff424242),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Starts from".tr+ " \$ ${value.price}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff424242),
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                Text(
                  value.description,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff424242),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Obx(() =>  (() {
                  if (isPrinter) {
                    return upgradesStepController.entertainmentsNumberOfSelected[index] == 0
                        ? MyElevatedButton(
                      width: 80,
                      height: 30,
                      fgColor: Colors.white,
                      bgColor: color,
                      buttonText: "Add".tr,
                      function: () {
                        upgradesStepController.addEntertainment(index);
                      },
                    )
                        : ChangeNumOfSelected(
                      value: value,
                      index: index,
                      upgradesStepController: upgradesStepController,
                      isPrinter: isPrinter,
                      color: color,
                      numberOfSelected: upgradesStepController.entertainmentsNumberOfSelected[index],
                    );
                  } else {
                    return upgradesStepController.winesNumberOfSelected[index] == 0
                        ? MyElevatedButton(
                      width: 80,
                      height: 30,
                      fgColor: Colors.white,
                      bgColor: color,
                      buttonText: "Add".tr,
                      function: () {
                        upgradesStepController.addWine(index);
                      },
                    )
                        : ChangeNumOfSelected(
                      value: value,
                      index: index,
                      upgradesStepController: upgradesStepController,
                      isPrinter: isPrinter,
                      color: color,
                      numberOfSelected: upgradesStepController.winesNumberOfSelected[index],
                    );
                  }
                }()),)

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
    required this.upgradesStepController,
    required this.index,
    required this.isPrinter,
    required this.color,
    required this.numberOfSelected,
  }) : super(key: key);

  final Extra value;
  final UpgradesStepController upgradesStepController;
  final int index;
  final int numberOfSelected;
  final bool isPrinter;
  final Color color;

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
              color: (color).withOpacity(0.5),
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
            color: (color).withOpacity(0.7),
            child: Center(
              child: Text(
                "$numberOfSelected",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            width: 25,
            child: Material(
              color: color,
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
              "Entertainment".tr,
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