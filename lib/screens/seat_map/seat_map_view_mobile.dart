import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/seat_map/seat_map_controller.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/seat_map/widgets/plane.dart';
import 'package:online_check_in/screens/seat_map/widgets/travelers_list.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

class SeatMapView extends StatelessWidget {
  SeatMapView({Key? key}) : super(key: key);
  final SeatMapController seatMapController = getIt<SeatMapController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(backgroundColor: theme.primaryColor, body: const Plane());
  }
}
