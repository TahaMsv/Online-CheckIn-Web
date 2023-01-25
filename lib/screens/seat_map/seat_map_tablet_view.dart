import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/core/constants/ui.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/seat_map_controller.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/seat_map_state.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/widgets/line_widget.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/widgets/my_custom-scroll_behavior.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/widgets/plane_head.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/widgets/plane_tail.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/widgets/seat_widget.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:online_checkin_web_refactoring/widgets/MyDivider.dart';
import '../../core/classes/cabin.dart';
import '../../core/classes/line.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/MyElevatedButton.dart';
import '../../widgets/title_widget.dart';
import '../steps/steps_view.dart';

class SeatMapViewTablet extends StatelessWidget {
  SeatMapViewTablet({Key? key}) : super(key: key);
  final SeatMapController seatMapController = getIt<SeatMapController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SeatMapState seatMapState = context.watch<SeatMapState>();
    return Scaffold(backgroundColor: theme.primaryColor, body: const TravellersList());
  }
}

class TravellersList extends StatelessWidget {
  const TravellersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StepsState stepsState = context.watch<StepsState>();
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.rectangle),
      height: height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(title: "Travellers", width: width * 0.5, height: 100, fontSize: 40),
              SizedBox(
                width: width * 0.3,
                child: Row(
                  children: [
                    const MyDivider(width: 2, height: 60, color: MyColors.white1),
                    TitleWidget(title: "Seat", width: width * 0.2, height: 100, fontSize: 40),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: width,
              child: ListView.builder(
                itemCount: stepsState.travelers.length,
                itemBuilder: (ctx, index) {
                  return TravellerItem(step: stepsState.step, index: index);
                },
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
  }) : super(key: key);
  final int step;
  final int index;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final SeatMapController seatMapController = getIt<SeatMapController>();
    StepsState stepsState = context.watch<StepsState>();
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: MyColors.lightGrey), color: stepsState.whoseTurnToSelect == index ? MyColors.brightYellow.withOpacity(0.4) : MyColors.white),
      height: 150,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                  child: Text(stepsState.travelers[index].getFullNameWithGender(), style: MyTextTheme.darkGreyW40030),
                ),
                step == 6
                    ? SizedBox(
                        width: width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 2, height: 150, color: MyColors.white1),
                            Expanded(
                              child: !isTravellerSelected
                                  ? Center(
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: IconButton(
                                          onPressed: () {
                                            seatMapController.setTravelerToSelectIndexTablet(index);
                                            // Get.to(Plane(mySeatsStepController: mySeatsStepController)); //todo
                                          },
                                          icon: const Icon(Icons.add_circle_outline_rounded, size: 60, color: MyColors.brightYellow),
                                          color: stepsState.whichOneToEdit == index ? Colors.green : Colors.blue,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        TitleWidget(
                                            title: stepsState.travelers[index].seatId, width: 100, height: 80, fontSize: 35, textColor: isTravellerSelected ? MyColors.oceanGreen : MyColors.darkGrey),
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: IconButton(
                                            onPressed: () {
                                              seatMapController.setTravelerToSelectIndexTablet(index);
                                              // Get.to(Plane(mySeatsStepController: mySeatsStepController)); //todo
                                            },
                                            icon: const Icon(Icons.edit, size: 45),
                                            color: stepsState.whichOneToEdit == index ? MyColors.green : MyColors.myBlue,
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
  }) : super(key: key);
  final int step;
  final int index;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    StepsState stepsState = context.watch<StepsState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grey),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        color: isTravellerSelected ? MyColors.white1 : MyColors.brightYellow.withOpacity(0.4),
      ),
      height: 200,
      width: width * 0.8,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                  child: Text(stepsState.travelers[index].getFullNameWithGender(), style: MyTextTheme.darkGreyW40030),
                ),
                step == 6
                    ? SizedBox(
                        width: width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TitleWidget(
                                    title: stepsState.travelers[index].seatId,
                                    width: 100,
                                    height: 80,
                                    fontSize: 35,
                                    textColor: isTravellerSelected ? MyColors.oceanGreen : MyColors.darkGrey,
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

class Plane extends StatelessWidget {
  const Plane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = context.watch<SeatMapState>();
    StepsState stepsState = context.watch<StepsState>();
    double planeBodyHeight = seatMapController.calculatePlaneBodyHeight(mode: "tablet");
    double planeBodyLength = seatMapController.calculatePlaneBodyLength(mode: "tablet");
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Center(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        PlaneHead(height: planeBodyHeight, isTabletMode: true),
                        PlaneTail(height: planeBodyHeight + 200, margin: planeBodyLength, isTabletMode: true),
                        const PlaneBody(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: 250,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 200,
                    width: 90,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(20)), color: MyColors.black),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 65,
                            width: 65,
                            child: IconButton(
                                onPressed: () {
                                  seatMapController.decreaseTravelerToSelectIndexTablet();
                                },
                                icon: const Center(
                                  child: Icon(Icons.keyboard_arrow_up, size: 50),
                                ),
                                color: MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 67,
                          child: Center(
                            child: Text("${seatMapState.travelerToSelectIndexTablet + 1}/${stepsState.travelers.length}", style: MyTextTheme.black25W700),
                          ),
                          // color: Colors.black,
                        ),
                        SizedBox(
                          height: 65,
                          width: 65,
                          child: IconButton(
                              onPressed: () {
                                seatMapController.increaseTravelerToSelectIndexTablet();
                              },
                              icon: const Icon(Icons.keyboard_arrow_down, size: 50),
                              color: MyColors.black),
                        )
                      ],
                    ),
                  ),
                  SelectSeatFor(step: 6, index: seatMapState.travelerToSelectIndexTablet),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: 130,
              color: MyColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyElevatedButton(
                    height: height * 0.06,
                    width: 250,
                    buttonText: "Close",
                    fontSize: 25,
                    fgColor: MyColors.black,
                    bgColor: MyColors.white,
                    function: () {
                      // Get.back();  //todo
                    },
                    isDisable: false,
                  ),
                  MyElevatedButton(
                    height: height * 0.06,
                    width: 250,
                    buttonText: "Finish",
                    fontSize: 30,
                    fgColor: stepsState.isNextButtonEnable ? MyColors.white : MyColors.black,
                    bgColor: stepsState.isNextButtonEnable ? MyColors.green : MyColors.grey,
                    // borderColor: Colors.grey,
                    function: () {
                      // Get.back();  //todo
                    },
                    isDisable: !stepsState.isNextButtonEnable,
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

class PlaneBody extends StatelessWidget {
  const PlaneBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = context.watch<SeatMapState>();
    return Center(
      child: SizedBox(
        width: seatMapController.calculatePlaneBodyHeight(mode: "tablet"),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: seatMapController.calculatePlaneBodyLength(mode: "tablet"),
                margin: const EdgeInsets.only(top: 395),
                width: seatMapController.calculatePlaneBodyHeight(mode: "tablet"),
                decoration: const BoxDecoration(color: MyColors.grey, borderRadius: BorderRadius.all(Radius.circular(35))),
              ),
            ),
            Container(
              height: seatMapController.calculatePlaneBodyLength(mode: "tablet"),
              margin: const EdgeInsets.only(top: 395),
              width: seatMapController.calculatePlaneBodyHeight(mode: "tablet"),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: seatMapState.cabins.length,
                itemBuilder: (_, i) {
                  return CabinWidget(
                    width: seatMapController.calculatePlaneBodyHeight(mode: "tablet") + 85,
                    cabin: seatMapState.cabins[i],
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
  const CabinWidget({
    Key? key,
    required this.cabin,
    required this.width,
    required this.index,
  }) : super(key: key);

  final Cabin cabin;
  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = context.watch<SeatMapState>();
    StepsState stepsState = context.watch<StepsState>();
    double height = seatMapController.calculateCabinLength(index);
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyColors.darkGrey,
              ),
              child: Text(cabin.cabinTitle, style: MyTextTheme.white25),
            ),
            SizedBox(
              // color: Colors.blue,
              height: seatMapController.calculateCabinLinesLength(index, mode: "tablet"),
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
                  double cabinRatio = (cabinTitle == "First Class"
                      ? seatMapState.firstClassCabinsRatio
                      : cabinTitle == "Business"
                          ? seatMapState.businessCabinsRatio
                          : 1.0);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RotatedBox(
                        quarterTurns: -1,
                        child: ExitDoor(
                          width: seatMapState.seatWidth + 10,
                          height: 30,
                          isEnable: upDoorEnable,
                          isTabletMode: true,
                        ),
                      ),
                      LineWidget(
                        line: cabin.lines[i],
                        height: cabinRatio * seatMapState.seatWidth,
                        width: seatMapController.calculateCabinHeight(index, mode: "tablet"),
                        cabinRatio: cabinRatio,
                        isTabletMode: true,
                      ),
                      RotatedBox(
                        quarterTurns: -1,
                        child: ExitDoor(
                          width: seatMapState.seatWidth + 10,
                          height: 30,
                          isEnable: downDoorEnable,
                          isTabletMode: true,
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
