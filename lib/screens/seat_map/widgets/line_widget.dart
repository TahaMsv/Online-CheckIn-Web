import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/classes/seat_map.dart';
import '../../../core/platform/device_info.dart';
import '../seat_map_state.dart';
import 'body_line.dart';
import 'horizontal_code_line.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({
    Key? key,
    required this.line,
    required this.width,
    required this.cabinRatio,
    required this.height,
  }) : super(key: key);

  final Line line;
  final double width;
  final double height;
  final double cabinRatio;

  @override
  Widget build(BuildContext context) {
    SeatMapState seatMapState = context.watch<SeatMapState>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      padding: deviceType.isTablet || deviceType.isPhone? const EdgeInsets.symmetric(horizontal: 20) : null,
      // color: Colors.green,
      height: height,
      width: width,
      margin: deviceType.isTablet || deviceType.isPhone?EdgeInsets.symmetric(vertical: seatMapState.airCraftBodySize.linesMargin) : EdgeInsets.symmetric(horizontal: seatMapState.airCraftBodySize.linesMargin),
      child: Center(
        child: line.type == "HorizontalCode"
            ? HorizontalCodeLine(cells: line.cells, cabinRatio: cabinRatio)
            : BodyLine(cells: line.cells, cabinRatio: cabinRatio),
      ),
    );
  }
}
