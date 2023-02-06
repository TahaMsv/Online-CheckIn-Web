import 'package:flutter/material.dart';

import '../../../core/classes/seat_map.dart';
import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../seat_map_controller.dart';

class CodeSeat extends StatelessWidget {
  const CodeSeat({
    Key? key,
    required this.cell,
    required this.cabinRatio,
    required this.isTabletMode,
  }) : super(key: key);
  final Cell cell;
  final double cabinRatio;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    final SeatMapController seatMapController = getIt<SeatMapController>();
    int seatType = seatMapController.seatViewType(cell.value, cell.type, cell.code);
    double width = cabinRatio * (isTabletMode ? seatMapController.getSeatHeight(seatType) : seatMapController.getSeatWidth(seatType));
    double height = cabinRatio * (!isTabletMode ? seatMapController.getSeatHeight(seatType) : seatMapController.getSeatWidth(seatType));
    return Container(
      margin: const EdgeInsets.all(2),
      width: width,
      height: height,
      decoration:  const BoxDecoration(color: MyColors.sonicSilver),
      child: Center(
        child: Text(
          cell.type == "Seat" ? cell.value! : "",
          style: isTabletMode ? MyTextTheme.white25 : const TextStyle(color: MyColors.white),
        ),
      ),
    );
  }
}
