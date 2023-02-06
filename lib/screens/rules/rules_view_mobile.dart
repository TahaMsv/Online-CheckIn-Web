import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/rules/rules_controller.dart';
import 'package:online_check_in/screens/rules/rules_state.dart';
import '../../core/constants/assets.dart';
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
      backgroundColor: theme.primaryColor,
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepsScreenTitle(title: "Dangerous Goods", fontSize: 25, description: ""),
            const SizedBox(height: 10),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      // width: width * 0.5,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffeaeaea)),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              value["imageUrl"]!,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
              width: 10
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value["title"]! ,
                style: MyTextTheme.darkGreyBold17,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height: 5
              ),
              SizedBox(
                // height: 40,
                width: Get.width * 0.7,
                child: Text(
                  value["content"]! ,
                  // overflow: TextOverflow.,
                  style: MyTextTheme.darkGreyW40015,
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