import 'package:flutter/material.dart';
import 'package:online_check_in/screens/Passport/passport_repository.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';

import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/drop_down_utils.dart';
import '../../core/utils/failure_handler.dart';
import '../../core/utils/getTranslatedWord.dart';
import '../../widgets/MyDropDown.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';
import 'dialogs/passport_details_dialog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    passportState.setLoading(true);
    if (!passportState.passportTypeInit) {
      travellersList();
      await getPassportTypes();
    }

    if (!passportState.getCountriesInit) {
      await getSelectCountries();
      for (var i = 0; i < passportState.travelers.length; ++i) {
        passportState.documentNoCs.add(TextEditingController());
      }
    }
    print("done");
    passportState.setLoading(false);
  }

  // void close() async {
  //   await saveDocs();
  // }
  //
  // Future<void> saveDocs() async {
  //   final StepsState stepsState = getIt<StepsState>();
  //   for (var i = 0; i < passportState.travelersIndexInMainList.length; ++i) {
  //     int mainIndex = passportState.travelersIndexInMainList[i];
  //     stepsState.travelers[mainIndex] = passportState.travelers[i];
  //   }
  // }

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
    SelectCountriesRequest selectCountriesRequest = SelectCountriesRequest();
    final fOrList = await selectCountriesUseCase(request: selectCountriesRequest);

    fOrList.fold((f) => FailureHandler.handle(f, retry: () => getSelectCountries()), (countriesList) async {
      passportState.countryOfIssueList.addAll(countriesList);
      passportState.nationalitiesList.addAll(countriesList);
      VisaState visaState = getIt<VisaState>();
      visaState.listIssuePlace.addAll(countriesList);
      passportState.setGetCountriesInit(true);
      print("Done with get countries");
    });
  }

  Future<void> getPassportTypes() async {
    SelectPassportTypesRequest selectPassportTypesRequest = SelectPassportTypesRequest();
    final fOrList = await selectPassportTypesUseCase(request: selectPassportTypesRequest);

    fOrList.fold((f) => FailureHandler.handle(f, retry: () => getSelectCountries()), (passportTypesList) async {
      passportState.listPassportType.addAll(passportTypesList);
      passportState.setPassportTypeInit(true);
      print("Done with get passport");
    });
  }

  void updateDocuments() {
    for (var i = 0; i < passportState.travelers.length; ++i) {
      passportState.travelers[i].passportInfo.documentNo = passportState.documentNoCs[i].text == "" ? null : passportState.documentNoCs[i].text;
    }
  }

  void setSelected(int index, String value) {
    passportState.travelers[index].passportInfo.passportType = value;
    passportState.setState();
  }

  void selectDateOfBirth(int index, DateTime date) {
    passportState.travelers[index].passportInfo.dateOfBirth = date;
    passportState.setState();
  }

  void selectEntryDate(int index, DateTime date) {
    passportState.travelers[index].passportInfo.entryDate = date;
    passportState.setState();
  }

  // void showDOCSPopup(BuildContext context, int index) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => Dialog(
  //             backgroundColor: MyColors.white,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 StepsScreenTitle(title: "Passport / Visa Details".tr, description: ""),
  //                 const SizedBox(height: 20),
  //                 Row(
  //                   children: [
  //                     DropDown(index: index, hintText: passportState.passportType),
  //                     const SizedBox(width: 20),
  //                     Expanded(
  //                       child: UserTextInput(controller: passportState.documentNoCs[index], hint: "Document No.".tr, errorText: "", isEmpty: false),
  //                     )
  //                   ],
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Row(
  //                   children: [
  //                     DropDown(index: index, hintText: passportState.gender),
  //                     const SizedBox(width: 20),
  //                     DropDown(index: index, hintText: passportState.countryOfIssueType),
  //                     const SizedBox(width: 20),
  //                     SelectingDateWidget(
  //                       hint: "Entry Date".tr,
  //                       index: index,
  //                       updateDate: selectEntryDate,
  //                       currDateTime: passportState.travelers[index].passportInfo.entryDate == null ? DateTime.now() : passportState.travelers[index].passportInfo.entryDate!,
  //                       isCurrDateEmpty: passportState.travelers[index].passportInfo.entryDate == null ? true : false,
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Row(
  //                   children: [
  //                     DropDown(index: index, hintText: passportState.nationalityType),
  //                     const SizedBox(width: 20),
  //                     SelectingDateWidget(
  //                       hint: "Date of Birth".tr,
  //                       index: index,
  //                       updateDate: selectDateOfBirth,
  //                       currDateTime: passportState.travelers[index].passportInfo.dateOfBirth == null ? DateTime.now() : passportState.travelers[index].passportInfo.dateOfBirth!,
  //                       isCurrDateEmpty: passportState.travelers[index].passportInfo.dateOfBirth == null ? true : false,
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const SizedBox(width: 1),
  //                     MyElevatedButton(
  //                       height: 50,
  //                       width: 175,
  //                       buttonText: "Submit".tr,
  //                       bgColor: MyColors.white,
  //                       fgColor: MyColors.myBlue,
  //                       function: passportState.requesting
  //                           ? () {}
  //                           : () {
  //                               // VisaStepController visaStepController = Get.put(VisaStepController(model));
  //                               passportState.refreshTravelers();
  //                               updateDocuments();
  //
  //                               // saveDocsDocoDoca(index);
  //                               // visaStepController.checkDocoNecessity(passportState.travelers[index]); //todo
  //                               Get.back();
  //                             },
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ));
  //   // print("In get dialog. index: " + index.toString());
  //   // Get.defaultDialog(
  //   //   title: "",
  //   //   backgroundColor: MyColors.white,
  //   //   buttonColor: MyColors.red,
  //   //   barrierDismissible: true,
  //   //   radius: 10,
  //   //   content: Column(
  //   //     crossAxisAlignment: CrossAxisAlignment.start,
  //   //     children: [
  //   //       StepsScreenTitle(title: "Passport / Visa Details".tr, description: ""),
  //   //       const SizedBox(height: 20),
  //   //       Row(
  //   //         children: [
  //   //           DropDown(index: index, hintText: passportState.passportType),
  //   //           const SizedBox(width: 20),
  //   //           Expanded(
  //   //             child: UserTextInput(controller: passportState.documentNoCs[index], hint: "Document No.".tr, errorText: "", isEmpty: false),
  //   //           )
  //   //         ],
  //   //       ),
  //   //       const SizedBox(height: 20),
  //   //       Row(
  //   //         children: [
  //   //           DropDown(index: index, hintText: passportState.gender),
  //   //           const SizedBox(width: 20),
  //   //           DropDown(index: index, hintText: passportState.countryOfIssueType),
  //   //           const SizedBox(width: 20),
  //   //           SelectingDateWidget(
  //   //             hint: "Entry Date".tr,
  //   //             index: index,
  //   //             updateDate: selectEntryDate,
  //   //             currDateTime: passportState.travelers[index].passportInfo.entryDate == null ? DateTime.now() : passportState.travelers[index].passportInfo.entryDate!,
  //   //             isCurrDateEmpty: passportState.travelers[index].passportInfo.entryDate == null ? true : false,
  //   //           ),
  //   //         ],
  //   //       ),
  //   //       const SizedBox(height: 20),
  //   //       Row(
  //   //         children: [
  //   //           DropDown(index: index, hintText: passportState.nationalityType),
  //   //           const SizedBox(width: 20),
  //   //           SelectingDateWidget(
  //   //             hint: "Date of Birth".tr,
  //   //             index: index,
  //   //             updateDate: selectDateOfBirth,
  //   //             currDateTime: passportState.travelers[index].passportInfo.dateOfBirth == null ? DateTime.now() : passportState.travelers[index].passportInfo.dateOfBirth!,
  //   //             isCurrDateEmpty: passportState.travelers[index].passportInfo.dateOfBirth == null ? true : false,
  //   //           ),
  //   //         ],
  //   //       ),
  //   //       const SizedBox(height: 20),
  //   //       Row(
  //   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //         children: [
  //   //           const SizedBox(width: 1),
  //   //           MyElevatedButton(
  //   //             height: 50,
  //   //             width: 175,
  //   //             buttonText: "Submit".tr,
  //   //             bgColor: MyColors.white,
  //   //             fgColor: MyColors.myBlue,
  //   //             function: passportState.requesting
  //   //                 ? () {}
  //   //                 : () {
  //   //                     // VisaStepController visaStepController = Get.put(VisaStepController(model));
  //   //                     passportState.refreshTravelers();
  //   //                     updateDocuments();
  //   //
  //   //                     // saveDocsDocoDoca(index);
  //   //                     // visaStepController.checkDocoNecessity(passportState.travelers[index]); //todo
  //   //                     Get.back();
  //   //                   },
  //   //           ),
  //   //         ],
  //   //       )
  //   //     ],
  //   //   ),
  //   // );
  // }

  void showPassportDialog(int index) {
    nav.dialog(PassportDialog(index: index));
  }

  void showBottomSheetForm(BuildContext context, double height, double width, int index) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => SizedBox(
        height: height * 0.7,
        child: Center(
          child: SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepsScreenTitle(title: "Passport / Visa Details", description: "", fontSize: 25),
                  const SizedBox(height: 20),
                  MyDropDown(
                    index: index,
                    hintText: DropDownUtils.passportType,
                    width: width,
                    height: 80,
                    passOrVisa: DropDownUtils.passport,
                  ),
                  const SizedBox(height: 20),
                  UserTextInput(controller: passportState.documentNoCs[index], hint: "Document No.", errorText: "", isEmpty: false, height: 80, width: width, fontSize: 25),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyDropDown(
                        index: index,
                        hintText: DropDownUtils.gender,
                        width: width * 0.2,
                        height: 80,
                        passOrVisa: DropDownUtils.passport,
                      ),
                      const SizedBox(width: 20),
                      MyDropDown(
                        index: index,
                        hintText: DropDownUtils.countryOfIssueType,
                        width: width * 0.5,
                        height: 80,
                        passOrVisa: DropDownUtils.passport,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SelectingDateWidget(
                    height: 80,
                    width: width,
                    fontSize: 22,
                    hint: "Entry Date",
                    index: index,
                    updateDate: selectEntryDate,
                    currDateTime: passportState.travelers[index].passportInfo.entryDate == null ? DateTime.now() : passportState.travelers[index].passportInfo.entryDate!,
                    isCurrDateEmpty: passportState.travelers[index].passportInfo.entryDate == null ? true : false,
                  ),
                  const SizedBox(height: 20),
                  MyDropDown(
                    index: index,
                    hintText: DropDownUtils.nationalityType,
                    width: width,
                    height: 80,
                    passOrVisa: DropDownUtils.passport,
                  ),
                  const SizedBox(height: 20),
                  SelectingDateWidget(
                    height: 80,
                    width: width,
                    fontSize: 22,
                    hint: "Date of Birth",
                    index: index,
                    updateDate: selectDateOfBirth,
                    currDateTime: passportState.travelers[index].passportInfo.dateOfBirth == null ? DateTime.now() : passportState.travelers[index].passportInfo.dateOfBirth!,
                    isCurrDateEmpty: passportState.travelers[index].passportInfo.dateOfBirth == null ? true : false,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 1),
                      MyElevatedButton(
                        height: 70,
                        width: 200,
                        buttonText: "Submit",
                        bgColor: MyColors.white,
                        fgColor: MyColors.myBlue,
                        fontSize: 23,
                        borderColor: Colors.blue,
                        function: passportState.loading
                            ? () {}
                            : () {
                                passportState.setState();
                                updateDocuments();
                                Navigator.pop(context);
                                // saveDocsDocoDoca(index);
                                // visaStepController.checkDocoNecessity(passportState.travelers[index]); //todo
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

  String? getValueByType({required String type, required int index}) {
    String? returnValue;
    if (type == DropDownUtils.passportType) {
      returnValue = passportState.travelers[index].passportInfo.passportType == null || passportState.travelers[index].passportInfo.passportType == DropDownUtils.passportType
          ? DropDownUtils.passportType
          : passportState.travelers[index].passportInfo.passportType;
    } else if (type == DropDownUtils.nationalityType) {
      returnValue = passportState.travelers[index].passportInfo.nationality == null || passportState.travelers[index].passportInfo.nationality == DropDownUtils.nationalityType
          ? DropDownUtils.nationalityType
          : passportState.travelers[index].passportInfo.nationality;
    } else if (type == DropDownUtils.countryOfIssueType) {
      returnValue = passportState.travelers[index].passportInfo.countryOfIssue == null || passportState.travelers[index].passportInfo.countryOfIssue == DropDownUtils.countryOfIssueType
          ? DropDownUtils.countryOfIssueType
          : passportState.travelers[index].passportInfo.countryOfIssue;
    } else if (type == DropDownUtils.gender) {
      returnValue = passportState.travelers[index].passportInfo.gender == null || passportState.travelers[index].passportInfo.gender == DropDownUtils.gender
          ? DropDownUtils.gender
          : passportState.travelers[index].passportInfo.gender!;
    }

    return returnValue;
  }

  void getOnChangedValueByType({required String type, required dynamic newValue, required int index}) {
    String translatedWord = getKeyFromLanguageWords(newValue.toString());
    if (type == DropDownUtils.passportType) {
      print(passportState.travelers[index].passportInfo.passportType);
      passportState.travelers[index].passportInfo.passportType = translatedWord;
      print(passportState.travelers[index].passportInfo.passportType);
    } else if (type == DropDownUtils.nationalityType) {
      print(passportState.travelers[index].passportInfo.nationality);
      passportState.travelers[index].passportInfo.nationality = translatedWord;
      print(passportState.travelers[index].passportInfo.nationality);
    } else if (type == DropDownUtils.countryOfIssueType) {
      print(passportState.travelers[index].passportInfo.countryOfIssue);
      passportState.travelers[index].passportInfo.countryOfIssue = translatedWord;
      print(passportState.travelers[index].passportInfo.countryOfIssue);
    } else if (type == DropDownUtils.gender) {
      print(passportState.travelers[index].passportInfo.gender);
      passportState.travelers[index].passportInfo.gender = translatedWord;
      print(passportState.travelers[index].passportInfo.gender);
    }
    passportState.setState();
  }

  String? getDropdownMenuItemValue({required String type, required dynamic selectedType, required int index}) {
    String? returnedValue;

    if (type == DropDownUtils.passportType) {
      returnedValue = selectedType.fullName == DropDownUtils.passportType ? DropDownUtils.passportType : selectedType.fullName;
    } else if (type == DropDownUtils.nationalityType) {
      returnedValue = selectedType.englishName! == DropDownUtils.nationalityType ? (DropDownUtils.nationalityType) : selectedType.englishName!;
    } else if (type == DropDownUtils.countryOfIssueType) {
      returnedValue = selectedType.englishName! == DropDownUtils.countryOfIssueType ? (DropDownUtils.countryOfIssueType) : selectedType.englishName!;
    } else if (type == DropDownUtils.gender) {
      returnedValue = selectedType == DropDownUtils.gender ? DropDownUtils.gender : selectedType;
    }
    return returnedValue;
  }

  String? getDropdownMenuItemText({required String type, required dynamic selectedType, required int index}) {
    String? returnedValue;

    if (type == DropDownUtils.passportType) {
      returnedValue = selectedType.fullName == DropDownUtils.passportType ? DropDownUtils.passportType : selectedType.fullName;
    } else if (type == DropDownUtils.nationalityType) {
      returnedValue = selectedType.englishName! == DropDownUtils.nationalityType ? (DropDownUtils.nationalityType) : selectedType.englishName!;
    } else if (type == DropDownUtils.countryOfIssueType) {
      returnedValue = selectedType.englishName! == DropDownUtils.countryOfIssueType ? (DropDownUtils.countryOfIssueType) : selectedType.englishName!;
    } else if (type == DropDownUtils.gender) {
      returnedValue = selectedType == DropDownUtils.gender ? DropDownUtils.gender : selectedType;
    }
    return returnedValue;
  }

  // @override
  // void onCreate() {
  //   // init();
  //   super.onCreate();
  // }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
