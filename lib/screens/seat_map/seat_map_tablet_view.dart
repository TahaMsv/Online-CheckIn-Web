import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:online_check_in/screens/seat_map/seat_map_controller.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/seat_map/widgets/line_widget.dart';
import 'package:online_check_in/screens/seat_map/widgets/my_custom-scroll_behavior.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane_head.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane_tail.dart';
import 'package:online_check_in/screens/seat_map/widgets/seat_widget.dart';
import 'package:online_check_in/screens/seat_map/widgets/travelers_list.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:online_check_in/widgets/MyDivider.dart';
import '../../core/classes/seat_map.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/MyElevatedButton.dart';
import '../../widgets/title_widget.dart';
import '../steps/steps_view_web.dart';

class SeatMapViewTablet extends StatelessWidget {
  SeatMapViewTablet({Key? key}) : super(key: key);
  final SeatMapController seatMapController = getIt<SeatMapController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SeatMapState seatMapState = context.watch<SeatMapState>();
    return Scaffold(backgroundColor: theme.primaryColor, body: const TravellersList());
  }
}
