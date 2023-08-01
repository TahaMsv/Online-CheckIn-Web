import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import '../../../core/classes/seat_map.dart';
import '../../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import '../../../core/platform/device_info.dart';
import '../seat_map_controller.dart';
import '../seat_map_state.dart';

class SeatWidget extends ConsumerStatefulWidget {
  const SeatWidget({
    Key? key,
    required this.cell,
    required this.inExitDoorLIne,
    required this.cabinRatio,
  }) : super(key: key);
  final Cell cell;
  final bool inExitDoorLIne;
  final double cabinRatio;

  @override
  ConsumerState<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends ConsumerState<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = ref.watch(seatMapProvider);
    DeviceType deviceType = DeviceInfo.deviceType(context);
    List<dynamic> seatView = seatMapController.seatView(widget.cell, widget.cabinRatio, deviceType.isTablet || deviceType.isPhone);
    double width = seatView[0];
    double height = seatView[1];
    bool isSeatClickable = seatView[2];
    bool hasShadow = seatView[3];
    String seatText = seatView[4];
    Color color = seatView[5];
    Color textColor = seatView[6];
    return GestureDetector(
      onTap: isSeatClickable
          ? () {
              setState(() {
                deviceType.isTablet || deviceType.isPhone ? seatMapController.changeSeatStatusTablet(widget.cell.code!) : seatMapController.changeSeatStatus(widget.cell.code!);
              });
            }
          : null,
      child: Container(
          width: width,
          height: height,
          margin: deviceType.isTablet || deviceType.isPhone ? const EdgeInsets.symmetric(horizontal: 2) : const EdgeInsets.symmetric(vertical: 2),
          decoration:
              BoxDecoration(color: color, border: widget.inExitDoorLIne && hasShadow ? Border.all(color: MyColors.red, width: 2) : null, borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: (() {
            switch (seatMapController.seatViewType(widget.cell.value, widget.cell.type, widget.cell.code)) {
              case 9:
                return Container();
              case 3:
                return const BlockedSeat();
              case 4:
                return CheckedInSeat(
                  width: widget.cabinRatio * (deviceType.isTablet || deviceType.isPhone ? seatMapState.airCraftBodySize.seatHeight : seatMapState.airCraftBodySize.seatWidth),
                  height: widget.cabinRatio * (!(deviceType.isTablet || deviceType.isPhone) ? seatMapState.airCraftBodySize.seatHeight : seatMapState.airCraftBodySize.seatWidth),
                );
              default:
                return Center(child: Text(seatText, style: TextStyle(color: textColor, fontSize: deviceType.isTablet || deviceType.isPhone ? 11 : null)));
            }
          }())),
    );
  }
}

class BlockedSeat extends StatelessWidget {
  const BlockedSeat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      decoration: const BoxDecoration(color: MyColors.black, borderRadius: BorderRadius.all(Radius.circular(10))),
      child:  Icon(Icons.close, color: MyColors.white, size:deviceType.isTablet || deviceType.isPhone?7: 15),
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
      decoration: const BoxDecoration(
        color: MyColors.lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
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
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return isEnable
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: MyColors.red),
            child: Center(
                child: Text("Exit",
                    style: deviceType.isTablet
                        ? MyTextTheme.white16
                        : deviceType.isTablet
                            ? MyTextTheme.white20
                            : MyTextTheme.white12)),
          )
        : Container();
  }
}
