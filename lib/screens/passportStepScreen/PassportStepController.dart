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
import 'package:intl/intl.dart';

class PassportStepController extends MainController {
  MainModel model;

  PassportStepController(this.model);

  RxList<Traveller> travellers = <Traveller>[].obs;
  List<int> travellersIndexInMainList = [];
  List<TextEditingController> documentNoCs = [];
  List<Country> countriesList = [];

  // RxBool checkDocs = false.obs;

  void travellersList() {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    travellers = stepsScreenController.travellers;
  }

  void init() async {
    // final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    // List<Traveller> tempTravellerList = stepsScreenController.travellers;
    // for (var i = 0; i < tempTravellerList.length; ++i) {
    //   if (tempTravellerList[i].welcome!.body.flight[0].checkDocs) {
    //     travellers.add(tempTravellerList[i]);
    //     travellersIndexInMainList.add(i);
    //   }
    // }

    // if (travellers.length > 0) {
    travellersList();
    await getDocumentTypes();
    await getSelectCountries();
    // travellers = stepsScreenController.travellers;
    for (var i = 0; i < travellers.length; ++i) {
      documentNoCs.add(new TextEditingController());
      }
    // }
  }

  void close() async {
    await saveDocs();
  }

  Future<void> saveDocs() async {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    for (var i = 0; i < travellersIndexInMainList.length; ++i) {
      int mainIndex = travellersIndexInMainList[i];
      stepsScreenController.travellers[mainIndex] = travellers[i];
    }
  }

  Future<void> saveDocsDocoDoca(int index) async {
    ///Docs Information
    Traveller traveller = travellers[index];
    String docsType = traveller.passportInfo.passportType == null ? "" : traveller.passportInfo.passportType!.split("-")[0].trim();
    String docsCountry = traveller.passportInfo.countryOfIssue == null ? "" : traveller.passportInfo.countryOfIssue!.split("-")[0].trim();
    String docsNationality = traveller.passportInfo.nationality  == null ? "" : traveller.passportInfo.nationality!.split("-")[0].trim();
    String docsDocumentNumber = traveller.passportInfo.documentNo ?? "";
    final df = new DateFormat('yyyy-MM-dd');
    String docsBirthDate = traveller.passportInfo.dateOfBirth == null ? df.format(traveller.passportInfo.dateOfBirth!) : "";
    String docsExpiryDate = traveller.passportInfo.entryDate == null ? df.format(traveller.passportInfo.entryDate!) : "";

    ///Doco Information
    String docoDestination = traveller.visaInfo.destination ?? "";
    String docoDocumentNumber = traveller.visaInfo.documentNo ?? "";
    String docoType = traveller.visaInfo.type ?? "";
    String docoPlaceOfIssue = traveller.visaInfo.placeOfIssueID ?? "";
    String docoPlaceOfBirth = traveller.passportInfo.nationalityID ?? "";
    String docoIssueDate = traveller.visaInfo.issueDate == null ? df.format(traveller.visaInfo.issueDate!) : "";

    Response response = await DioClient.saveDocsDocoDoca(
      execution: "[OnlineCheckin].[SaveDocsDocoDoca]",
      token: traveller.token,
      request: {
        "PassengerId": traveller.welcome.body.passengers[0].id,
        "DocaAddress": "",
        "DocaCity": "",
        "DocaCountry": "",
        "DocaType": "",
        "DocaZipCode": "",
        "DocsCountry": docsCountry,
        "DocsNationality": docsNationality,
        "DocsBirthDate": docsBirthDate,
        "DocsExpiryDate": docsExpiryDate, // todo  is Valid?
        "DocsDocumentNumber": docsDocumentNumber,
        "DocsType": docsType,
        "DocsSecondName": traveller.welcome.body.passengers[0].lastName, // todo  is Valid?
        "DocoDestination": docoDestination,
        "DocoDocumentNumber": docoDocumentNumber,
        "DocoType": docoType,
        "DocoPlaceOfIssue": docoPlaceOfIssue,
        "DocoPlaceOfBirth": docoPlaceOfBirth, //todo  is Valid? (Docs nationality)
        "DocoIssueDate": docoIssueDate,
        "DocsTitle": traveller.welcome.body.passengers[0].title
      },
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
        int mainIndex = travellersIndexInMainList[index];
        stepsScreenController.travellers[mainIndex] = traveller;
        print("taha");
      }
    }
  }

  Future<void> getSelectCountries() async {
    Response response = await DioClient.selectCountries(
      execution: "[OnlineCheckin].[SelectCountries]",
      token: model.token,
      request: {},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        final VisaStepController visaStepController = Get.put(VisaStepController(model));
        countriesList.addAll(List<Country>.from(response.data["Body"]["Countries"].map((x) => Country.fromJson(x))));
        for (var i = 0; i < countriesList.length; ++i) {
          countryOfIssueList.add(countriesList[i]);
          nationalitiesList.add(countriesList[i]);
          visaStepController.listIssuePlace.add(countriesList[i]);
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
        listPassportType.addAll(List<PassPortType>.from(response.data["Body"]["PassportTypes"].map((x) => PassPortType.fromJson(x))));
        visaStepController.listType.addAll(List<VisaType>.from(response.data["Body"]["VisaTypes"].map((x) => VisaType.fromJson(x))));
      }
    } else {}
  }

