import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/classes/cell.dart';
import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../seat_map_controller.dart';
import '../seat_map_state.dart';
class SeatWidget extends StatefulWidget {
  const SeatWidget({
    Key? key,
    required this.cell,
    required this.inExitDoorLIne,
    required this.cabinRatio,
    required this.isTabletMode,
  }) : super(key: key);
  final Cell cell;
  final bool inExitDoorLIne;
  final double cabinRatio;
  final bool isTabletMode;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    final SeatMapController seatMapController = getIt<SeatMapController>();
    SeatMapState seatMapState = context.watch<SeatMapState>();
    List<dynamic> seatView = seatMapController.seatView(widget.cell, widget.cabinRatio, widget.isTabletMode);
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
          seatMapController.changeSeatStatus(widget.cell.code!);
        });
      }
          : null,
      child: Container(
          width: width,
          height: height,
          margin: widget.isTabletMode ? const EdgeInsets.symmetric(horizontal: 2) : const EdgeInsets.symmetric(vertical: 2),
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
                  width: widget.cabinRatio *(widget.isTabletMode ?seatMapState.seatHeight : seatMapState.seatWidth),
                  height: widget.cabinRatio *(!widget.isTabletMode ?seatMapState.seatHeight : seatMapState.seatWidth),
                );
              default:
                return Center(child: Text(seatText, style: TextStyle(color: textColor)));
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
    return Container(
      decoration: const BoxDecoration(color: MyColors.black, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: const Icon(Icons.close, color: MyColors.white, size: 15),
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
    required this.isEnable, required this.isTabletMode,
  }) : super(key: key);
  final double width;
  final double height;
  final bool isEnable;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return isEnable
        ? Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: MyColors.red),
      child: Center(child: Text("Exit", style:isTabletMode?MyTextTheme.white20: MyTextTheme.white12)),
    )
        : Container();
  }
}

