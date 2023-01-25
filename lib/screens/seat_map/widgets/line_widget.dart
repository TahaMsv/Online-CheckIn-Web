import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/classes/line.dart';
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
    required this.isTabletMode,
  }) : super(key: key);

  final Line line;
  final double width;
  final double height;
  final double cabinRatio;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    SeatMapState seatMapState = context.watch<SeatMapState>();
    return Container(
      padding: isTabletMode ? const EdgeInsets.symmetric(horizontal: 20) : null,
      // color: Colors.green,
      height: height,
      width: width,
      margin: isTabletMode ? EdgeInsets.symmetric(vertical: seatMapState.linesMargin) : EdgeInsets.symmetric(horizontal: seatMapState.linesMargin),
      child: Center(
        child: line.type == "HorizontalCode"
            ? HorizontalCodeLine(cells: line.cells, cabinRatio: cabinRatio, isTabletMode: isTabletMode)
            : BodyLine(cells: line.cells, cabinRatio: cabinRatio, isTabletMode: isTabletMode),
      ),
    );
  }
}
