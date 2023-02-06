import 'package:flutter/material.dart';

import '../../../core/classes/seat_map.dart';
import 'code_seat.dart';

class HorizontalCodeLine extends StatelessWidget {
  const HorizontalCodeLine({
    Key? key,
    required this.cells,
    required this.cabinRatio,
    required this.isTabletMode,
  }) : super(key: key);

  final List<Cell> cells;
  final double cabinRatio;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: isTabletMode ? Axis.horizontal : Axis.vertical,
        itemCount: cells.length,
        itemBuilder: (_, i) {
          return CodeSeat(cell: cells[i], cabinRatio: cabinRatio, isTabletMode: isTabletMode);
        },
      ),
    );
  }
}
