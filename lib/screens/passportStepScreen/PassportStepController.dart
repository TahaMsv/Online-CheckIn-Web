import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
import 'package:onlinecheckin/screens/visaStepScreen/VisaStepController.dart';
import 'package:onlinecheckin/utility/DataProvider.dart';
import '../../global/Classes.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class PassportStepController extends MainController {
  PassportStepController._();

  static final PassportStepController _instance = PassportStepController._();

  factory PassportStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  void init() async {
    Response response = await DioClient.getDocumentTypes(
      execution: "[OnlineCheckin].[SelectDocumentTypes]",
      token: model.token,
      request: {},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        final VisaStepController visaStepController = Get.put(VisaStepController(model));
        List visaTypes = response.data["Body"]["VisaTypes"];
        List passportTypes = response.data["Body"]["PassportTypes"];
        for (var i = 0; i < visaTypes.length; ++i) {
          visaStepController.listType.add(new VisaType(id: visaTypes[i]["ID"], shortName: visaTypes[i]["ShortName"], name: visaTypes[i]["name"], fullName: visaTypes[i]["FullName"]));
        }
        for (var i = 0; i < passportTypes.length; ++i) {
          listPassportType.add(new PassPortType(id: passportTypes[i]["ID"], shortName: passportTypes[i]["ShortName"], name: passportTypes[i]["name"], fullName: passportTypes[i]["FullName"]));
        }
      }
    } else {}
  }

  List<Traveller> travellersList() {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    return stepsScreenController.travellers;
  }

  TextEditingController documentNoC = TextEditingController();

  List<PassPortType> listPassportType = [new PassPortType(id: -1, shortName: "", name: "", fullName: "Passport Type")];

  final RxString selectedPassportType = "Passport Type".obs;

  void setSelected(String value) {
    selectedPassportType.value = value;
  }

  List<String> listCountryIssue = ["Country of Issue", "Country of Issue1"];

  final RxString selectedCountryIssue = "Country of Issue".obs;

  void setSelectedCountryIssue(String value) {
    selectedCountryIssue.value = value;
  }

  List<String> listGender = ["Male", "Female"];

  final RxString selectedGender = "Male".obs;

  void setSelectedGender(String value) {
    selectedGender.value = value;
  }

  List<String> listNationality = ["Nationality", "Nationality1"];

  final RxString selectedNationality = "Nationality".obs;

  void setSelectedNationality(String value) {
    selectedNationality.value = value;
  }

  void showDOCSPopup() {
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.white,
      buttonColor: Colors.red,
      barrierDismissible: true,
      radius: 10,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(title: "Passport / Visa Details - Jack Taylor", description: ""),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              passportTypeDropDown(),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: UserTextInput(
                  controller: documentNoC,
                  hint: "Document No.",
                  errorText: "",
                  isEmpty: false,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              genderDropDown(),
              SizedBox(
                width: 20,
              ),
              countryOfIssueDropDown(),
              SizedBox(
                width: 20,
              ),
              SelectingDateWidget(hint: "Entry Date"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              nationalityDropDown(),
              SizedBox(
                width: 20,
              ),
              SelectingDateWidget(hint: "Date of Birth"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),
              MyElevatedButton(
                height: 50,
                width: 175,
                buttonText: "Submit",
                bgColor: Colors.white,
                fgColor: Color(0xff4d6ff8),
                function: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Container passportTypeDropDown() {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeaeaea),
          width: 2,
        ),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton(
              hint: Text(
                'Type',
              ),
              onChanged: (newValue) {
                setSelected(newValue.toString());
              },
              value: selectedPassportType.value,
              items: listPassportType.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child:  Text(
                      selectedType.fullName,
                    ),
                    value: selectedType.fullName,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Container nationalityDropDown() {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeaeaea),
          width: 2,
        ),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton(
              hint: Text(
                'Nationality',
              ),
              onChanged: (newValue) {
                setSelectedNationality(newValue.toString());
              },
              value: selectedNationality.value,
              items: listNationality.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType,
                    ),
                    value: selectedType,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Container countryOfIssueDropDown() {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeaeaea),
          width: 2,
        ),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton(
              hint: Text(
                'Country of Issue',
              ),
              onChanged: (newValue) {
                setSelectedCountryIssue(newValue.toString());
              },
              value: selectedCountryIssue.value,
              items: listCountryIssue.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType,
                    ),
                    value: selectedType,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Container genderDropDown() {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeaeaea),
          width: 2,
        ),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton(
              hint: Text(
                'Gender',
              ),
              onChanged: (newValue) {
                setSelectedGender(newValue.toString());
              },
              value: selectedGender.value,
              items: listGender.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType,
                    ),
                    value: selectedType,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    print("PassportStepController Init");
    init();
    super.onInit();
  }

  @override
  void onClose() {
    print("PassportStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("PassportStepController Ready");
    super.onReady();
  }
}
