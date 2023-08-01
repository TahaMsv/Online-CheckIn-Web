import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane_head.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane_tail.dart';
import 'package:online_check_in/screens/seat_map/widgets/seat_widget.dart';
import 'package:online_check_in/screens/seat_map/widgets/travelers_list.dart';
import 'package:provider/provider.dart';

import '../../../core/classes/seat_map.dart';
import '../../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import '../../../core/platform/device_info.dart';
import '../../../core/utils/multi_languages.dart';
import '../../steps/steps_state.dart';
import '../seat_map_controller.dart';
import '../seat_map_state.dart';
import 'line_widget.dart';

class Plane extends ConsumerStatefulWidget {
  const Plane({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Plane> createState() => _PlaneState();
}

class _PlaneState extends ConsumerState<Plane> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = ref.watch(seatMapProvider);
    StepsState stepsState = ref.watch(stepsProvider);
    DeviceType deviceType = DeviceInfo.deviceType(context);
    RunningMode runningMode = deviceType.isPhone ? RunningMode.phone : RunningMode.tablet;
    double planeBodyHeight = seatMapController.calculatePlaneBodyHeight(mode: runningMode);
    double planeBodyLength = seatMapController.calculatePlaneBodyLength(mode: runningMode);

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
                        PlaneHead(height: planeBodyHeight),
                        PlaneTail(height: planeBodyHeight + (deviceType.isPhone ? 125 : 200), margin: planeBodyLength),
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
            height: deviceType.isTablet ? 250 : 130,
            child: Container(
              margin: EdgeInsets.only(top: deviceType.isTablet ? 20 : 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: deviceType.isTablet ? 20 : 5),
                    height: deviceType.isTablet ? 200 : 130,
                    width: deviceType.isTablet ? 90 : 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            height: deviceType.isTablet ? 65 : 40,
                            width: deviceType.isTablet ? 65 : 40,
                            child: IconButton(
                                onPressed: () {
                                  seatMapController.decreaseTravelerToSelectIndexTablet();
                                },
                                icon: Center(
                                  child: Icon(Icons.keyboard_arrow_up, size: deviceType.isTablet ? 50 : 25),
                                ),
                                color: MyColors.black),
                          ),
                        ),
                        SizedBox(
                          height: deviceType.isTablet ? 67 : 40,
                          child: Center(
                            child:
                                Text("${seatMapState.travelerToSelectIndexTablet + 1}/${stepsState.travelers.length}", style: deviceType.isTablet ? MyTextTheme.black25W700 : MyTextTheme.black17W700),
                          ),
                          // color: Colors.black,
                        ),
                        SizedBox(
                          height: deviceType.isTablet ? 65 : 40,
                          width: deviceType.isTablet ? 65 : 40,
                          child: IconButton(
                              onPressed: () {
                                seatMapController.increaseTravelerToSelectIndexTablet();
                              },
                              icon: Icon(Icons.keyboard_arrow_down, size: deviceType.isTablet ? 50 : 25),
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
        ],
      ),
    );
  }
}

class PlaneBody extends ConsumerWidget {
  const PlaneBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String languageCode = MultiLanguages.of(context)!.locale.languageCode;  //todo
    String languageCode = 'en';
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = ref.watch(seatMapProvider);
    DeviceType deviceType = DeviceInfo.deviceType(context);
    RunningMode runningMode = deviceType.isPhone ? RunningMode.phone : RunningMode.tablet;
    return Center(
      child: SizedBox(
        width: seatMapController.calculatePlaneBodyHeight(mode: runningMode),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: seatMapController.calculatePlaneBodyLength(mode: runningMode),
                margin: EdgeInsets.only(top: deviceType.isPhone ? 300 : 395),
                width: seatMapController.calculatePlaneBodyHeight(mode: runningMode),
                decoration: const BoxDecoration(color: MyColors.grey, borderRadius: BorderRadius.all(Radius.circular(35))),
              ),
            ),
            Container(
              height: seatMapController.calculatePlaneBodyLength(mode: runningMode),
              margin: EdgeInsets.only(top: deviceType.isPhone ? 300 : 395),
              width: seatMapController.calculatePlaneBodyHeight(mode: runningMode),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: ref.watch(cabinsProvider)!.length,
                itemBuilder: (_, i) {
                  return CabinWidget(
                    width: seatMapController.calculatePlaneBodyHeight(mode: runningMode) + 85,
                    cabin: ref.watch(cabinsProvider)![i],
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

class CabinWidget extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = ref.watch(seatMapProvider);
    double height = seatMapController.calculateCabinLength(index);
    DeviceType deviceType = DeviceInfo.deviceType(context);
    RunningMode runningMode = deviceType.isPhone ? RunningMode.phone : RunningMode.tablet;
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
              child: Text(cabin.cabinTitle, style: deviceType.isTablet ? MyTextTheme.white25 : MyTextTheme.white20),
            ),
            SizedBox(
              // color: Colors.blue,
              height: seatMapController.calculateCabinLinesLength(index, mode: runningMode),
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
                      ? seatMapState.airCraftBodySize.firstClassCabinsRatio
                      : cabinTitle == "Business"
                          ? seatMapState.airCraftBodySize.businessCabinsRatio
                          : 1.0);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RotatedBox(
                        quarterTurns: -1,
                        child: ExitDoor(
                          width: seatMapState.airCraftBodySize.seatWidth + 10,
                          height: deviceType.isTablet ? 30 : 20,
                          isEnable: upDoorEnable,
                        ),
                      ),
                      LineWidget(
                        line: cabin.lines[i],
                        height: cabinRatio * seatMapState.airCraftBodySize.seatWidth,
                        width: seatMapController.calculateCabinHeight(index, mode: runningMode),
                        cabinRatio: cabinRatio,
                      ),
                      RotatedBox(
                        quarterTurns: -1,
                        child: ExitDoor(
                          width: seatMapState.airCraftBodySize.seatWidth + 10,
                          height: deviceType.isTablet ? 30 : 20,
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

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
