import 'dart:math';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../screens/seatsStepScreen/SeatsStepController.dart';
import '../../screens/visaStepScreen/VisaStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class SeatsStepView extends StatelessWidget {
  final SeatsStepController mySeatsStepController;

  SeatsStepView(MainModel model) : mySeatsStepController = Get.put(SeatsStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Expanded(
          // height: 395,
          // color: Colors.red,
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      PlaneHead(),
                      PlaneWings(),
                      PlaneTail(),
                      PlaneBody(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaneWings extends StatelessWidget {
  const PlaneWings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.asset(
              "assets/images/Up Wing.png",
              fit: BoxFit.contain,
              // height: 350,
            ),
            width: 420,
          ),
          Container(
            child: Image.asset(
              "assets/images/Down Wing.png",
              fit: BoxFit.contain,
              // height: 350,
            ),
            width: 420,
          ),
        ],
      ),
    );
  }
}

class PlaneBody extends StatelessWidget {
  const PlaneBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 352,
        margin: EdgeInsets.only(left: 395,top: 7),
        width: 1800,
        decoration: BoxDecoration(
          color: Color(0xff5d5d5d),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: 1800,
              height: 100,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (_, i) {
                  switch (i) {
                    case 0:
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              child: ListView.builder(
                                itemBuilder: (_, z) {
                                  double topMargin = (z == 3 ? 30 : 10);
                                  String rowCode = String.fromCharCode(70 - z);
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: topMargin,
                                    ),
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        rowCode,
                                        style: TextStyle(
                                          color: Color(0xffd1d1d1),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 6,
                                scrollDirection: Axis.vertical,
                              ),
                              height: 300,
                              width: 35,
                            )
                          ],
                        ),
                      );
                    default:
                      return SeatBlocks(
                        i: i,
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaneHead extends StatelessWidget {
  const PlaneHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Positioned(
        left: 20,

        child: Container(
          // height: 440,
          width: 413,
          child: Image.asset(
            "assets/images/Airplane Head.png",
            fit: BoxFit.contain,
            // height: 350,
          ),
          // margin: EdgeInsets.only(left: 20),
          // width: 400,
        ),
      ),
    );
  }
}
class PlaneTail extends StatelessWidget {
  const PlaneTail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 30,bottom: 22),
        margin: EdgeInsets.only(left: 2180),
        // width: 2400,
        child: Image.asset(
          "assets/images/Edited-Tail.png",
        ),
      ),
    );
  }
}

class SeatBlocks extends StatelessWidget {
  const SeatBlocks({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      width: 500,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (_, j) {
          final columnNumber = (i - 1) * 10 + j + 1;
          return SeatColumn(columnNumber: columnNumber);
        },
      ),
    );
  }
}

class SeatColumn extends StatelessWidget {
  const SeatColumn({
    Key? key,
    required this.columnNumber,
  }) : super(key: key);

  final int columnNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Center(
            child: Text(
              "$columnNumber",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          child: ListView.builder(
            itemBuilder: (_, z) {
              double topMargin = (z == 3 ? 30 : 10);
              String rowCode = String.fromCharCode(70 - z);
              return SeatWidget(topMargin: topMargin, columnNumber: columnNumber, rowCode: rowCode);
            },
            itemCount: 6,
            scrollDirection: Axis.vertical,
          ),
          height: 300,
          width: 35,
        )
      ],
    );
  }
}

class SeatWidget extends StatelessWidget {
  const SeatWidget({
    Key? key,
    required this.topMargin,
    required this.columnNumber,
    required this.rowCode,
  }) : super(key: key);

  final double topMargin;
  final int columnNumber;
  final String rowCode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(
          top: topMargin,
        ),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            columnNumber.toString() + rowCode,
            style: TextStyle(
              color: Color(0xffd1d1d1),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
