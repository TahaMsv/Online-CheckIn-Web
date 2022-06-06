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
    double planeBodyHeight =mySeatsStepController.calculatePlaneBodyHeight();
    double planeBodyLength = mySeatsStepController.calculatePlaneBodyLength();
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
                      height:planeBodyHeight ,
                    ),
                    PlaneWings( planeBodyLength: planeBodyLength,),
                    PlaneTail(
                      height:planeBodyHeight + 85,
                      margin: planeBodyLength,
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
        height: mySeatsStepController.calculatePlaneBodyHeight() + 20,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: mySeatsStepController.calculatePlaneBodyHeight(),
                margin: EdgeInsets.only(left: 395),
                width: mySeatsStepController.calculatePlaneBodyLength(),
                decoration: BoxDecoration(
                  color: Color(0xff5d5d5d),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            Container(
              height: mySeatsStepController.calculatePlaneBodyHeight() + 20,
              margin: EdgeInsets.only(left: 395),
              width: mySeatsStepController.calculatePlaneBodyLength(),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: mySeatsStepController.cabins.length,
                itemBuilder: (_, i) {
                  return CabinWidget(
                    width: mySeatsStepController.calculateCabinLength(i),
                    cabin: mySeatsStepController.cabins[i],
                    mySeatsStepController: mySeatsStepController,
                    index: i,
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

  // final double height;
  final double width;
  final int index;

  const CabinWidget({
    Key? key,
    required this.cabin,
    required this.mySeatsStepController,
    required this.width,
    required this.index,
  }) : super(key: key);

  Widget build(BuildContext context) {
    double height = (mySeatsStepController.calculatePlaneBodyHeight()) + 85;
    return Center(
      child: Container(
        // color: Colors.deepPurple,
        width: width,
        height: height,
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Text(
                  cabin.cabinTitle,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xff424242),
                ),
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.blue,
                height: height,
                width: mySeatsStepController.calculateCabinLinesLength(index),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: cabin.linesCount,
                  itemBuilder: (_, i) {
                    int upExitDoors = cabin.lines[i].cells.indexWhere((element) => (element.type == "OutEquipmentExit" && element.value != null));
                    int downExitDoors = cabin.lines[i].cells.lastIndexWhere((element) => (element.type == "OutEquipmentExit" && element.value != null));
                    bool upDoorEnable = (i != 0 && upExitDoors != -1);
                    bool downDoorEnable = (i != 0 && downExitDoors != -1 && downExitDoors != upExitDoors);
                    String cabinTitle = cabin.cabinTitle;
                    double cabinRatio = (cabinTitle == "First Class".tr
                        ? mySeatsStepController.firstClassCabinsRatio
                        : cabinTitle == "Business".tr
                        ? mySeatsStepController.businessCabinsRatio
                        : 1.0);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ExitDoor(
                          width: mySeatsStepController.seatWidth,
                          height: 20,
                          isEnable: upDoorEnable,
                        ),
                        LineWidget(
                          line: cabin.lines[i],
                          mySeatsStepController: mySeatsStepController,
                          height: mySeatsStepController.calculateCabinHeight(index),
                          cabinRatio: cabinRatio,
                        ),
                        ExitDoor(
                          width: mySeatsStepController.seatWidth,
                          height: 20,
                          isEnable: downDoorEnable,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  final Line line;
  final SeatsStepController mySeatsStepController;
  final double height;
  final double cabinRatio;

  const LineWidget({
    Key? key,
    required this.line,
    required this.mySeatsStepController,
    required this.height,
    required this.cabinRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      height: height,
      width: cabinRatio * mySeatsStepController.seatWidth,
      margin: EdgeInsets.symmetric(horizontal: mySeatsStepController.linesMargin),
      child: line.type == "HorizontalCode"
          ? HorizontalCodeLine(
              mySeatsStepController: mySeatsStepController,
              cells: line.cells,
              cabinRatio: cabinRatio,
            )
          : BodyLine(
              cells: line.cells,
              mySeatsStepController: mySeatsStepController,
              cabinRatio: cabinRatio,
            ),
    );
  }
}

class HorizontalCodeLine extends StatelessWidget {
  final List<Cell> cells;
  final double cabinRatio;
  final SeatsStepController mySeatsStepController;

  const HorizontalCodeLine({
    Key? key,
    required this.cells,
    required this.cabinRatio,
    required this.mySeatsStepController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: cells.length,
          itemBuilder: (_, i) {
            return CodeSeat(
              mySeatsStepController: mySeatsStepController,
              cell: cells[i],
              cabinRatio: cabinRatio,
            );
          },
        ),
      ),
    );
  }
}

class CodeSeat extends StatelessWidget {
  const CodeSeat({
    Key? key,
    required this.cell,
    required this.cabinRatio,
    required this.mySeatsStepController,
  }) : super(key: key);
  final SeatsStepController mySeatsStepController;
  final Cell cell;
  final double cabinRatio;

  @override
  Widget build(BuildContext context) {
    int seatType = mySeatsStepController.seatViewType(cell.value, cell.type, cell.code);
    double width = cabinRatio * mySeatsStepController.getSeatWidth(seatType);
    double height = cabinRatio * mySeatsStepController.getSeatHeight(seatType);
    return Container(
      margin: EdgeInsets.all(2),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xff5d5d5d),
      ),
      child: Center(
        child: Text(
          cell.type == "Seat" ? cell.value! : "",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class BodyLine extends StatelessWidget {
  final List<Cell> cells;
  final SeatsStepController mySeatsStepController;
  final double cabinRatio;

  const BodyLine({
    Key? key,
    required this.cells,
    required this.mySeatsStepController,
    required this.cabinRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: cells.length,
        itemBuilder: (_, i) {
          int inExitDoorLine = cells.indexWhere((element) => (element.type == "OutEquipmentExit" && element.value != null));
          return SeatWidget(
            mySeatsStepController: mySeatsStepController,
            cell: cells[i],
            inExitDoorLIne: (inExitDoorLine != -1),
            cabinRatio: cabinRatio,
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
    required this.inExitDoorLIne,
    required this.cabinRatio,
  }) : super(key: key);
  final Cell cell;
  final bool inExitDoorLIne;
  final SeatsStepController mySeatsStepController;
  final double cabinRatio;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    int seatType = widget.mySeatsStepController.seatViewType(widget.cell.value, widget.cell.type, widget.cell.code);
    double width = widget.cabinRatio * widget.mySeatsStepController.getSeatWidth(seatType);
    double height = widget.cabinRatio * widget.mySeatsStepController.getSeatHeight(seatType);
    bool isSeatClickable = false;
    bool hasShadow = false;
    Color color = Color(0xff5d5d5d);
    String seatText = "";
    Color textColor = Colors.white;
    switch (seatType) {
      case 1:
        color = Color(0xff5d5d5d);
        break;
      case 2:
        seatText = widget.cell.code!;
        break;
      case 3:
        color = Colors.black;
        break;
      case 4:
        color = Colors.grey;
        hasShadow = true;
        break;
      case 5:
        color = Colors.grey.withOpacity(0.5);
        hasShadow = true;
        break;
      case 6:
        color = Colors.white;
        isSeatClickable = true;
        seatText = widget.cell.code!;
        textColor = Color(0xff424242);
        hasShadow = true;
        break;
      case 7:
        isSeatClickable = true;
        color = Color(0xffffae2c);
        seatText = widget.mySeatsStepController.seatsStatus[widget.cell.code]!;
        hasShadow = true;
        break;
      case 11:
        seatText = widget.cell.value!;
        break;
      case 13:
        isSeatClickable = false;
        color = Color(0xff48c0a2);
        hasShadow = true;
        seatText = widget.mySeatsStepController.seatsStatus[widget.cell.code]!;
        break;
      case 14:
        isSeatClickable = false;
        seatText = "";
        break;
      case 15:
        isSeatClickable = false;
        seatText = "";
        hasShadow = true;
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
              border:widget.inExitDoorLIne && hasShadow? Border.all(
                color: Colors.red,
                width: 2
              ) : null,
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
                  width: widget.cabinRatio * widget.mySeatsStepController.seatWidth,
                  height: widget.cabinRatio * widget.mySeatsStepController.seatHeight,
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
    required this.width,
    required this.height,
    required this.isEnable,
  }) : super(key: key);
  final double width;
  final double height;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return isEnable
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                "Exit".tr,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        : Container();
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
        margin: EdgeInsets.only(left: 20),
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
        margin: EdgeInsets.only(left: margin + 50),
        // width: 2400,
        height: height,
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

class PlaneWings extends StatelessWidget {
  const PlaneWings({
    Key? key, required this.planeBodyLength,
  }) : super(key: key);

  final double planeBodyLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:400 + planeBodyLength/2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.asset(
              "assets/images/Up Wing.png",
              fit: BoxFit.fill,
              // height: 350,
            ),
            width: 400,
          ),
          Container(
            child: Image.asset(
              "assets/images/Down Wing.png",
              fit: BoxFit.fill,
              // height: 350,
            ),
            width: 400,
          ),
        ],
      ),
    );
  }
}
