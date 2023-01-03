import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/rules/rules_controller.dart';
import 'package:online_checkin_web_refactoring/screens/rules/rules_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class RulesView extends StatelessWidget {
  RulesView({Key? key}) : super(key: key);
  final RulesController rulesController = getIt<RulesController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    RulesState rulesState = context.watch<RulesState>();
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Container(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepsScreenTitle(
              title: "Dangerous Goods".tr,
              description: "Every items can become dangerous when transported by air. Example of dangerous goods are:".tr,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 6,
                // crossAxisSpacing: 60,
                childAspectRatio: 150/ 180,
                children: rulesState.rules.map(
                      (value) {
                    int index = rulesState.rules.indexOf(value);
                    value["imageUrl"] = "assets/images/DangerousGoods${index + 1}.png";
                    return DangerousItem(
                      value: value,
                    );
                  },
                ).toList(),
              ),
            ),
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
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            child: Image.asset(
              value["imageUrl"]!,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value["title"]!.tr,
            style: const TextStyle(
              fontSize: 15,
              color: MyColors.darkGrey,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value["content"]!.tr,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              fontSize: 14,
              color: MyColors.darkGrey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
