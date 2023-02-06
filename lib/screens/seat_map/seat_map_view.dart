import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/core/constants/assets.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/seat_map/seat_map_controller.dart';
import 'package:online_check_in/screens/seat_map/widgets/line_widget.dart';
import 'package:online_check_in/screens/seat_map/widgets/my_custom-scroll_behavior.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane_head.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane_tail.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane_wing.dart';
import 'package:online_check_in/screens/seat_map/widgets/seat_widget.dart';
import '../../core/classes/seat_map.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class SeatMapView extends StatelessWidget {
  SeatMapView({Key? key}) : super(key: key);
  final SeatMapController seatMapController = getIt<SeatMapController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SeatMapState seatMapState = context.watch<SeatMapState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double planeBodyHeight = seatMapController.calculatePlaneBodyHeight();
    double planeBodyLength = seatMapController.calculatePlaneBodyLength();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SizedBox(
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
                    PlaneHead(height: planeBodyHeight, isTabletMode: false),
                    // PlaneWings(planeBodyLength: planeBodyLength, isTabletMode: false),
                    PlaneTail(height: planeBodyHeight + 85, margin: planeBodyLength, isTabletMode: false),
                    const PlaneBody(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = context.watch<SeatMapState>();
    String languageCode = "en";
    return Center(
      child: SizedBox(
        height: seatMapController.calculatePlaneBodyHeight() + 20,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: seatMapController.calculatePlaneBodyHeight(),
                margin: languageCode == "en" ? const EdgeInsets.only(left: 395) : const EdgeInsets.only(right: 395),
                width: seatMapController.calculatePlaneBodyLength(),
                decoration: const BoxDecoration(color: MyColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Container(
              height: seatMapController.calculatePlaneBodyHeight() + 20,
              margin: languageCode == "en" ? const EdgeInsets.only(left: 395) : const EdgeInsets.only(right: 395),
              width: seatMapController.calculatePlaneBodyLength(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: seatMapState.cabins.length,
                itemBuilder: (_, i) {
                  return CabinWidget(width: seatMapController.calculateCabinLength(i), cabin: seatMapState.cabins[i], index: i);
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

  final double width;
  final int index;
  final Cabin cabin;

  @override
  Widget build(BuildContext context) {
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = context.watch<SeatMapState>();
    double height = (seatMapController.calculatePlaneBodyHeight()) + 85;
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: MyColors.darkGrey),
                child: Text(cabin.cabinTitle.tr, style: MyTextTheme.white20),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: height,
                width: seatMapController.calculateCabinLinesLength(index),
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
                        ? seatMapState.airCraftBodySize.firstClassCabinsRatio
                        : cabinTitle == "Business".tr
                            ? seatMapState.airCraftBodySize.businessCabinsRatio
                            : 1.0);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ExitDoor(
                          width: seatMapState.airCraftBodySize.seatWidth,
                          height: 20,
                          isEnable: upDoorEnable,
                          isTabletMode: false,
                        ),
                        LineWidget(
                          line: cabin.lines[i],
                          width: cabinRatio * seatMapState.airCraftBodySize.seatWidth,
                          height: seatMapController.calculateCabinHeight(index),
                          cabinRatio: cabinRatio,
                          isTabletMode: false,
                        ),
                        ExitDoor(
                          width: seatMapState.airCraftBodySize.seatWidth,
                          height: 20,
                          isEnable: downDoorEnable,
                          isTabletMode: false,
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


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}