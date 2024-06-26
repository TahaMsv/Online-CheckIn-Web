import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
import 'package:onlinecheckin/screens/visaStepScreen/VisaStepController.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import 'package:onlinecheckin/utility/DataProvider.dart';
import '../../global/Classes.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PassportStepController extends MainController {
  MainModel model;

  PassportStepController(this.model);

  RxList<Traveller> travellers = <Traveller>[].obs;
  List<int> travellersIndexInMainList = [];
  List<TextEditingController> documentNoCs = [];
  List<Country> countriesList = [];

  void travellersList() {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    travellers = stepsScreenController.travellers;
  }

  void init() async {
    travellersList();
    await getDocumentTypes();
    await getSelectCountries();
    for (var i = 0; i < travellers.length; ++i) {
      documentNoCs.add(new TextEditingController());
    }
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

  // Future<void> saveDocsDocoDoca(int index) async {
  //   ///Docs Information
  //   Traveller traveller = travellers[index];
  //   String docsType = traveller.passportInfo.passportType == null ? "" : traveller.passportInfo.passportType!.split("-")[0].trim();
  //   String docsCountry = traveller.passportInfo.countryOfIssue == null ? "" : traveller.passportInfo.countryOfIssue!.split("-")[0].trim();
  //   String docsNationality = traveller.passportInfo.nationality == null ? "" : traveller.passportInfo.nationality!.split("-")[0].trim();
  //   String docsDocumentNumber = traveller.passportInfo.documentNo ?? "";
  //   final df = new DateFormat('yyyy-MM-dd');
  //   String docsBirthDate = traveller.passportInfo.dateOfBirth == null ? df.format(traveller.passportInfo.dateOfBirth!) : "";
  //   String docsExpiryDate = traveller.passportInfo.entryDate == null ? df.format(traveller.passportInfo.entryDate!) : "";
  //
  //   ///Doco Information
  //   String docoDestination = traveller.visaInfo.destination ?? "";
  //   String docoDocumentNumber = traveller.visaInfo.documentNo ?? "";
  //   String docoType = traveller.visaInfo.type ?? "";
  //   String docoPlaceOfIssue = traveller.visaInfo.placeOfIssueID ?? "";
  //   String docoPlaceOfBirth = traveller.passportInfo.nationalityID ?? "";
  //   String docoIssueDate = traveller.visaInfo.issueDate == null ? df.format(traveller.visaInfo.issueDate!) : "";
  //   if (!model.requesting) {
  //     model.setRequesting(true);
  //     Response response = await DioClient.saveDocsDocoDoca(
  //       execution: "[OnlineCheckin].[SaveDocsDocoDoca]",
  //       token: traveller.token,
  //       request: {
  //         "PassengerId": traveller.welcome.body.passengers[0].id,
  //         "DocaAddress": "",
  //         "DocaCity": "",
  //         "DocaCountry": "",
  //         "DocaType": "",
  //         "DocaZipCode": "",
  //         "DocsCountry": docsCountry,
  //         "DocsNationality": docsNationality,
  //         "DocsBirthDate": docsBirthDate,
  //         "DocsExpiryDate": docsExpiryDate, // todo  is Valid?
  //         "DocsDocumentNumber": docsDocumentNumber,
  //         "DocsType": docsType,
  //         "DocsSecondName": traveller.welcome.body.passengers[0].lastName, // todo  is Valid?
  //         "DocoDestination": docoDestination,
  //         "DocoDocumentNumber": docoDocumentNumber,
  //         "DocoType": docoType,
  //         "DocoPlaceOfIssue": docoPlaceOfIssue,
  //         "DocoPlaceOfBirth": docoPlaceOfBirth, //todo  is Valid? (Docs nationality)
  //         "DocoIssueDate": docoIssueDate,
  //         "DocsTitle": traveller.welcome.body.passengers[0].title
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       if (response.data["ResultCode"] == 1) {
  //         final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
  //         int mainIndex = travellersIndexInMainList[index];
  //         stepsScreenController.travellers[mainIndex] = traveller;
  //       }
  //     }
  //   }
  //   model.setRequesting(false);
  // }

  Future<void> getSelectCountries() async {
    if (!model.requesting) {
      model.setRequesting(true);
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
      }
    }
    model.setRequesting(false);
  }

  Future<void> getDocumentTypes() async {
    if (!model.requesting) {
      model.setRequesting(true);
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
      }
    }
    model.setRequesting(false);
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

/////////////////////////////////////////////

  List<String> listGender = ["Gender", "Male", "Female"];

  void refreshList(int index) {
    updateIsCompleted(index);
    travellers.refresh();
  }

/////////////////////////////////////////////
  // final RxString selectedNationality = "Nationality".obs;
  List<Country> nationalitiesList = [
    new Country(worldAreaCode: null, currencyId: null, englishName: "Nationality", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

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

  String getKeyFromLanguageWords(Locale locale, String value) {
    String languageKey = locale.languageCode + "_" + locale.countryCode.toString();
    var map = TranslatedWords().keys[languageKey];
    String key = map!.keys.firstWhere((k) => map[k] == value, orElse: () => "");
    return key == "" ? value : key;
  }

  void showDOCSPopup(int index) {
    Locale locale = Get.locale!;
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.white,
      buttonColor: Colors.red,
      barrierDismissible: true,
      radius: 10,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(title: "Passport / Visa Details".tr, description: ""),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              passportTypeDropDown(index, locale),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: UserTextInput(
                  controller: documentNoCs[index],
                  hint: "Document No.".tr,
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
              genderDropDown(index, locale),
              SizedBox(
                width: 20,
              ),
              countryOfIssueDropDown(index, locale),
              SizedBox(
                width: 20,
              ),
              Obx(
                () => SelectingDateWidget(
                  hint: "Entry Date".tr,
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
              nationalityDropDown(index, locale),
              SizedBox(
                width: 20,
              ),
              Obx(
                () => SelectingDateWidget(
                  hint: "Date of Birth".tr,
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
                buttonText: "Submit".tr,
                bgColor: Colors.white,
                fgColor: Color(0xff4d6ff8),
                function: model.requesting
                    ? () {}
                    : () {
                        VisaStepController visaStepController = Get.put(VisaStepController(model));
                        travellers.refresh();
                        updateDocuments();
                        updateIsCompleted(index);
                        // saveDocsDocoDoca(index);
                        visaStepController.checkDocoNecessity(travellers[index]);
                        Get.back();
                      },
              ),
            ],
          )
        ],
      ),
    );
  }

  Container passportTypeDropDown(int index, Locale locale, {double width = 400, double height = 40}) {
    return Container(
      height: height,
      width: width,
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
              // hint: Text(
              //   'Type',
              // ),
              onChanged: (newValue) {
                travellers[index].passportInfo.passportType = getKeyFromLanguageWords(locale, newValue.toString());
                refreshList(index);
              },
              value: travellers[index].passportInfo.passportType == null || travellers[index].passportInfo.passportType == "Passport Type"
                  ? "Passport Type".tr
                  : travellers[index].passportInfo.passportType,
              items: listPassportType.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: Text(
                      selectedType.fullName == "Passport Type" ? "Passport Type".tr : selectedType.fullName,
                      style: TextStyle(fontSize: 25),
                    ),
                    value: selectedType.fullName == "Passport Type" ? "Passport Type".tr : selectedType.fullName,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Container nationalityDropDown(int index, Locale locale, {double width = 400, double height = 40}) {
    return Container(
      height: height,
      width: width,
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
                style: TextStyle(fontSize: 25),
              ),
              onChanged: (newValue) {
                travellers[index].passportInfo.nationality = getKeyFromLanguageWords(locale, newValue.toString());
                refreshList(index);
              },
              value: travellers[index].passportInfo.nationality == null || travellers[index].passportInfo.nationality == "Nationality" ? "Nationality".tr : travellers[index].passportInfo.nationality,
              items: nationalitiesList.map(
                (selectedType) {
                  travellers[index].passportInfo.nationalityID = selectedType.id;
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType.englishName! == "Nationality" ? ("Nationality".tr) : selectedType.englishName!,
                      style: TextStyle(fontSize: 25),
                    ),
                    value: selectedType.englishName! == "Nationality" ? ("Nationality".tr) : selectedType.englishName!,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Container countryOfIssueDropDown(int index, Locale locale, {double width = 200, double height = 40}) {
    return Container(
      height: height,
      width: width,
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
              // hint: Text(
              //   'Country of Issue'.tr,
              // ),
              onChanged: (newValue) {
                travellers[index].passportInfo.countryOfIssue = getKeyFromLanguageWords(locale, newValue.toString());
                refreshList(index);
              },
              value: travellers[index].passportInfo.countryOfIssue == null || travellers[index].passportInfo.countryOfIssue == "Country of Issue"
                  ? "Country of Issue".tr
                  : travellers[index].passportInfo.countryOfIssue,
              items: countryOfIssueList.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType.englishName! == "Country of Issue" ? ("Country of Issue".tr) : selectedType.englishName!,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: selectedType.englishName! == "Country of Issue" ? ("Country of Issue".tr) : selectedType.englishName!,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Container genderDropDown(int index, Locale locale, {double width = 200, double height = 40}) {
    return Container(
      height: height,
      width: width,
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
              // hint: Text(
              //   'Gender'.tr,
              // ),
              onChanged: (newValue) {
                travellers[index].passportInfo.gender = getKeyFromLanguageWords(locale, newValue.toString());
                refreshList(index);
              },
              value: travellers[index].passportInfo.gender == null || travellers[index].passportInfo.gender == "Gender" ? "Gender".tr : travellers[index].passportInfo.gender!.tr,
              items: listGender.map(
                (selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType.tr == "Gender" ? "Gender".tr : selectedType.tr,
                      style: TextStyle(fontSize: 20),
                    ),
                    value: selectedType.tr == "Gender" ? "Gender".tr : selectedType.tr,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetForm(BuildContext context, int index) {
    Locale locale = Get.locale!;
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: Get.height * 0.7,
        child: Center(
          child: SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepsScreenTitle(
                    title: "Passport / Visa Details".tr,
                    description: "",
                    fontSize: 25,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  passportTypeDropDown(index, locale, width: Get.width, height: 80),
                  SizedBox(
                    height: 20,
                  ),
                  UserTextInput(
                    controller: documentNoCs[index],
                    hint: "Document No.".tr,
                    errorText: "",
                    isEmpty: false,
                    height: 80,
                    width: Get.width,
                    fontSize: 25,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      genderDropDown(index, locale, height: 80, width: Get.width * 0.3),
                      SizedBox(
                        width: 20,
                      ),
                      countryOfIssueDropDown(index, locale, height: 80, width: Get.width * 0.5),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => SelectingDateWidget(
                      height: 80,
                      width: Get.width,
                      fontSize: 22,
                      hint: "Entry Date".tr,
                      index: index,
                      updateDate: selectEntryDate,
                      currDateTime: travellers[index].passportInfo.entryDate == null ? DateTime.now() : travellers[index].passportInfo.entryDate!,
                      isCurrDateEmpty: travellers[index].passportInfo.entryDate == null ? true : false,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  nationalityDropDown(index, locale, height: 80, width: Get.width),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => SelectingDateWidget(
                      height: 80,
                      width: Get.width,
                      fontSize: 22,
                      hint: "Date of Birth".tr,
                      index: index,
                      updateDate: selectDateOfBirth,
                      currDateTime: travellers[index].passportInfo.dateOfBirth == null ? DateTime.now() : travellers[index].passportInfo.dateOfBirth!,
                      isCurrDateEmpty: travellers[index].passportInfo.dateOfBirth == null ? true : false,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Obx(
                  //       () => SelectingDateWidget(
                  //         hint: "Date of Birth".tr,
                  //         index: index,
                  //         updateDate: selectDateOfBirth,
                  //         currDateTime: travellers[index].passportInfo.dateOfBirth == null ? DateTime.now() : travellers[index].passportInfo.dateOfBirth!,
                  //         isCurrDateEmpty: travellers[index].passportInfo.dateOfBirth == null ? true : false,
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                        height: 70,
                        width: 200,
                        buttonText: "Submit".tr,
                        bgColor: Colors.white,
                        fgColor: Color(0xff4d6ff8),
                        function: model.requesting
                            ? () {}
                            : () {
                                VisaStepController visaStepController = Get.put(VisaStepController(model));
                                travellers.refresh();
                                updateDocuments();
                                updateIsCompleted(index);
                                // saveDocsDocoDoca(index);
                                visaStepController.checkDocoNecessity(travellers[index]);
                                Get.back();
                              },
                      ),
                    ],
                  )
                ],
              ),
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
