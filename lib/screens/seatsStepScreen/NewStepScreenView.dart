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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: Center(
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    PlaneHead(
                      height: mySeatsStepController.calculatePlaneBodyHeight() ,
                    ),
                    // PlaneWings(),
                    PlaneTail(
                      height: mySeatsStepController.calculatePlaneBodyHeight() + 85,
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
                  index: i,
                );
              },
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
  final int index;

  const CabinWidget({Key? key, required this.cabin, required this.mySeatsStepController, required this.height, required this.width, required this.index}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      // color: Colors.deepPurple,
      width: width,
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
              width: mySeatsStepController.calculateCabinNameLength(index),
              margin: EdgeInsets.only(left: 5),
              child: Text(
                cabin.cabinTitle,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
            child: Container(
              // color: Colors.blue,
              height: height,
              width: mySeatsStepController.calculateCabinLinesLength(index),
              child: Center(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: cabin.linesCount,
                  itemBuilder: (_, i) {
                    return
                        LineWidget(
                      line: cabin.lines[i],
                      mySeatsStepController: mySeatsStepController,
                      index: 0,
                    );
                  },
                ),
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
  final int index;

  const LineWidget({Key? key, required this.line, required this.mySeatsStepController, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amberAccent,
      width: mySeatsStepController.seatWidth,
      margin: EdgeInsets.symmetric(horizontal: mySeatsStepController.linesMargin),
      child: line.type == "HorizontalCode"
          ? HorizontalCodeLine(
              cells: line.cells,
              width: mySeatsStepController.seatWidth,
              height: mySeatsStepController.seatHeight,
            )
          : BodyLine(cells: line.cells, mySeatsStepController: mySeatsStepController, index: index),
    );
  }
}

class HorizontalCodeLine extends StatelessWidget {
  final List<Cell> cells;
  final double width;
  final double height;

  const HorizontalCodeLine({Key? key, required this.cells, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      // width: 45,
      // height: 300,
      child: Center(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: cells.length,
          itemBuilder: (_, i) {
            return Container(
              margin: EdgeInsets.all(2),
              width: cells[i].type == "Seat" || cells[i].type == "OutEquipmentExit" ? width : width - 15,
              height: cells[i].type == "Seat"
                  ? height
                  : cells[i].type == "OutEquipmentWing" || cells[i].type == "OutEquipmentExit"
                      ? 0
                      : height - 15,
              decoration: BoxDecoration(
                color: Color(0xff5d5d5d),
              ),
              child: Center(
                child: Text(
                  cells[i].type == "Seat" ? cells[i].value! : "",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BodyLine extends StatelessWidget {
  final List<Cell> cells;
  final SeatsStepController mySeatsStepController;
  final int index;

  const BodyLine({Key? key, required this.cells, required this.mySeatsStepController, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      // width: 50,
      // height: mySeatsStepController.calculateCabinHeight(index),
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

class SeatWidget extends StatefulWidget {
  const SeatWidget({
    Key? key,
    required this.mySeatsStepController,
    required this.cell,
  }) : super(key: key);
  final Cell cell;

  final SeatsStepController mySeatsStepController;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    double width = widget.mySeatsStepController.seatWidth;
    double height = widget.mySeatsStepController.seatHeight;
    bool isSeatClickable = false;
    Color color = Color(0xff5d5d5d);
    String seatText = "";
    Color textColor = Colors.white;
    switch (widget.mySeatsStepController.seatViewType(widget.cell.value, widget.cell.type, widget.cell.code)) {
      case 1:
        color = Color(0xff5d5d5d);
        break;
      case 2:
        seatText = widget.cell.code!;
        width = height = (width - 15);

        break;
      case 3:
        color = Colors.black;
        break;
      case 4:
        color = Colors.grey;
        break;
      case 5:
        color = Colors.grey.withOpacity(0.5);
        break;
      case 6:
        color = Colors.white;
        isSeatClickable = true;
        seatText = widget.cell.code!;
        textColor = Color(0xff424242);
        break;
      case 7:
        isSeatClickable = true;
        color = Color(0xffffae2c);
        seatText = widget.mySeatsStepController.seatsStatus[widget.cell.code]!;
        break;
      case 8:

      case 9:
        width = (width - 15);
        height = 0;
        break;
      case 10:
        width = height = 0;
        break;
      case 11:
        width = height = (width - 15);
        seatText = widget.cell.value!;
        break;
      case 12:
        width = height = (width - 15);
        break;
      case 13:
        isSeatClickable = false;
        color = Color(0xff48c0a2);
        seatText = widget.mySeatsStepController.seatsStatus[widget.cell.code]!;
        break;
      case 14:
        isSeatClickable = false;
        // color = Color(0xff48c0a2);
        seatText = "";
        break;
    }

    return GestureDetector(
      onTap: isSeatClickable
          ? () {
              setState(() {
                widget.mySeatsStepController.changeSeatStatus(widget.cell.code!);
              });
            }
          : null,
      child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: (() {
            switch (widget.mySeatsStepController.seatViewType(widget.cell.value, widget.cell.type, widget.cell.code)) {
              case 9:
                return Container();
              // ExitDoor();
              case 3:
                return BlockedSeat();
              case 4:
                return CheckedInSeat(
                  width: widget.mySeatsStepController.seatWidth,
                  height: widget.mySeatsStepController.seatHeight,
                );
              default:
                return Center(
                  child: Text(
                    seatText,
                    style: TextStyle(color: textColor),
                  ),
                );
            }
          }())),
    );
  }
}

class ExitDoor extends StatelessWidget {
  const ExitDoor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.sensor_door_outlined,
      color: Colors.red,
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
      child: Container(
        height: height,
        width: 390,
        child: Image.asset(
          "assets/images/Airplane Head.png",
          fit: BoxFit.fill,
          // height: 350,
        ),
        margin: EdgeInsets.only(left: 20,top: 7),
        // width: 400,
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
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: margin + 50, top :7),
        // width: 2400,
        height: height ,
        child: Image.asset(
          "assets/images/Edited-Tail.png",
          fit: BoxFit.fill,
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
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
