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
    await getDocumentTypes();
    await getSelectCountries();
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    travellers = stepsScreenController.travellers;
  }

  Future<void> getSelectCountries() async {
    Response response = await DioClient.getSelectCountries(
      execution: "[OnlineCheckin].[SelectCountries]",
      token: model.token,
      request: {},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        countriesList.addAll(List<Country>.from(response.data["Body"]["Countries"].map((x) => Country.fromJson(x))));
        for (var i = 0; i < countriesList.length; ++i) {
          countryOfIssueList.add(countriesList[i]);
          nationalitiesList.add(countriesList[i]);
        }
      }
    } else {}
  }

  Future<void> getDocumentTypes() async {
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

  //
  // List<Traveller> travellersList() {
  //   final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
  //   return stepsScreenController.travellers;
  // }

  TextEditingController documentNoC = TextEditingController();

  List<PassPortType> listPassportType = [new PassPortType(id: -1, shortName: "", name: "", fullName: "Passport Type")];

  // final RxString selectedPassportType = "Passport Type".obs;

  void setSelected(int index, String value) {
    travellers[index].passportInfo.passportType = value;
    travellers.refresh();
  }

  List<Traveller> travellersList() {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    return stepsScreenController.travellers;
  }
  List<Country> countriesList = [];
  List<Country> countryOfIssueList = [
    new Country(worldAreaCode: null, currencyId: null, englishName: "Country of Issue", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

  // final RxString selectedCountryIssue = "Country of Issue".obs;

  void setSelectedCountryIssue(int index, String value) {
    travellers[index].passportInfo.countryOfIssue = value;
    travellers.refresh();
  }

  List<String> listGender = ["Male", "Female"];

  final RxString selectedGender = "Male".obs;

  void setSelectedGender(String value) {
    selectedGender.value = value;
  }

  final RxString selectedNationality = "Nationality".obs;

  List<Country> nationalitiesList = [
    new Country(worldAreaCode: null, currencyId: null, englishName: "Nationality", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

  void setSelectedNationality(String value) {
    selectedNationality.value = value;
  }

  RxList<Traveller> travellers = <Traveller>[].obs;

  void showDOCSPopup(int index) {
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
              passportTypeDropDown(index),
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
              countryOfIssueDropDown(index),
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

  Container passportTypeDropDown(int index) {
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
                setSelected(index, newValue.toString());
              },
              value: travellers[index].passportInfo.passportType == null ? "Passport Type" : travellers[index].passportInfo.passportType,
              items: listPassportType.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: Text(
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
              items: nationalitiesList.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType.englishName!,
                    ),
                    value: selectedType.englishName,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Container countryOfIssueDropDown(int index) {
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
                setSelectedCountryIssue(index, newValue.toString());
              },
              value: travellers[index].passportInfo.countryOfIssue == null ? "Country of Issue" : travellers[index].passportInfo.countryOfIssue,
              items: countryOfIssueList.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType.englishName!,
                    ),
                    value: selectedType.englishName,
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
