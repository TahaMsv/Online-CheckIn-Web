import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_controller.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_state.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/StepsScreenTitle.dart';

class PassportView extends StatelessWidget {
  PassportView({Key? key}) : super(key: key);
  final PassportController passportController = getIt<PassportController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    PassportState passportState = context.watch<PassportState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StepsScreenTitle(
            title: "Passport".tr,
            description: "Enter passport data (DOCS) for all the passengers.".tr,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              // crossAxisSpacing: 60,
              childAspectRatio: 315 / 193,
              children: passportState.travelers.asMap().entries.map(
                (entry) {
                  int idx = entry.key;
                  return InfoCard(
                    index: idx,
                    myPassportController: passportController,
                  );
                },
              ).toList(),
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
    required this.myPassportController,
    required this.index,
  }) : super(key: key);
  final int index;

  final PassportController myPassportController;

  @override
  Widget build(BuildContext context) {
    PassportState passportState = context.watch<PassportState>();
    Color textColor;
    Color bgColor;
    if (passportState.travelers[index].passportInfo.isPassInfoCompleted) {
      textColor = const Color(0xffffffff);
      bgColor = const Color(0xff48c0a2);
    } else {
      textColor = const Color(0xff424242);
      bgColor = const Color(0xffffffff);
    }
    return Container(
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
                color: passportState.travelers[index].passportInfo.isPassInfoCompleted ? Colors.white.withOpacity(0) : const Color(0xfff86f6f),
                size: 20,
              )
            ],
          ),
          Text(
            passportState.travelers[index].getFullNameWithGender(),
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
                "ID".tr + ": ",
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${passportState.travelers[index].flightInformation.passengers[0].id}",
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          passportState.travelers[index].passportInfo.isPassInfoCompleted
              ? EditIPassInfo(
                  index: index,
                  myPassportController: myPassportController,
                )
              : AddPassInfo(
                  index: index,
                  myPassportController: myPassportController,
                ),
        ],
      ),
    );
  }
}

class AddPassInfo extends StatelessWidget {
  const AddPassInfo({
    Key? key,
    required this.myPassportController,
    required this.index,
  }) : super(key: key);

  final PassportController myPassportController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myPassportController.showDOCSPopup(index);
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
            "Add Passport Info".tr,
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

class EditIPassInfo extends StatelessWidget {
  const EditIPassInfo({
    Key? key,
    required this.myPassportController,
    required this.index,
  }) : super(key: key);
  final PassportController myPassportController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
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
            myPassportController.showDOCSPopup(index);
          },
          child: const Icon(
            MenuIcons.iconEdit,
            color: Colors.white,
            size: 18,
          ),
        )
      ],
    );
  }
}

Container passportTypeDropDown(int index, {double width = 400, double height = 40}) {
  final PassportController passportController = getIt<PassportController>();
  final PassportState passportState = getIt<PassportState>();

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
              passportState.travelers[index].passportInfo.passportType = passportController.getKeyFromLanguageWords(newValue.toString());
              passportController.refreshList(index);
            },
            value: passportState.travelers[index].passportInfo.passportType == null || passportState.travelers[index].passportInfo.passportType == "Passport Type"
                ? "Passport Type".tr
                : passportState.travelers[index].passportInfo.passportType,
            items: passportState.listPassportType.map(
              (selectedType) {
                return DropdownMenuItem(
                  value: selectedType.fullName == "Passport Type" ? "Passport Type".tr : selectedType.fullName,
                  child: Text(
                    selectedType.fullName == "Passport Type" ? "Passport Type".tr : selectedType.fullName,
                    style: const TextStyle(fontSize: 25),
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

Container nationalityDropDown(int index, {double width = 400, double height = 40}) {
  final PassportController passportController = getIt<PassportController>();
  final PassportState passportState = getIt<PassportState>();

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
            hint: const Text(
              'Nationality',
              style: TextStyle(fontSize: 25),
            ),
            onChanged: (newValue) {
              passportState.travelers[index].passportInfo.nationality = passportController.getKeyFromLanguageWords(newValue.toString());
              passportController.refreshList(index);
            },
            value: passportState.travelers[index].passportInfo.nationality == null || passportState.travelers[index].passportInfo.nationality == "Nationality"
                ? "Nationality".tr
                : passportState.travelers[index].passportInfo.nationality,
            items: passportState.nationalitiesList.map(
              (selectedType) {
                passportState.travelers[index].passportInfo.nationalityID = selectedType.id;
                return DropdownMenuItem(
                  value: selectedType.englishName! == "Nationality" ? ("Nationality".tr) : selectedType.englishName!,
                  child: Text(
                    selectedType.englishName! == "Nationality" ? ("Nationality".tr) : selectedType.englishName!,
                    style: const TextStyle(fontSize: 25),
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

Container countryOfIssueDropDown(int index, {double width = 200, double height = 40}) {
  final PassportController passportController = getIt<PassportController>();
  final PassportState passportState = getIt<PassportState>();

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
            //   'Country of Issue'.tr,
            // ),
            onChanged: (newValue) {
              passportState.travelers[index].passportInfo.countryOfIssue = passportController.getKeyFromLanguageWords(newValue.toString());
              passportController.refreshList(index);
            },
            value: passportState.travelers[index].passportInfo.countryOfIssue == null || passportState.travelers[index].passportInfo.countryOfIssue == "Country of Issue"
                ? "Country of Issue".tr
                : passportState.travelers[index].passportInfo.countryOfIssue,
            items: passportState.countryOfIssueList.map(
              (selectedType) {
                return DropdownMenuItem(
                  value: selectedType.englishName! == "Country of Issue" ? ("Country of Issue".tr) : selectedType.englishName!,
                  child: Text(
                    selectedType.englishName! == "Country of Issue" ? ("Country of Issue".tr) : selectedType.englishName!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
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

Container genderDropDown(int index, {double width = 200, double height = 40}) {
  final PassportController passportController = getIt<PassportController>();
  final PassportState passportState = getIt<PassportState>();

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
            //   'Gender'.tr,
            // ),
            onChanged: (newValue) {
              passportState.travelers[index].passportInfo.gender = passportController.getKeyFromLanguageWords(newValue.toString());
              passportController.refreshList(index);
            },
            value: passportState.travelers[index].passportInfo.gender == null || passportState.travelers[index].passportInfo.gender == "Gender"
                ? "Gender".tr
                : passportState.travelers[index].passportInfo.gender!.tr,
            items: passportState.listGender.map(
              (selectedType) {
                return DropdownMenuItem(
                  value: selectedType.tr == "Gender" ? "Gender".tr : selectedType.tr,
                  child: Text(
                    selectedType.tr == "Gender" ? "Gender".tr : selectedType.tr,
                    style: const TextStyle(fontSize: 20),
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
