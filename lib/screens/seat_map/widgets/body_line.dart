import 'package:flutter/material.dart';
import 'package:online_check_in/screens/seat_map/widgets/seat_widget.dart';

import '../../../core/classes/seat_map.dart';
import '../../../core/platform/device_info.dart';

class BodyLine extends StatelessWidget {
  final List<Cell> cells;
  final double cabinRatio;

  const BodyLine({
    Key? key,
    required this.cells,
    required this.cabinRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: deviceType.isTablet || deviceType.isPhone ? Axis.horizontal : Axis.vertical,
      itemCount: cells.length,
      itemBuilder: (_, i) {
        int inExitDoorLine = cells.indexWhere((element) => (element.type == "OutEquipmentExit" && element.value != null));
        return SeatWidget(cell: cells[i], inExitDoorLIne: (inExitDoorLine != -1), cabinRatio: cabinRatio);
      },
    );
  }
}
