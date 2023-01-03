import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/ui.dart';
import '../../../widgets/StepsScreenTitle.dart';

class AdviseSegment extends StatelessWidget {
  const AdviseSegment({
    Key? key,
    required this.isTabletMode,
  }) : super(key: key);

  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(
            title: "The Standard For Safer Travel",
            description: "",
            fontSize: isTabletMode ? 45 : 17,
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
                    AssetImages.MASK,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delta’s Commitment to You",
                      style: isTabletMode ? MyTextTheme.darkGreyW70025 : MyTextTheme.darkGreyW70015,
                    ),
                    Container(
                      height: 70,
                      width: 650,
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                          "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight."
                              ,
                          overflow: TextOverflow.clip,
                          style: isTabletMode ? MyTextTheme.darkGreyW40020 : MyTextTheme.darkGreyW40015),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
