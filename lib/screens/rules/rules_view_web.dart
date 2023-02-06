import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/core/constants/my_list.dart';
import 'package:online_check_in/screens/rules/rules_controller.dart';
import 'package:online_check_in/screens/rules/rules_state.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class RulesViewWeb extends StatelessWidget {
  RulesViewWeb({Key? key}) : super(key: key);
  final RulesController rulesController = getIt<RulesController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    RulesState rulesState = context.watch<RulesState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepsScreenTitle(
              title: "Dangerous Goods" ,
              description: "Every items can become dangerous when transported by air. Example of dangerous goods are:" ,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 6,
                childAspectRatio: 150 / 180,
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
        border: Border.all(color: MyColors.white1),
      ),
      child: Column(
        children: [
          SizedBox(
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
            value["title"]! ,
            style: MyTextTheme.darkGreyBold15,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value["content"]! ,
            overflow: TextOverflow.clip,
            style: MyTextTheme.darkGreyW40015,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
