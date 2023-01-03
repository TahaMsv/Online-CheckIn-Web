import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/core/constants/assets.dart';
import 'package:online_checkin_web_refactoring/screens/safety/safety_controller.dart';
import 'package:online_checkin_web_refactoring/screens/safety/safety_state.dart';
import 'package:online_checkin_web_refactoring/screens/safety/widgets/advise_segment.dart';
import 'package:online_checkin_web_refactoring/screens/safety/widgets/commitment_segment.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/MtDottedLine.dart';
import '../../widgets/StepsScreenTitle.dart';

class SafetyView extends StatelessWidget {
  SafetyView({Key? key}) : super(key: key);
  final SafetyController safetyController = getIt<SafetyController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SafetyState safetyState = context.watch<SafetyState>();
    return Scaffold(
      backgroundColor: MyColors.mainColor,
      body: ListView(
        children: [
          const AdviseSegment(isTabletMode: false),
          CommitmentSegment(
            mySafetyController: safetyController,
            safetyState: safetyState,
            isTabletMode: false,
          ),
        ],
      ),
    );
  }
}
