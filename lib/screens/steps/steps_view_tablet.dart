import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_cotroller.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

class StepsViewTablet extends StatelessWidget {
  StepsViewTablet({Key? key}) : super(key: key);
  final StepsController stepsController = getIt<StepsController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    StepsState stepsState = context.watch<StepsState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Container(
        child: Center(child: Text("Steps view"),),
      ),
    );
  }
}
