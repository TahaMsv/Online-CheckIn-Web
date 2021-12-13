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
                    PlaneHead(
                      height: mySeatsStepController.calculatePlaneBodyHeight() + 47,
                    ),
                    // PlaneWings(),
                    PlaneTail(
                      height: mySeatsStepController.calculatePlaneBodyHeight() + 150,
                      margin: mySeatsStepController.calculatePlaneBodyLength(),
                    ),
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
        height: mySeatsStepController.calculatePlaneBodyHeight(),
        margin: EdgeInsets.only(left: 395, top: 7),
        width: mySeatsStepController.calculatePlaneBodyLength(),
        decoration: BoxDecoration(
          color: Color(0xff5d5d5d),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Expanded(
          child: Center(
            child: Container(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: mySeatsStepController.cabins.length,
                itemBuilder: (_, i) {
                  // print("PlaneBody " + i.toString());
                  // print("lines: " + mySeatsStepController.cabins[i].linesCount.toString());
                  return CabinWidget(
                    width: mySeatsStepController.calculateCabinLength(i),
                    height: mySeatsStepController.calculateCabinHeight(i),
                    cabin: mySeatsStepController.cabins[i],
                    mySeatsStepController: mySeatsStepController,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CabinWidget extends StatelessWidget {
  final Cabin cabin;
  final SeatsStepController mySeatsStepController;
  final double height;
  final double width;

  const CabinWidget({Key? key, required this.cabin, required this.mySeatsStepController, required this.height, required this.width}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: width + 60,
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
              margin: EdgeInsets.only(top: 10, left: 5),
              child: Text(
                cabin.cabinTitle,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
            child: Container(
              height: height,
              width: width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: cabin.linesCount,
                itemBuilder: (_, i) {
                  // print("cabin widget: " + i.toString());
                  // print("line type: " + cabin.lines[i].type);
                  return
                      //   Container(
                      //   width: 45,
                      //   margin: EdgeInsets.all(3),
                      //   color: Colors.greenAccent,
                      // );
                      LineWidget(
                    line: cabin.lines[i],
                    mySeatsStepController: mySeatsStepController,
                  );
                },
              ),
            ),
          ),
        ],
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
    return Container(
      width: 45,
      margin: EdgeInsets.all(3),
      child: line.type == "HorizontalCode"
          ? HorizontalCodeLine(
              cells: line.cells,
            )
          : BodyLine(
              cells: line.cells,
              mySeatsStepController: mySeatsStepController,
            ),
    );
  }
}

class HorizontalCodeLine extends StatelessWidget {
  final List<Cell> cells;

  const HorizontalCodeLine({Key? key, required this.cells}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 300,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: cells.length,
        itemBuilder: (_, i) {
          return Container(
            margin: EdgeInsets.all(2),
            width: cells[i].type == "Seat" || cells[i].type == "OutEquipmentExit" ? 35 : 15,
            height: cells[i].type == "Seat" || cells[i].type == "OutEquipmentExit" ? 35 : 15,
            decoration: BoxDecoration(
              color: Color(0xff5d5d5d),
            ),
            child: Center(
              child: Text(
                cells[i].type! == "Seat" ? cells[i].value! : "",
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
      width: 50,
      height: 300,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
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
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Positioned(
        left: 20,
        child: Container(
          height: height,
          // width: 413,
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
    required this.margin,
    required this.height,
  }) : super(key: key);

  final double margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 22),
        margin: EdgeInsets.only(left: margin + 50),
        // width: 2400,
        // height: height+100,
        child: Image.asset(
          "assets/images/Edited-Tail.png",
          fit: BoxFit.contain,
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
      onTap: cell.type != "Seat"
          ? null
          : mySeatsStepController.seatsStatus[cell.code] == "Block" || mySeatsStepController.seatsStatus[cell.code] == "Checked-in"
              ? null
              : () {
                  print("here" + cell.code!);
                  mySeatsStepController.changeSeatStatus(cell.code!);
                },
      child: Container(
        width: cell.type == "Seat" || cell.type == "OutEquipmentExit" ? 35 : 15,
        height: cell.type == "Seat" || cell.type == "OutEquipmentExit" ? 35 : 15,

        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: cell.type == "Seat" ? mySeatsStepController.getColor(cell.code!): Color(0xff5d5d5d),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: cell.value == "ExitDoor"
            ? Icon(
                Icons.sensor_door_outlined,
                color: Colors.red,
              )
            : cell.type == "Seat" && mySeatsStepController.seatsStatus[cell.code] == "Block"
                ? BlockedSeat()
                : cell.type == "Seat" && mySeatsStepController.seatsStatus[cell.code] == "Checked-in"
                    ? CheckedInSeat(seatId: mySeatsStepController.seatsStatus[cell.code]!)
                    : Center(
                        child: Text(
                          cell.type! == "Seat"
                              ? cell.code!
                              : cell.type! == "VerticalCode"
                                  ? cell.value!
                                  : "",
                          style: TextStyle(color: cell.type! == "Seat" ? Color(0xffd1d1d1) : Colors.white),
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

class BlockedSeat extends StatelessWidget {
  const BlockedSeat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Icon(
        Icons.close,
        color: Colors.white,
        size: 15,
      ),
    );
  }
}

class CheckedInSeat extends StatelessWidget {
  const CheckedInSeat({
    Key? key,
    required this.seatId,
  }) : super(key: key);

  final String seatId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          seatId,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
