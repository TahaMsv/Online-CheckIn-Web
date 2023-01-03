import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/core/constants/ui.dart';
import 'package:online_checkin_web_refactoring/screens/rules/rules_controller.dart';
import 'package:online_checkin_web_refactoring/screens/rules/rules_state.dart';
import '../../core/constants/assets.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class RulesViewTablet extends StatelessWidget {
  RulesViewTablet({Key? key}) : super(key: key);
  final RulesController rulesController = getIt<RulesController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    RulesState rulesState = context.watch<RulesState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepsScreenTitle(
              title: "Dangerous Goods".tr,
              fontSize: 45,
              description: "",
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: rulesState.rules.map(
                  (value) {
                    int index = rulesState.rules.indexOf(value);
                    value["imageUrl"] = "${AssetImages.assetsAddressDangerousGood}${index + 1}.png";
                    return DangerousItem(
                      value: value,
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DangerousItem extends StatelessWidget {
  const DangerousItem({
    Key? key,
    required this.value,
  }) : super(key: key);

  final Map<String, String> value;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: 150,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffeaeaea)),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Image.asset(
              value["imageUrl"]!,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value["title"]!.tr,
                style: MyTextTheme.darkGreyBold25,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                // height: 40,
                width: Get.width * 0.7,
                child: Text(
                  value["content"]!.tr,
                  // overflow: TextOverflow.,
                  style: MyTextTheme.darkGreyW40020,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
