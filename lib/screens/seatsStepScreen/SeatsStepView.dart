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
                Stack(
                  children: [
                    PlaneHead(),
                    PlaneWings(),
                    PlaneTail(),
                    PlaneBody(
                      mySeatsStepController: mySeatsStepController,
                    ),
                  ],
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
            width: 720,
          ),
          Container(
            child: Image.asset(
              "assets/images/Down Wing.png",
              fit: BoxFit.contain,
              // height: 350,
            ),
            width: 720,
          ),
        ],
      ),
    );
  }
}

class PlaneBody extends StatelessWidget {
  const PlaneBody({
    Key? key,
    required this.mySeatsStepController,
  }) : super(key: key);
  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 352,
        margin: EdgeInsets.only(left: 395, top: 7),
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
                        mySeatsStepController: mySeatsStepController,
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
        padding: EdgeInsets.only(top: 30, bottom: 22),
        margin: EdgeInsets.only(left: 1850),
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
    required this.mySeatsStepController,
  }) : super(key: key);

  final int i;
  final SeatsStepController mySeatsStepController;

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
          return SeatColumn(
            columnNumber: columnNumber,
            mySeatsStepController: mySeatsStepController,
          );
        },
      ),
    );
  }
}

class SeatColumn extends StatelessWidget {
  const SeatColumn({
    Key? key,
    required this.columnNumber,
    required this.mySeatsStepController,
  }) : super(key: key);

  final int columnNumber;
  final SeatsStepController mySeatsStepController;

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
              return SeatWidget(
                topMargin: topMargin,
                columnNumber: columnNumber,
                rowCode: rowCode,
                mySeatsStepController: mySeatsStepController,
              );
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
    required this.mySeatsStepController,
  }) : super(key: key);

  final double topMargin;
  final int columnNumber;
  final String rowCode;
  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    var seatId = columnNumber.toString() + rowCode;
    return GestureDetector(
      onTap: mySeatsStepController.seatsStatus[seatId] == "blocked"
          ? null
          : () {
              mySeatsStepController.changeSeatStatus(seatId);
            },
      child: Container(
        margin: EdgeInsets.only(
          top: topMargin,
        ),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: mySeatsStepController.getColor(seatId),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: mySeatsStepController.seatsStatus[seatId] == "blocked"
            ? Container(
                decoration: BoxDecoration(
                  color: mySeatsStepController.getColor(seatId),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 15,
                ),
              )
            : mySeatsStepController.seatsStatus[seatId] == "selected"
                ? DraggableSeat(mySeatsStepController: mySeatsStepController, seatId: seatId)
                : DroppableSeat(mySeatsStepController: mySeatsStepController, seatId: seatId),
      ),
    );
  }
}

class DroppableSeat extends StatelessWidget {
  const DroppableSeat({
    Key? key,
    required this.mySeatsStepController,
    required this.seatId,
  }) : super(key: key);

  final SeatsStepController mySeatsStepController;
  final String seatId;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
        return Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: mySeatsStepController.getColor(seatId),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              seatId,
              style: TextStyle(
                color: mySeatsStepController.seatsStatus[seatId] == "selected" ? Colors.white : Color(0xffd1d1d1),
              ),
            ),
          ),
        );
      },
      onAccept: (_) {
        mySeatsStepController.changeSeatStatus(seatId);
      },
    );
  }
}

class DraggableSeat extends StatelessWidget {
  const DraggableSeat({
    Key? key,
    required this.mySeatsStepController,
    required this.seatId,
  }) : super(key: key);

  final SeatsStepController mySeatsStepController;
  final String seatId;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: DraggableItem(
        mySeatsStepController: mySeatsStepController,
        seatId: seatId,
        color: mySeatsStepController.getColor(seatId).withOpacity(0.5),
        isDragged: true,
      ),
      child: DraggableItem(
        mySeatsStepController: mySeatsStepController,
        seatId: seatId,
        color: mySeatsStepController.getColor(seatId),
        isDragged: false,
      ),
      childWhenDragging: DraggableItem(
        mySeatsStepController: mySeatsStepController,
        seatId: seatId,
        color: mySeatsStepController.getColor(seatId).withOpacity(0.2),
        isDragged: false,
      ),
      onDragCompleted: () {
        mySeatsStepController.changeSeatStatus(seatId);
      },
    );
  }
}

class DraggableItem extends StatelessWidget {
  const DraggableItem({
    Key? key,
    required this.mySeatsStepController,
    required this.seatId,
    required this.color,
    required this.isDragged,
  }) : super(key: key);

  final SeatsStepController mySeatsStepController;
  final String seatId;
  final Color color;
  final bool isDragged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: isDragged
          ? null
          : Center(
              child: Text(
                seatId,
                style: TextStyle(
                  color: mySeatsStepController.seatsStatus[seatId] == "selected" ? Colors.white : Color(0xffd1d1d1),
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