/////////////////////////////////////////////

  List<PassPortType> listPassportType = [new PassPortType(id: -1, shortName: "", name: "", fullName: "Passport Type")];

  void updateIsCompleted(int index) {
    travellers[index].passportInfo.updateIsCompleted();
  }

  void updateDocuments() {
    for (var i = 0; i < travellers.length; ++i) {
      travellers[i].passportInfo.documentNo = documentNoCs[i].text == "" ? null : documentNoCs[i].text;
    }
  }

  void setSelected(int index, String value) {
    travellers[index].passportInfo.passportType = value;
    updateIsCompleted(index);
    travellers.refresh();
  }

/////////////////////////////////////////////

  List<Country> countryOfIssueList = [
    new Country(worldAreaCode: null, currencyId: null, englishName: "Country of Issue", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

  void setSelectedCountryIssue(int index, String value) {
    travellers[index].passportInfo.countryOfIssue = value;
    updateIsCompleted(index);
    travellers.refresh();
  }

/////////////////////////////////////////////

  List<String> listGender = ["Gender", "Male", "Female"];

  void setSelectedGender(int index, String value) {
    travellers[index].passportInfo.gender = value;
    updateIsCompleted(index);
    travellers.refresh();
  }

/////////////////////////////////////////////
  // final RxString selectedNationality = "Nationality".obs;
  List<Country> nationalitiesList = [
    new Country(worldAreaCode: null, currencyId: null, englishName: "Nationality", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

  void setSelectedNationality(int index, String value) {
    travellers[index].passportInfo.nationality = value;
    updateIsCompleted(index);
    travellers.refresh();
  }

/////////////////////////////////////////////

  void selectDateOfBirth(int index, DateTime date) {
    travellers[index].passportInfo.dateOfBirth = date;
    updateIsCompleted(index);
    travellers.refresh();
  }

  ////////////////////////////////////////////
  void selectEntryDate(int index, DateTime date) {
    travellers[index].passportInfo.entryDate = date;
    updateIsCompleted(index);
    travellers.refresh();
  }

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
                  controller: documentNoCs[index],
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
              genderDropDown(index),
              SizedBox(
                width: 20,
              ),
              countryOfIssueDropDown(index),
              SizedBox(
                width: 20,
              ),
              Obx(
                () => SelectingDateWidget(
                  hint: "Entry Date",
                  index: index,
                  updateDate: selectEntryDate,
                  currDateTime: travellers[index].passportInfo.entryDate == null ? DateTime.now() : travellers[index].passportInfo.entryDate!,
                  isCurrDateEmpty: travellers[index].passportInfo.entryDate == null ? true : false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              nationalityDropDown(index),
              SizedBox(
                width: 20,
              ),
              Obx(
                () => SelectingDateWidget(
                  hint: "Date of Birth",
                  index: index,
                  updateDate: selectDateOfBirth,
                  currDateTime: travellers[index].passportInfo.dateOfBirth == null ? DateTime.now() : travellers[index].passportInfo.dateOfBirth!,
                  isCurrDateEmpty: travellers[index].passportInfo.dateOfBirth == null ? true : false,
                ),
              ),
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
                function: () {
                  travellers.refresh();
                  updateDocuments();
                  updateIsCompleted(index);
                  saveDocsDocoDoca(index);
                  Get.back();
                },
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

  Container nationalityDropDown(int index) {
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
                setSelectedNationality(index, newValue.toString());
              },
              value: travellers[index].passportInfo.nationality == null ? "Nationality" : travellers[index].passportInfo.nationality,
              items: nationalitiesList.map(
                (selectedType) {
                  travellers[index].passportInfo.nationalityID=selectedType.id;
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

  Container genderDropDown(int index) {
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
                setSelectedGender(index, newValue.toString());
              },
              value: travellers[index].passportInfo.gender == null ? "Gender" : travellers[index].passportInfo.gender,
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
    close();
    super.onClose();
  }

  @override
  void onReady() {
    print("PassportStepController Ready");
    super.onReady();
  }
}
