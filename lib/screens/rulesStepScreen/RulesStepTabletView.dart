import 'package:flutter/material.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../screens/rulesStepScreen/RulesStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class RulesStepTabletView extends StatelessWidget {
  final RulesStepScreenController myRulesStepScreenController;

  RulesStepTabletView(MainModel model) : myRulesStepScreenController = Get.put(RulesStepScreenController(model));

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
              fontSize: 45,
              description: "",
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: myRulesStepScreenController.rules.map(
                  (value) {
                    int index = myRulesStepScreenController.rules.indexOf(value);
                    value["imageUrl"] = "assets/images/DangerousGoods${index + 1}.png";
                    return
                      DangerousItem(
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
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: 150,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffeaeaea)),
      ),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            child: Image.asset(
              value["imageUrl"]!,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value["title"]!.tr,
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff424242),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // height: 40,
                width: Get.width * 0.7,
                child: Text(
                  value["content"]!.tr,
                  // overflow: TextOverflow.,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff424242),
                    fontWeight: FontWeight.w400,
                  ),
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
