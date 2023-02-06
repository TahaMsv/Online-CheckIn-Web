import 'package:flutter/material.dart';

import '../../../core/classes/seat_map.dart';
import '../../../core/platform/device_info.dart';
import 'code_seat.dart';

class HorizontalCodeLine extends StatelessWidget {
  const HorizontalCodeLine({
    Key? key,
    required this.cells,
    required this.cabinRatio,
  }) : super(key: key);

  final List<Cell> cells;
  final double cabinRatio;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Center(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection:deviceType.isTablet || deviceType.isPhone? Axis.horizontal : Axis.vertical,
        itemCount: cells.length,
        itemBuilder: (_, i) {
          return CodeSeat(cell: cells[i], cabinRatio: cabinRatio);
        },
      ),
    );
  }
}
