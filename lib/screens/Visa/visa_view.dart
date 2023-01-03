import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_controller.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../core/utils/getTranslatedWord.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';

class VisaView extends StatelessWidget {
  VisaView({Key? key}) : super(key: key);
  final VisaController visaController = getIt<VisaController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    VisaState visaState = context.watch<VisaState>();
    StepsState stepsState = context.watch<StepsState>();
    return Scaffold(
      backgroundColor: MyColors.white,
      body:  Obx(
            () => visaState.loading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : !stepsState.isDocoNecessary
            ? Center(
          child: Text("No need to add visa".tr),
        )
            : Column(
          children: [
            StepsScreenTitle(
              title: "Visa".tr,
              description: "Enter visa data (DOCO) for all the passengers.".tr,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
                  () => Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  // crossAxisSpacing: 60,
                  childAspectRatio: 315 / 193,
                  children: stepsState.travelers.asMap().entries.map(
                        (entry) {
                      int idx = entry.key;
                      // Traveller traveller = entry.value;
                      return InfoCard(
                        index: idx,
                        // traveller: traveller,
                        myVisaController: visaController,
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
    required this.myVisaController,
    required this.index,
  }) : super(key: key);
  final int index;

  // final Traveller traveller;
  final VisaController myVisaController;

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
    Color textColor;
    Color bgColor;
    if (stepsState.travelers[index].visaInfo.isVisaInfoCompleted) {
      textColor = const Color(0xffffffff);
      bgColor =  MyColors.oceanGreen;
    } else {
      textColor =  MyColors.darkGrey;
      bgColor = const Color(0xffffffff);
    }
    return Container(
      // height: 300,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      width: 315,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: const Color(0xffeaeaea),
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
                color: stepsState.travelers[index].visaInfo.isVisaInfoCompleted ? MyColors.white.withOpacity(0) : const Color(0xfff86f6f),
                size: 20,
              )
            ],
          ),
          Text(
            stepsState.travelers[index].getFullNameWithGender(),
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
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
                "${stepsState.travelers[index].flightInformation.passengers[0].id}",
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Passport No: ".tr,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Text(
              //   "45678",
              //   style: TextStyle(
              //     color: textColor,
              //     fontSize: 15,
              //     fontWeight: FontWeight.w800,
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          stepsState.travelers[index].visaInfo.isVisaInfoCompleted
              ? EditVisaInfo(
            myVisaController: myVisaController,
            index: index,
          )
              : AddVisaInfo(
            myVisaController: myVisaController,
            index: index,
          ),
        ],
      ),
    );
  }
}

class AddVisaInfo extends StatelessWidget {
  const AddVisaInfo({
    Key? key,
    required this.myVisaController,
    required this.index,
  }) : super(key: key);
  final VisaController myVisaController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myVisaController.showDOCOPopup(index);
      },
      child: Row(
        children: [
          const Icon(
            Icons.add_circle_outline_rounded,
            color: Color(0xff4d6fff),
            size: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Add Visa Info".tr,
            style: const TextStyle(
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

class EditVisaInfo extends StatelessWidget {
  const EditVisaInfo({
    Key? key,
    required this.myVisaController,
    required this.index,
  }) : super(key: key);
  final VisaController myVisaController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.check,
              color: Color(0xffffffff),
              size: 18,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Visa No: 45687".tr,
              style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            myVisaController.showDOCOPopup(index);
          },
          child: const Icon(
            MenuIcons.iconEdit,
            color: MyColors.white,
            size: 18,
          ),
        )
      ],
    );
  }
}


Container placeOfIssueDropDown(int index, {double width = 400, double height = 40, double fontSize = 15}) {
  final VisaController visaController = getIt<VisaController>();
  final VisaState visaState = getIt<VisaState>();
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xffeaeaea),
        width: 2,
      ),
    ),
    child: Obx(
          () => DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: DropdownButton(
            // hint: Text(
            //   'Place of Issue',
            // ),
            onChanged: (newValue) {
              visaState.travelers[index].visaInfo.placeOfIssue = getKeyFromLanguageWords( newValue.toString());
              visaController.refreshList(index);
            },
            value: visaState.travelers[index].visaInfo.placeOfIssue == null || visaState.travelers[index].visaInfo.placeOfIssue == "Place of issue" ? "Place of issue".tr : visaState.travelers[index].visaInfo.placeOfIssue,
            items: visaState.listIssuePlace.map(
                  (selectedType) {
                visaState.travelers[index].visaInfo.placeOfIssueID = selectedType.id;
                return DropdownMenuItem(
                  value: selectedType.englishName! == "Place of issue" ? ("Place of issue".tr) : selectedType.englishName!,
                  child: Text(
                    selectedType.englishName! == "Place of issue" ? ("Place of issue".tr) : selectedType.englishName!,
                    style: TextStyle(fontSize: fontSize),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    ),
  );
}

Container typeDropDown(int index, {double width = 400, double height = 40, double fontSize = 15}) {
  final VisaController visaController = getIt<VisaController>();
  final VisaState visaState = getIt<VisaState>();
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xffeaeaea),
        width: 2,
      ),
    ),
    child: Obx(
          () => DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: DropdownButton(
            // hint: Text(
            //   'Type',
            // ),
            onChanged: (newValue) {
              visaState.travelers[index].visaInfo.type = getKeyFromLanguageWords( newValue.toString());
              visaController.refreshList(index);
            },
            value: visaState.travelers[index].visaInfo.type == null || visaState.travelers[index].visaInfo.type == "Type" ? "Type".tr : visaState.travelers[index].visaInfo.type,
            items: visaState.listType.map(
                  (selectedType) {
                return DropdownMenuItem(
                  value: selectedType.fullName == "Type" ? ("Type".tr) : selectedType.fullName,
                  child: Text(
                    selectedType.fullName == "Type" ? ("Type".tr) : selectedType.fullName,
                    style: TextStyle(fontSize: fontSize),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    ),
  );
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.function,
    this.height = 40,
    this.width = 130,
    this.fontSize = 15,
  }) : super(key: key);
  final Function function;
  final double height;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 1,
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xff4d6ff8),
          ),
          child: MyElevatedButton(
            height: 50,
            width: 175,
            buttonText: "Submit".tr,
            fontSize: fontSize,
            bgColor: MyColors.white,
            fgColor: const Color(0xff4d6ff8),
            function: () {
              function();
            },
          ),
        ),
      ],
    );
  }
}
