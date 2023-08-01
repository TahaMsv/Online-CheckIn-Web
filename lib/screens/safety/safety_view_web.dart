import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/safety/safety_controller.dart';
import 'package:online_check_in/screens/safety/safety_state.dart';
import 'package:online_check_in/screens/safety/widgets/commitment_segment.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class SafetyViewWeb extends ConsumerWidget {
  SafetyViewWeb({Key? key}) : super(key: key);
  final SafetyController safetyController = getIt<SafetyController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ListView(
        children: [
          const AdviseSegment(),
          CommitmentSegment(),
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
        StepsScreenTitle(
          title: "The Standard For Safer Travel".translate(context),
          description: "",
          fontSize: 17,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  AssetImages.mask,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delta’s Commitment to You".translate(context),
                    style: MyTextTheme.darkGreyW70015,
                  ),
                  Container(
                    height: 70,
                    width: 650,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                        "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight."
                            .translate(context),
                        overflow: TextOverflow.clip,
                        style: MyTextTheme.darkGreyW40015),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
