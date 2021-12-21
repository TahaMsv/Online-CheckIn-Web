import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/global/Classes.dart';
import 'package:onlinecheckin/widgets/MyElevatedButton.dart';
import 'package:onlinecheckin/widgets/UserTextInput.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../screens/passportStepScreen/PassportStepController.dart';
import '../../screens/rulesStepScreen/RulesStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class PassportStepView extends StatelessWidget {
  final PassportStepController myPassportStepController;

  PassportStepView(MainModel model) : myPassportStepController = Get.put(PassportStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: !myPassportStepController.checkDocs.value
          ? Center(
              child: Text("No need to add passport"),
            )
          : Column(
              children: [
                StepsScreenTitle(
                  title: "Passport",
                  description: "Enter passport data (DOCS) for all the passengers.",
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      // crossAxisSpacing: 60,
                      childAspectRatio: 315 / 193,
                      children: myPassportStepController.travellers.asMap().entries.map(
                        (entry) {
                          int idx = entry.key;
                          Traveller traveller = entry.value;
                          return InfoCard(
                            index: idx,
                            // traveller: traveller,
                            myPassportStepController: myPassportStepController,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    // required this.traveller,
    required this.myPassportStepController,
    required this.index,
  }) : super(key: key);
  final int index;

  // final Traveller traveller;
  final PassportStepController myPassportStepController;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color bgColor;
    if (myPassportStepController.travellers[index].passportInfo.isPassInfoCompleted) {
      textColor = Color(0xffffffff);
      bgColor = Color(0xff48c0a2);
    } else {
      textColor = Color(0xff424242);
      bgColor = Color(0xffffffff);
    }
    return Container(
      // height: 300,
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      width: 315,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: Color(0xffeaeaea),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.warning_amber_sharp,
                color: myPassportStepController.travellers[index].passportInfo.isPassInfoCompleted ? Colors.white.withOpacity(0) : Color(0xfff86f6f),
                size: 20,
              )
            ],
          ),
          Text(
            myPassportStepController.travellers[index].getFullNameWithGender(),
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            children: [
              Text(
                "ID: ",
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${myPassportStepController.travellers[index].welcome.body.passengers[0].id}",
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          myPassportStepController.travellers[index].passportInfo.isPassInfoCompleted
              ? EditIPassInfo(
                  index: index,
                  myPassportStepController: myPassportStepController,
                )
              : AddPassInfo(
                  index: index,
                  myPassportStepController: myPassportStepController,
                ),
        ],
      ),
    );
  }
}

class AddPassInfo extends StatelessWidget {
  const AddPassInfo({
    Key? key,
    required this.myPassportStepController,
    required this.index,
  }) : super(key: key);

  final PassportStepController myPassportStepController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myPassportStepController.showDOCSPopup(index);
      },
      child: Row(
        children: [
          Icon(
            Icons.add_circle_outline_rounded,
            color: Color(0xff4d6fff),
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Add Passport Info",
            style: TextStyle(
              color: Color(0xff4d6fff),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class EditIPassInfo extends StatelessWidget {
  const EditIPassInfo({
    Key? key,
    required this.myPassportStepController,
    required this.index,
  }) : super(key: key);
  final PassportStepController myPassportStepController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.check,
              color: Color(0xffffffff),
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Passport No: ",
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            myPassportStepController.showDOCSPopup(index);
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 18,
          ),
        )
      ],
    );
  }
}
