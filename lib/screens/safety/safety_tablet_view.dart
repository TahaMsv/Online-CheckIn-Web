import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/safety/safety_controller.dart';
import 'package:online_checkin_web_refactoring/screens/safety/safety_state.dart';
import 'package:online_checkin_web_refactoring/screens/safety/widgets/advise_segment.dart';
import 'package:online_checkin_web_refactoring/screens/safety/widgets/commitment_segment.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

class SafetyViewTablet extends StatelessWidget {
  SafetyViewTablet({Key? key}) : super(key: key);
  final SafetyController safetyController = getIt<SafetyController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SafetyState safetyState = context.watch<SafetyState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ListView(
        children: [
          const AdviseSegment(isTabletMode: true),
          CommitmentSegment(
            safetyState: safetyState,
            isTabletMode: true,
          ),
        ],
      ),
    );
  }
}
