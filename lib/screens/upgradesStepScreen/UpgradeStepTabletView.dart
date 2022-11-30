import 'package:flutter/material.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import '../../global/Classes.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../screens/upgradesStepScreen/UpgradesStepController.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class UpgradesStepTabletView extends StatelessWidget {
  final UpgradesStepController myUpgradesStepController;

  UpgradesStepTabletView(MainModel model) : myUpgradesStepController = Get.put(UpgradesStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => !myUpgradesStepController.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StepsScreenTitle(
                      title: "Upgrades".tr,
                      description: "",
                      fontSize: 45,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "All upgrades are non-refundable".tr,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    WinesAndDrinksList(
                      upgradesStepController: myUpgradesStepController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Entertainment(
                      upgradesStepController: myUpgradesStepController,
                    ),
                  ],
                ),
        ));
  }
}

class WinesAndDrinksList extends StatelessWidget {
  const WinesAndDrinksList({
    Key? key,
    required this.upgradesStepController,
  }) : super(key: key);

  final UpgradesStepController upgradesStepController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      width: Get.width,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wines & Drinks".tr,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 25,
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
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: upgradesStepController.winesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UpgradeItemWidget(
                      index: index,
                      value: upgradesStepController.winesList[index],
                      upgradesStepController: upgradesStepController,
                      isPrinter: false,
                    );
                  }),
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
      width: 600,
      // color: Colors.blue,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Container(
            height: 300,
            color: (color).withOpacity(0.1),
            padding: EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 100),
            margin: EdgeInsets.only(left: 60),
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
                        fontSize: 25,
                        color: Color(0xff424242),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Starts from".tr + " \$ ${value.price}",
                      style: TextStyle(
                        fontSize: 25,
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
                    fontSize: 25,
                    color: Color(0xff424242),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Obx(
                  () => (() {
                    if (isPrinter) {
                      return upgradesStepController.entertainmentsNumberOfSelected[index] == 0
                          ? MyElevatedButton(
                              width: 110,
                              height: 50,
                              fontSize: 25,
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
                              width: 110,
                              height: 50,
                              fontSize: 25,
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
                  }()),
                )
              ],
            ),
          ),
          Positioned(
            left: isPrinter ? -5 : -30,
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // width: 150,
                    height: isPrinter ? 200 : 230,
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
      width: 110,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35,
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
                      size: 22,
                    ), // icon// text
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            color: (color).withOpacity(0.7),
            child: Center(
              child: Text(
                "$numberOfSelected",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
          Container(
            width: 35,
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
                      size: 22,
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
                fontSize: 25,
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
