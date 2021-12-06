import 'dart:math';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
import '../../global/Classes.dart';
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
        width: mySeatsStepController.calculatePlaneBodyLength(),
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
              width: 1800, //todo
              // height: 100,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: mySeatsStepController.cabins.length,
                itemBuilder: (_, i) {
                  return CabinWidget(
                    cabin: mySeatsStepController.cabins[i],
                    mySeatsStepController: mySeatsStepController,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CabinWidget extends StatelessWidget {
  final Cabin cabin;
  final SeatsStepController mySeatsStepController;

  const CabinWidget({Key? key, required this.cabin, required this.mySeatsStepController}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      // width: 1800,
      // height: 100,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cabin.linesCount,
        itemBuilder: (_, i) {
          return LineWidget(
            line: cabin.lines[i],
            mySeatsStepController: mySeatsStepController,
          );
        },
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  final Line line;
  final SeatsStepController mySeatsStepController;

  const LineWidget({Key? key, required this.line, required this.mySeatsStepController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return line.type == LineType.HORIZONTAL_CODE
        ? HorizontalCodeLine(
            cells: line.cells,
          )
        : BodyLine(
            cells: line.cells,
            mySeatsStepController: mySeatsStepController,
          );
  }
}

class HorizontalCodeLine extends StatelessWidget {
  final List<Cell> cells;

  const HorizontalCodeLine({Key? key, required this.cells}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cells.length,
        itemBuilder: (_, i) {
          return Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xff5d5d5d),
            ),
            child: Center(
              child: Text(
                cells[i].type == CellType.SEAT ? cells[i].value : "",
                style: TextStyle(
                  color: Color(0xffd1d1d1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BodyLine extends StatelessWidget {
  final List<Cell> cells;
  final SeatsStepController mySeatsStepController;

  const BodyLine({Key? key, required this.cells, required this.mySeatsStepController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cells.length,
        itemBuilder: (_, i) {
          return SeatWidget(
            mySeatsStepController: mySeatsStepController,
            cell: cells[i],
          );
        },
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

class SeatWidget extends StatelessWidget {
  const SeatWidget({
    Key? key,
    required this.mySeatsStepController,
    required this.cell,
  }) : super(key: key);
  final Cell cell;

  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: mySeatsStepController.seatsStatus[seatId] == "Block" || mySeatsStepController.seatsStatus[seatId] == "Checked-in"
      //     ? null
      //     : () {
      //         mySeatsStepController.changeSeatStatus(seatId);
      //       },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: cell.type == CellType.SEAT ? mySeatsStepController.getColor(cell.code) : Color(0xff5d5d5d),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            cell.type == CellType.SEAT
                ? cell.code
                : cell.type == CellType.VERTICAL_CODE
                    ? cell.value
                    : "",
            // style: TextStyle(
            //   color: mySeatsStepController.seatsStatus[seatId] != "Open" ? Colors.white : Color(0xffd1d1d1),
            // ),
          ),
        ),
        // child: mySeatsStepController.seatsStatus[seatId] == "Block"
        //     ? BlockedSeat()
        //     : mySeatsStepController.seatsStatus[seatId] == "Checked-in"
        //     ? CheckedInSeat(seatId: mySeatsStepController.seatsStatus[seatId]!)
        //     : mySeatsStepController.seatsStatus[seatId] == "Open"
        //     ? DroppableSeat(mySeatsStepController: mySeatsStepController, seatId: seatId)
        //     : DraggableSeat(mySeatsStepController: mySeatsStepController, seatId: seatId),
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
