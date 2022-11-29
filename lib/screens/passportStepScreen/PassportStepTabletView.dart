import 'package:flutter/material.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../screens/passportStepScreen/PassportStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class PassportStepTabletView extends StatelessWidget {
  final PassportStepController myPassportStepController;

  PassportStepTabletView(MainModel model) : myPassportStepController = Get.put(PassportStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(
            title: "Passport".tr,
            description: "",
            fontSize: 45,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter passport data (DOCS) for all the passengers.".tr,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
          Obx(
            () => Expanded(
              child: ListView(
                children: myPassportStepController.travellers.asMap().entries.map(
                  (entry) {
                    int idx = entry.key;
                    return InfoCard(
                      index: idx,
                      myPassportStepController: myPassportStepController,
                      fontSize: 25,
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
    required this.myPassportStepController,
    required this.index,
    this.fontSize = 15,
  }) : super(key: key);
  final int index;

  final PassportStepController myPassportStepController;
  final double fontSize;

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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
      // width: 315,
      height: 250,
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
                size: fontSize + 10,
              )
            ],
          ),
          Text(
            myPassportStepController.travellers[index].getFullNameWithGender(),
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Row(
            children: [
              Text(
                "ID".tr + ": ",
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize - 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${myPassportStepController.travellers[index].welcome.body.passengers[0].id}",
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
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
                  mode: "tablet",
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
    this.mode = "web",
  }) : super(key: key);

  final PassportStepController myPassportStepController;
  final int index;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (mode == "web") {
          myPassportStepController.showDOCSPopup(index);
        } else if (mode == "tablet") {
          myPassportStepController.showBottomSheetForm(context , index, );
        }
      },
      child: Row(
        children: [
          Icon(
            Icons.add_circle_outline_rounded,
            color: Color(0xff4d6fff),
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Add Passport Info".tr,
            style: TextStyle(
              color: Color(0xff4d6fff),
              fontSize: 22,
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
            // Text(
            //   "Passport No: ",
            //   style: TextStyle(
            //     color: Color(0xffffffff),
            //     fontSize: 12,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
          ],
        ),
        GestureDetector(
          onTap: () {
            myPassportStepController.showDOCSPopup(index);
          },
          child: Icon(
            MenuIcons.iconEdit,
            color: Colors.white,
            size: 18,
          ),
        )
      ],
    );
  }
}
