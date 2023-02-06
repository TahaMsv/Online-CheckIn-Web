import 'package:flutter/material.dart';
import 'package:online_check_in/screens/seat_map/widgets/seat_widget.dart';

import '../../../core/classes/seat_map.dart';

class BodyLine extends StatelessWidget {
  final List<Cell> cells;
  final double cabinRatio;

  const BodyLine({
    Key? key,
    required this.cells,
    required this.cabinRatio,
    required this.isTabletMode,
  }) : super(key: key);

  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: isTabletMode ? Axis.horizontal : Axis.vertical,
      itemCount: cells.length,
      itemBuilder: (_, i) {
        int inExitDoorLine = cells.indexWhere((element) => (element.type == "OutEquipmentExit" && element.value != null));
        return SeatWidget(
          cell: cells[i],
          inExitDoorLIne: (inExitDoorLine != -1),
          cabinRatio: cabinRatio,
          isTabletMode: isTabletMode,
        );
      },
    );
  }
}
