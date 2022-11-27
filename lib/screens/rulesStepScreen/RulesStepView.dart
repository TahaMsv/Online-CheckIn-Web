
import 'package:flutter/material.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../screens/rulesStepScreen/RulesStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class RulesStepView extends StatelessWidget {
  final RulesStepScreenController myRulesStepScreenController;

  RulesStepView(MainModel model) : myRulesStepScreenController = Get.put(RulesStepScreenController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepsScreenTitle(
              title: "Dangerous Goods".tr,
              description: "Every items can become dangerous when transported by air. Example of dangerous goods are:".tr,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 6,
                // crossAxisSpacing: 60,
                childAspectRatio: 150/ 180,
                children: myRulesStepScreenController.rules.map(
                  (value) {
                    int index = myRulesStepScreenController.rules.indexOf(value);
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
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: 150,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffeaeaea)),
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
          SizedBox(
            height: 10,
          ),
          Text(
            value["title"]!.tr,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff424242),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            value["content"]!.tr,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff424242),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
