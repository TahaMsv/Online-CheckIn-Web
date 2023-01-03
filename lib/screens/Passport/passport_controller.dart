import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_repository.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_state.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_view.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_document_type_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/login/login_state.dart';
import 'package:online_checkin_web_refactoring/screens/rules/rules_repository.dart';
import 'package:online_checkin_web_refactoring/screens/rules/rules_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:get/get.dart';
import '../../core/constants/my_json.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../core/utils/failure_handler.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';

class PassportController extends MainController {
  final PassportState passportState = getIt<PassportState>();
  final PassportRepository passportRepository = getIt<PassportRepository>();

  late SelectCountriesUseCase selectCountriesUseCase = SelectCountriesUseCase(repository: passportRepository);
  late SelectPassportTypesUseCase selectPassportTypesUseCase = SelectPassportTypesUseCase(repository: passportRepository);

  void travellersList() {
    final StepsState stepsState = getIt<StepsState>();
    passportState.travelers = stepsState.travelers;
  }

  void init() async {
    travellersList();
    await getDocumentTypes();
    await getSelectCountries();
    for (var i = 0; i < passportState.travelers.length; ++i) {
      passportState.documentNoCs.add(TextEditingController());
    }
  }

  void close() async {
    await saveDocs();
  }

  Future<void> saveDocs() async {
    final StepsState stepsState = getIt<StepsState>();
    for (var i = 0; i < passportState.travelersIndexInMainList.length; ++i) {
      int mainIndex = passportState.travelersIndexInMainList[i];
      stepsState.travelers[mainIndex] = passportState.travelers[i];
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
    if (!passportState.requesting) {
      passportState.setRequesting(true);

      final LoginState loginState = getIt<LoginState>();

      SelectCountriesRequest selectCountriesRequest = SelectCountriesRequest(
        "[OnlineCheckin].[SelectCountries]",
        loginState.token,
        {},
      );
      final fOrList = await selectCountriesUseCase(request: selectCountriesRequest);

      fOrList.fold((f) => FailureHandler.handle(f, retry: () => getSelectCountries()), (countriesList) async {

        countriesList.addAll(countriesList);
        for (var i = 0; i < countriesList.length; ++i) {
          passportState.countryOfIssueList.add(countriesList[i]);
          passportState.nationalitiesList.add(countriesList[i]);
          // visaStepController.listIssuePlace.add(countriesList[i]); //todo
        }
      });
    }
    passportState.setRequesting(false);
  }

  Future<void> getDocumentTypes() async {

    if (!passportState.requesting) {
      passportState.setRequesting(true);

      final LoginState loginState = getIt<LoginState>();

      SelectPassportTypesRequest selectPassportTypesRequest = SelectPassportTypesRequest(
        "[OnlineCheckin].[SelectDocumentTypes]",
        loginState.token,
        {},
      );
      final fOrList = await selectPassportTypesUseCase(request: selectPassportTypesRequest);

      fOrList.fold((f) => FailureHandler.handle(f, retry: () => getSelectCountries()), (passportTypesList) async {
        // final VisaStepController visaStepController = Get.put(VisaStepController(model));
        passportState.listPassportType.addAll(passportTypesList);
        // visaStepController.listType.addAll(List<VisaType>.from(response.data["Body"]["VisaTypes"].map((x) => VisaType.fromJson(x)))); //todo

      });
    }
    passportState.setRequesting(false);
  }

  /////////////////////////////////////////////

  void updateIsCompleted(int index) {
    passportState.travelers[index].passportInfo.updateIsCompleted();
  }

  void updateDocuments() {
    for (var i = 0; i < passportState.travelers.length; ++i) {
      passportState.travelers[i].passportInfo.documentNo = passportState.documentNoCs[i].text == "" ? null : passportState.documentNoCs[i].text;
    }
  }

  void setSelected(int index, String value) {
    passportState.travelers[index].passportInfo.passportType = value;
    updateIsCompleted(index);
    passportState.refreshTravelers();
  }

  /////////////////////////////////////////////

  void refreshList(int index) {
    updateIsCompleted(index);
    passportState.refreshTravelers();
  }

  /////////////////////////////////////////////

  void selectDateOfBirth(int index, DateTime date) {
    passportState.travelers[index].passportInfo.dateOfBirth = date;
    updateIsCompleted(index);
    passportState.refreshTravelers();
  }

  ////////////////////////////////////////////
  void selectEntryDate(int index, DateTime date) {
    passportState.travelers[index].passportInfo.entryDate = date;
    updateIsCompleted(index);
    passportState.refreshTravelers();
  }


  void showDOCSPopup(int index) {
    print("In get dialog. index: "+ index.toString());
    Get.defaultDialog(
      title: "",
      backgroundColor: MyColors.white,
      buttonColor: Colors.red,
      barrierDismissible: true,
      radius: 10,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepsScreenTitle(title: "Passport / Visa Details".tr, description: ""),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              passportTypeDropDown(index),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: UserTextInput(
                  controller: passportState.documentNoCs[index],
                  hint: "Document No.".tr,
                  errorText: "",
                  isEmpty: false,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              genderDropDown(index),
              const SizedBox(
                width: 20,
              ),
              countryOfIssueDropDown(index),
              const SizedBox(
                width: 20,
              ),
              Obx(
                () => SelectingDateWidget(
                  hint: "Entry Date".tr,
                  index: index,
                  updateDate: selectEntryDate,
                  currDateTime: passportState.travelers[index].passportInfo.entryDate == null ? DateTime.now() : passportState.travelers[index].passportInfo.entryDate!,
                  isCurrDateEmpty: passportState.travelers[index].passportInfo.entryDate == null ? true : false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              nationalityDropDown(index),
              const SizedBox(
                width: 20,
              ),
              Obx(
                () => SelectingDateWidget(
                  hint: "Date of Birth".tr,
                  index: index,
                  updateDate: selectDateOfBirth,
                  currDateTime: passportState.travelers[index].passportInfo.dateOfBirth == null ? DateTime.now() : passportState.travelers[index].passportInfo.dateOfBirth!,
                  isCurrDateEmpty: passportState.travelers[index].passportInfo.dateOfBirth == null ? true : false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 1,
              ),
              MyElevatedButton(
                height: 50,
                width: 175,
                buttonText: "Submit".tr,
                bgColor: MyColors.white,
                fgColor: const Color(0xff4d6ff8),
                function: passportState.requesting
                    ? () {}
                    : () {
                        // VisaStepController visaStepController = Get.put(VisaStepController(model));
                        passportState.refreshTravelers();
                        updateDocuments();
                        updateIsCompleted(index);
                        // saveDocsDocoDoca(index);
                        // visaStepController.checkDocoNecessity(passportState.travelers[index]); //todo
                        Get.back();
                      },
              ),
            ],
          )
        ],
      ),
    );
  }

  void showBottomSheetForm(BuildContext context, int index) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: Get.height * 0.7,
        child: Center(
          child: SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepsScreenTitle(
                    title: "Passport / Visa Details".tr,
                    description: "",
                    fontSize: 25,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  passportTypeDropDown(index, width: Get.width, height: 80),
                  const SizedBox(
                    height: 20,
                  ),
                  UserTextInput(
                    controller: passportState.documentNoCs[index],
                    hint: "Document No.".tr,
                    errorText: "",
                    isEmpty: false,
                    height: 80,
                    width: Get.width,
                    fontSize: 25,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      genderDropDown(index, height: 80, width: Get.width * 0.3),
                      const SizedBox(
                        width: 20,
                      ),
                      countryOfIssueDropDown(index, height: 80, width: Get.width * 0.5),
                    ],
                  ),
                  const SizedBox(
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
                      currDateTime: passportState.travelers[index].passportInfo.entryDate == null ? DateTime.now() : passportState.travelers[index].passportInfo.entryDate!,
                      isCurrDateEmpty: passportState.travelers[index].passportInfo.entryDate == null ? true : false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  nationalityDropDown(index, height: 80, width: Get.width),
                  const SizedBox(
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
                      currDateTime: passportState.travelers[index].passportInfo.dateOfBirth == null ? DateTime.now() : passportState.travelers[index].passportInfo.dateOfBirth!,
                      isCurrDateEmpty: passportState.travelers[index].passportInfo.dateOfBirth == null ? true : false,
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
                  //         currDateTime: passportState.travelers[index].passportInfo.dateOfBirth == null ? DateTime.now() : travellers[index].passportInfo.dateOfBirth!,
                  //         isCurrDateEmpty: travellers[index].passportInfo.dateOfBirth == null ? true : false,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 1,
                      ),
                      MyElevatedButton(
                        height: 70,
                        width: 200,
                        buttonText: "Submit".tr,
                        bgColor: MyColors.white,
                        fgColor: const Color(0xff4d6ff8),
                        fontSize: 23,
                        borderColor: Colors.blue,
                        function: passportState.requesting
                            ? () {}
                            : () {
                                passportState.refreshTravelers();
                                updateDocuments();
                                updateIsCompleted(index);
                                // saveDocsDocoDoca(index);
                                // visaStepController.checkDocoNecessity(passportState.travelers[index]); //todo
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
  void onCreate() {
    init();
  }
}
