import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../global/Classes.dart';
import '../../screens/seatsStepScreen/SeatsStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

import '../../widgets/MyElevatedButton.dart';
import '../stepsScreen/StepsScreenController.dart';
import '../stepsScreen/StepsScreenView.dart';

class SeatsStepTabletView extends StatelessWidget {
  final SeatsStepController mySeatsStepController;

  SeatsStepTabletView(MainModel model) : mySeatsStepController = Get.put(SeatsStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;
    MainModel model = context.watch<MainModel>();
    final myStepsScreenController = Get.put(StepsScreenController(model));
    return Scaffold(
        backgroundColor: Colors.white,
        body: TravellersList(
          width: Get.width,
          height: Get.height,
          myStepsScreenController: myStepsScreenController,
          mySeatsStepController: mySeatsStepController,
          step: 6,
        ));
  }
}

class TravellersList extends StatelessWidget {
  const TravellersList({
    Key? key,
    required this.height,
    required this.width,
    required this.step,
    required this.myStepsScreenController,
    required this.mySeatsStepController,
  }) : super(key: key);

  final double height;
  final double width;
  final int step;
  final StepsScreenController myStepsScreenController;
  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black.withOpacity(0.1)),
        shape: BoxShape.rectangle,
        // color: Colors.blue,
      ),
      height: height,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(
                title: "Travellers".tr,
                width: width * 0.5,
                height: 100,
                fontSize: 40,
              ),
              Container(
                width: width * 0.3,
                child: Row(
                  children: [
                    Container(
                      width: 2,
                      height: 60,
                      color: Color(0xffededed),
                    ),
                    TitleWidget(
                      title: "Seat".tr,
                      width: width * 0.2,
                      height: 100,
                      fontSize: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => Expanded(
              child: Container(
                width: width,
                // height: height ,
                // color: Colors.yellow,
                // padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: myStepsScreenController.travellers.length,
                  itemBuilder: (ctx, index) {
                    return TravellerItem(
                      step: step,
                      index: index,
                      myStepsScreenController: myStepsScreenController,
                      mySeatsStepController: mySeatsStepController,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      // color: Colors.red,
    );
  }
}

class TravellerItem extends StatelessWidget {
  const TravellerItem({
    Key? key,
    required this.step,
    required this.index,
    required this.myStepsScreenController,
    required this.mySeatsStepController,
  }) : super(key: key);
  final int step;
  final int index;
  final StepsScreenController myStepsScreenController;
  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    bool isTravellerSelected = myStepsScreenController.travellers[index].seatId == "--" ? false : true;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: myStepsScreenController.whoseTurnToSelect.value == index ? const Color(0xffffae2c).withOpacity(0.4) : Colors.white,
      ),
      height: 150,
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                  child: Text(
                    myStepsScreenController.travellers[index].getFullNameWithGender(),
                    style: TextStyle(
                      color: Color(0xff424242),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                step == 6
                    ? Container(
                        width: Get.width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 2,
                              height: 150,
                              color: Color(0xffededed),
                            ),
                            Expanded(
                              child: !isTravellerSelected
                                  ? Center(
                                      child: Container(
                                        // color: Colors.red,
                                        width: 80,
                                        height: 80,
                                        child: IconButton(
                                          onPressed: () {
                                            // myStepsScreenController.setWhichOneToEdit(index);
                                            mySeatsStepController.setTravelerToSelectIndexTablet(index);
                                            Get.to(Plane(mySeatsStepController: mySeatsStepController));
                                          },
                                          icon: Icon(Icons.add_circle_outline_rounded, size: 60, color: const Color(0xffffae2c)),
                                          color: myStepsScreenController.whichOneToEdit == index ? Colors.green : Colors.blue,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        TitleWidget(
                                          title: myStepsScreenController.travellers[index].seatId,
                                          width: 100,
                                          height: 80,
                                          fontSize: 35,
                                          textColor: isTravellerSelected ? Color(0xff48c0a2) : Color(0xff424242),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          width: 80,
                                          height: 80,
                                          child: IconButton(
                                            onPressed: () {
                                              // myStepsScreenController.setWhichOneToEdit(index);
                                              mySeatsStepController.setTravelerToSelectIndexTablet(index);
                                              Get.to(Plane(mySeatsStepController: mySeatsStepController));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 45,
                                            ),
                                            color: myStepsScreenController.whichOneToEdit == index ? Colors.green : Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectSeatFor extends StatelessWidget {
  const SelectSeatFor({
    Key? key,
    required this.step,
    required this.index,
    required this.myStepsScreenController,
    required this.mySeatsStepController,
  }) : super(key: key);
  final int step;
  final int index;
  final StepsScreenController myStepsScreenController;
  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    bool isTravellerSelected = myStepsScreenController.travellers[index].seatId == "--" ? false : true;
    return Obx(() => Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: isTravellerSelected ? Color(0xffd3f8ea) : const Color(0xffffae2c).withOpacity(0.4),
          ),
          height: 200,
          width: Get.width * 0.8,
          // margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: languageCode == 'en' ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                      child: Text(
                        myStepsScreenController.travellers[index].getFullNameWithGender(),
                        style: TextStyle(
                          color: Color(0xff424242),
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    step == 6
                        ? Container(
                            width: Get.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(
                                //   width: 2,
                                //   height: 150,
                                //   color: Color(0xffededed),
                                // ),
                                Expanded(
                                  child:
                                      // !isTravellerSelected
                                      //     ? Center(
                                      //   child: Container(
                                      //     // color: Colors.red,
                                      //     width: 80,
                                      //     height: 80,
                                      //     child: IconButton(
                                      //       onPressed: () {
                                      //         myStepsScreenController.setWhichOneToEdit(index);
                                      //         Get.to(Plane(mySeatsStepController: mySeatsStepController));
                                      //       },
                                      //       icon: Icon(Icons.add_circle_outline_rounded, size: 60, color: const Color(0xffffae2c)),
                                      //       color: myStepsScreenController.whichOneToEdit == index ? Colors.green : Colors.blue,
                                      //     ),
                                      //   ),
                                      // )
                                      //     :
                                      Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TitleWidget(
                                        title: myStepsScreenController.travellers[index].seatId,
                                        width: 100,
                                        height: 80,
                                        fontSize: 35,
                                        textColor: isTravellerSelected ? Color(0xff48c0a2) : Color(0xff424242),
                                      ),
                                      // Container(
                                      //   // color: Colors.red,
                                      //   width: 80,
                                      //   height: 80,
                                      //   child: IconButton(
                                      //     onPressed: () {
                                      //       myStepsScreenController.setWhichOneToEdit(index);
                                      //       Get.to(Plane(mySeatsStepController: mySeatsStepController));
                                      //     },
                                      //     icon: Icon(
                                      //       Icons.edit,
                                      //       size: 45,
                                      //     ),
                                      //     color: myStepsScreenController.whichOneToEdit == index ? Colors.green : Colors.blue,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Plane extends StatelessWidget {
  const Plane({
    Key? key,
    required this.mySeatsStepController,
  }) : super(key: key);

  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double planeBodyHeight = mySeatsStepController.calculatePlaneBodyHeight(mode: "tablet");
    double planeBodyLength = mySeatsStepController.calculatePlaneBodyLength(mode: "tablet");

    MainModel model = context.watch<MainModel>();
    StepsScreenController myStepsScreenController = Get.put(StepsScreenController(model));
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            // color: Colors.red,
            child: Center(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: Container(
                  // color: Colors.blue,
                  child: ListView(
                    // scrollDirection: Axis.horizontal,
                    children: [
                      Stack(
                        children: [
                          PlaneHead(
                            height: planeBodyHeight,
                          ),
                          // PlaneWings(
                          //   planeBodyLength: planeBodyLength,
                          // ),
                          PlaneTail(
                            height: planeBodyHeight + 200,
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
          ),
          Container(
            width: Get.width,
            height: 250,
            // color: Colors.transparent.withOpacity(0.5),
            child: Obx(
              () => Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      height: 200,
                      width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.black26,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 65,
                              width: 65,
                              // color: Colors.yellow,
                              child: IconButton(
                                  onPressed: () {
                                    mySeatsStepController.decreaseTravelerToSelectIndexTablet();
                                  },
                                  icon: Center(
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 50,
                                    ),
                                  ),
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 67,
                            // width: ,
                            // color: Colors.green,
                            child: Center(
                              child: Text(
                                (mySeatsStepController.travelerToSelectIndexTablet.value + 1).toString() + "/" + myStepsScreenController.travellers.length.toString(),
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                              ),
                            ),
                            // color: Colors.black,
                          ),
                          Container(
                            height: 65,
                            width: 65,
                            // color: Colors.yellow,
                            child: IconButton(
                                onPressed: () {
                                  mySeatsStepController.increaseTravelerToSelectIndexTablet();
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 50,
                                ),
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => SelectSeatFor(
                        step: 6,
                        index: mySeatsStepController.travelerToSelectIndexTablet.value,
                        myStepsScreenController: myStepsScreenController,
                        mySeatsStepController: mySeatsStepController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: Get.width,
              height: 130,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyElevatedButton(
                      height: height * 0.06,
                      width: 250,
                      buttonText: "Close",
                      fontSize: 25,
                      fgColor: Colors.black,
                      bgColor: Colors.white,
                      // borderColor: Colors.white,
                      function: () {
                        Get.back();
                      },
                      isDisable: false,
                    ),
                    MyElevatedButton(
                      height: height * 0.06,
                      width: 250,
                      buttonText: "Finish",
                      fontSize: 30,
                      fgColor: myStepsScreenController.isNextButtonEnable ? Colors.white : Colors.black,
                      bgColor: myStepsScreenController.isNextButtonEnable ? Colors.green : Colors.grey,
                      // borderColor: Colors.grey,
                      function: () {
                        Get.back();
                      },
                      isDisable: !myStepsScreenController.isNextButtonEnable,
                    ),
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

class PlaneBody extends StatelessWidget {
  const PlaneBody({
    Key? key,
    required this.mySeatsStepController,
  }) : super(key: key);
  final SeatsStepController mySeatsStepController;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    return Center(
      child: Container(
        width: mySeatsStepController.calculatePlaneBodyHeight(mode: "tablet"),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: mySeatsStepController.calculatePlaneBodyLength(mode: "tablet"),
                margin: EdgeInsets.only(top: 395),
                width: mySeatsStepController.calculatePlaneBodyHeight(mode: "tablet"),
                decoration: BoxDecoration(
                  color: Color(0xff5d5d5d),
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                ),
              ),
            ),
            Container(
              height: mySeatsStepController.calculatePlaneBodyLength(mode: "tablet"),
              margin: EdgeInsets.only(top: 395),
              width: mySeatsStepController.calculatePlaneBodyHeight(mode: "tablet"),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: mySeatsStepController.cabins.length,
                itemBuilder: (_, i) {
                  return CabinWidget(
                    width: mySeatsStepController.calculatePlaneBodyHeight(mode: "tablet") + 85,
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
    double height = mySeatsStepController.calculateCabinLength(index);
    return Center(
      child: Container(
        // color: Colors.deepPurple,
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              child: Text(
                cabin.cabinTitle.tr,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xff424242),
              ),
            ),
            Container(
              // color: Colors.blue,
              height: mySeatsStepController.calculateCabinLinesLength(index, mode: "tablet"),
              width: width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RotatedBox(
                        quarterTurns: -1,
                        child: ExitDoor(
                          width: mySeatsStepController.seatWidth + 10,
                          height: 30,
                          isEnable: upDoorEnable,
                        ),
                      ),
                      // Transform.rotate(
                      //   angle: math.pi / 2,
                      //   child:
                      // ),
                      LineWidget(
                        line: cabin.lines[i],
                        mySeatsStepController: mySeatsStepController,
                        width: mySeatsStepController.calculateCabinHeight(index, mode: "tablet"),
                        cabinRatio: cabinRatio,
                      ),
                      RotatedBox(
                        quarterTurns: -1,
                        child: ExitDoor(
                          width: mySeatsStepController.seatWidth + 10,
                          height: 30,
                          isEnable: downDoorEnable,
                        ),
                      ),
                    ],
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

class LineWidget extends StatelessWidget {
  final Line line;
  final SeatsStepController mySeatsStepController;
  final double width;
  final double cabinRatio;

  const LineWidget({
    Key? key,
    required this.line,
    required this.mySeatsStepController,
    required this.width,
    required this.cabinRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.green,
      height: cabinRatio * mySeatsStepController.seatWidth,
      width: width,
      margin: EdgeInsets.symmetric(vertical: mySeatsStepController.linesMargin),
      child: Center(
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
      // color: Colors.yellow,

      child: Center(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
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
    double width = cabinRatio * mySeatsStepController.getSeatHeight(seatType);
    double height = cabinRatio * mySeatsStepController.getSeatWidth(seatType);
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
          style: TextStyle(color: Colors.white, fontSize: 25),
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
        scrollDirection: Axis.horizontal,
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
    double width = widget.cabinRatio * widget.mySeatsStepController.getSeatHeight(seatType);
    double height = widget.cabinRatio * widget.mySeatsStepController.getSeatWidth(seatType);
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
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: color,
            border: widget.inExitDoorLIne && hasShadow ? Border.all(color: Colors.red, width: 2) : null,
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
                    style: TextStyle(color: textColor, fontSize: 19, fontWeight: FontWeight.w600),
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
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
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
    String languageCode = Get.locale!.languageCode;
    return Center(
      child: Container(
        // color: Colors.red,
        height: height,
        width: height,
        child: Image.asset(
          "assets/images/Airplane Head-tablet.png",
          fit: BoxFit.fill,
          // height: 350,
        ),

        // margin: languageCode == "en" ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20),
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
    String languageCode = Get.locale!.languageCode;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: margin + 230),
        width: height - 15,
        height: height,
        child: Image.asset(
          "assets/images/Edited-Tail-tablet.png",
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
        size: 20,
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
    Key? key,
    required this.planeBodyLength,
  }) : super(key: key);

  final double planeBodyLength;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    return Container(
      margin: languageCode == "en" ? EdgeInsets.only(left: 400 + planeBodyLength / 2) : EdgeInsets.only(right: 400 + planeBodyLength / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(
                "assets/images/Up Wing.png",
                fit: BoxFit.fill,
                // height: 350,
              ),
            ),
            width: 400,
          ),
          Container(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(
                "assets/images/Down Wing.png",
                fit: BoxFit.fill,
                // height: 350,
              ),
            ),
            width: 400,
          ),
        ],
      ),
    );
  }
}
