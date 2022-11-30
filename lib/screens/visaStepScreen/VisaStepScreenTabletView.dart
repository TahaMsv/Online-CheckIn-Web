import 'package:flutter/material.dart';
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../screens/visaStepScreen/VisaStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VisaStepTabletView extends StatelessWidget {
  final VisaStepController myVisaStepController;

  VisaStepTabletView(MainModel model) : myVisaStepController = Get.put(VisaStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;
    MainModel model = context.watch<MainModel>();
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => myVisaStepController.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : !stepsScreenController.isDocoNecessary.value
                ? Center(
                    child: Text("No need to add visa".tr),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StepsScreenTitle(
                        title: "Visa".tr,
                        description: "",
                        fontSize: 45,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter visa data (DOCO) for all the passengers.".tr,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(
                        () => Expanded(
                          child: ListView(
                            children: myVisaStepController.travellers.asMap().entries.map(
                              (entry) {
                                int idx = entry.key;
                                // Traveller traveller = entry.value;
                                return InfoCard(
                                  index: idx,
                                  // traveller: traveller,
                                  myVisaStepController: myVisaStepController,
                                  fontSize: 25,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    // required this.traveller,
    required this.myVisaStepController,
    required this.index,
    this.fontSize = 15,
  }) : super(key: key);
  final int index;

  // final Traveller traveller;
  final VisaStepController myVisaStepController;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color bgColor;
    if (myVisaStepController.travellers[index].visaInfo.isVisaInfoCompleted) {
      textColor = Color(0xffffffff);
      bgColor = Color(0xff48c0a2);
    } else {
      textColor = Color(0xff424242);
      bgColor = Color(0xffffffff);
    }
    return Container(
      // height: 300,
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
                color: myVisaStepController.travellers[index].visaInfo.isVisaInfoCompleted ? Colors.white.withOpacity(0) : Color(0xfff86f6f),
                size: fontSize + 10,
              )
            ],
          ),
          Text(
            myVisaStepController.travellers[index].getFullNameWithGender(),
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
                "ID: ",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize - 2,
                ),
              ),
              Text(
                "${myVisaStepController.travellers[index].welcome.body.passengers[0].id}",
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Passport No: ".tr,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize - 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          myVisaStepController.travellers[index].visaInfo.isVisaInfoCompleted
              ? EditVisaInfo(
                  myVisaStepController: myVisaStepController,
                  index: index,
                )
              : AddVisaInfo(
                  myVisaStepController: myVisaStepController,
                  index: index,
                  mode: "tablet",
                ),
        ],
      ),
    );
  }
}

class AddVisaInfo extends StatelessWidget {
  const AddVisaInfo({
    Key? key,
    required this.myVisaStepController,
    required this.index,
    this.mode = "web",
  }) : super(key: key);
  final VisaStepController myVisaStepController;
  final int index;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mode == "web") {
          myVisaStepController.showDOCOPopup(index);
        } else if (mode == "tablet") {
          myVisaStepController.showBottomSheetForm(context, index);
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
            "Add Visa Info".tr,
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

class EditVisaInfo extends StatelessWidget {
  const EditVisaInfo({
    Key? key,
    required this.myVisaStepController,
    required this.index,
  }) : super(key: key);
  final VisaStepController myVisaStepController;
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
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Visa No: 45687".tr,
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            myVisaStepController.showDOCOPopup(index);
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
