import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../screens/rulesStepScreen/RulesStepController.dart';
import '../../widgets/MtDottedLine.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class RulesStepView extends StatelessWidget {
  final RulesStepScreenController myRulesStepScreenController;

  RulesStepView(MainModel model)
      : myRulesStepScreenController = Get.put(RulesStepScreenController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    var rules = [
      {
        "imageUrl": "",
        "title": "Magnetic Objects ",
        "content": "Magnets, Batteries and Magnetic Objects",
      },
      {
        "imageUrl": "",
        "title": "Type of Toxins",
        "content":
            " Powder, Liquid and Sprays of Laboratory Products For Infectious Agents",
      },
      {
        "imageUrl": "",
        "title": "Radioactive Material",
        "content": "Radioactive Substances Exposed To Radiation",
      },
      {
        "imageUrl": "",
        "title": "Types of Spray",
        "content": "Spray Containers (Including Spray Dispensers)",
      },
      {
        "imageUrl": "",
        "title": "Types of Capsule ",
        "content": "Gas Lighters, Oxygen and Any Type of Gas Cylinder",
      },
      {
        "imageUrl": "",
        "title": "Incendiary types",
        "content":
            "Matches are Just a Small Number Along With (strictly prohibited in the box)",
      },
      {
        "imageUrl": "",
        "title": "Types of Explosives ",
        "content":
            "Types of Ammunition, Explosives, Firecrackers and Fireworks Accessories",
      },
      {
        "imageUrl": "",
        "title": "Types of Oxidizing",
        "content":
            "Oxidizing and Oxidizing Materials, Detergents and Disinfectants",
      },
      {
        "imageUrl": "",
        "title": "Types of Weapons",
        "content":
            "Any Firearms or Cold Weapons (Knives, Scissors, Horns, Colt)",
      },
      {
        "imageUrl": "",
        "title": "Types of Acidic",
        "content":
            "Wet batteries, acidic substances, acidic fluids (lemon juice, pickles, etc.)",
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepsScreenTitle(
              title: "Dangerous Goods",
              description:          "Every items can become dangerous when transported by air. Example of dangerous goods are:",
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 6,
                // crossAxisSpacing: 60,
                childAspectRatio: 220 / 270,
                children: rules.map(
                  (value) {
                    return Container(
                      // height: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      width: 200,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffeaeaea)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            color: Colors.red,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            value["title"]!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff424242),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            value["content"]!,
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
