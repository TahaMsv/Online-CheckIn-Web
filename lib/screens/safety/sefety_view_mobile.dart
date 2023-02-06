import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/safety/safety_controller.dart';
import 'package:online_check_in/screens/safety/safety_state.dart';
import 'package:online_check_in/screens/safety/widgets/commitment_segment.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class SafetyView extends StatelessWidget {
  SafetyView({Key? key}) : super(key: key);
  final SafetyController safetyController = getIt<SafetyController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SafetyState safetyState = context.watch<SafetyState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ListView(
        children: [
          const AdviseSegment(),
          CommitmentSegment(
            safetyState: safetyState
          ),
        ],
      ),
    );
  }
}

class AdviseSegment extends StatelessWidget {
  const AdviseSegment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StepsScreenTitle(
          title: "The Standard For Safer Travel",
          description: "",
          fontSize: 25,
        ),
        Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(AssetImages.mask, fit: BoxFit.fill),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Delta’s Commitment to You", style: MyTextTheme.darkGreyW70020),
              Container(
                height: 80,
                // width: 650,
                margin: const EdgeInsets.only(top: 5),
                child: const Text(
                    "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight.",
                    overflow: TextOverflow.clip,
                    style: MyTextTheme.darkGreyW40015),
              )
            ],
          ),
        ),
      ],
    );
  }
}
