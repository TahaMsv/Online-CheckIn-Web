import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../../screens/passportStepScreen/PassportStepController.dart';
import '../../utility/DataProvider.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../global/Classes.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class VisaStepController extends MainController {
  MainModel model;

  VisaStepController(this.model);

  RxList<Traveller> travellers = <Traveller>[].obs;
  List<TextEditingController> documentNoCs = [];
  List<TextEditingController> destinationCs = [];

  RxBool isDocoNecessary = false.obs;

  void init() async {
    print("here32");
    model.setLoading(true);
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    String docsType = stepsScreenController.travellers[0].passportInfo.passportType??"";
    String docsCountry = stepsScreenController.travellers[0].passportInfo.countryOfIssue??"";
    String docsNationality = stepsScreenController.travellers[0].passportInfo.nationality??"";
    String fromCityCode = stepsScreenController.welcome!.body.flight[0].fromCity??"";
    String toCityCode = stepsScreenController.welcome!.body.flight[0].toCity??"";
    print("DocsType" + docsType + "\nDocsCountry" + docsCountry + "\nDocsNationality" + docsNationality + "\nFromCityCode" + fromCityCode + "\nToCityCode" + toCityCode);
    Response response = await DioClient.getDocumentTypes(
      execution: "[OnlineCheckin].[CheckDocoNecessity]",
      token: model.token,
      request: {
        "DocsType": docsType,
        "DocsCountry": docsCountry,
        "DocsNationality": docsNationality,
        "FromCityCode": fromCityCode,
        "ToCityCode": toCityCode,
      },
    );
    print("here50");


    if (response.statusCode == 200) {
      print("here55");
      print(jsonEncode(response.data));
      if (response.data["ResultCode"] == 1) {
        print("here56");
        print(response.data["Body"]["IsNecessary"] );
        if (response.data["Body"]["IsNecessary"] == 1) {
          print("here57");
          isDocoNecessary.value = true;

        }
      }
    } else {}

    if (isDocoNecessary.value) {
      travellersList();

      travellers = stepsScreenController.travellers;
      for (var i = 0; i < travellers.length; ++i) {
        documentNoCs.add(new TextEditingController());
        destinationCs.add(new TextEditingController());
      }
    }
    model.setLoading(false);
  }

  void close() async{
    await saveDocoDoca();
   await saveDocsDocoDoca();
  }

  Future<void> saveDocoDoca() async {

  }

  Future<void> saveDocsDocoDoca() async {

  }

  void travellersList() {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    travellers = stepsScreenController.travellers;
  }

  void updateIsCompleted(int index) {
    travellers[index].visaInfo.updateIsCompleted();
  }

  void updateDocuments() {
    for (var i = 0; i < travellers.length; ++i) {
      travellers[i].visaInfo.documentNo = documentNoCs[i].text == "" ? null : documentNoCs[i].text;
      travellers[i].visaInfo.destination = destinationCs[i].text == "" ? null : destinationCs[i].text;
    }
  }

  void submitBtnFunction(int index) {
    updateDocuments();
    updateIsCompleted(index);
    travellers.refresh();
    Get.back();
  }

  void selectEntryDate(int index, DateTime date) {
    travellers[index].visaInfo.issueDate = date;
    updateIsCompleted(index);
    travellers.refresh();
  }

  //////////////////////////////

  List<VisaType> listType = [new VisaType(id: -1, shortName: "", name: "", fullName: "Type")];

  // final RxString selectedType = "Type".obs;
  void setSelected(int index, String value) {
    travellers[index].visaInfo.type = value;
    updateIsCompleted(index);
    travellers.refresh();
  }

  //////////////////////////////

  List<Country> listIssuePlace = [
    new Country(worldAreaCode: null, currencyId: null, englishName: "Place of issue", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

  // final RxString selectedPlace = "Place of issue".obs;
  void setSelectedPlace(int index, String value) {
    travellers[index].visaInfo.placeOfIssue = value;
    updateIsCompleted(index);
    travellers.refresh();
  }

  //////////////////////////////

  void showDOCOPopup(int index) {
    Get.defaultDialog(
      title: "",
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      backgroundColor: Colors.white,
      buttonColor: Colors.red,
      barrierDismissible: true,
      radius: 10,
      content: Container(
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepsScreenTitle(title: "Passport / Visa Details - Jack Taylor", description: ""),
            SizedBox(
              height: 20,
            ),
            Text(
              "A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination",
              overflow: TextOverflow.clip,
              style: TextStyle(color: Color(0xff959595), fontSize: 12),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TypeDropDown(index),
                SizedBox(
                  width: 20,
                ),
                DocumentNoWidget(documentNoC: documentNoCs[index])
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                placeOfIssueDropDown(index),
                SizedBox(
                  width: 20,
                ),
                Obx(
                  () => SelectingDateWidget(
                    hint: "Issue Date",
                    index: index,
                    updateDate: selectEntryDate,
                    currDateTime: travellers[index].visaInfo.issueDate == null ? DateTime.now() : travellers[index].visaInfo.issueDate!,
                    isCurrDateEmpty: travellers[index].visaInfo.issueDate == null ? true : false,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: UserTextInput(
                    controller: destinationCs[index],
                    hint: "Destination",
                    errorText: "",
                    isEmpty: false,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SubmitButton(
              function: () => submitBtnFunction(index),
            )
          ],
        ),
      ),
    );
  }

  Container placeOfIssueDropDown(int index) {
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
                'Place of Issue',
              ),
              onChanged: (newValue) {
                setSelectedPlace(index, newValue.toString());
              },
              value: travellers[index].visaInfo.placeOfIssue == null ? "Place of issue" : travellers[index].visaInfo.placeOfIssue,
              items: listIssuePlace.map(
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

  Container TypeDropDown(int index) {
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
              value: travellers[index].visaInfo.type == null ? "Type" : travellers[index].visaInfo.type,
              items: listType.map(
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

  @override
  void onInit() {
    print("VisaStepController Init");
    init();
    super.onInit();
  }

  @override
  void onClose() {
    print("VisaStepController Close");
    close();
    super.onClose();
  }

  @override
  void onReady() {
    print("VisaStepController Ready");
    super.onReady();
  }


}

class DocumentNoWidget extends StatelessWidget {
  const DocumentNoWidget({
    Key? key,
    required this.documentNoC,
  }) : super(key: key);

  final TextEditingController documentNoC;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: UserTextInput(
        controller: documentNoC,
        hint: "Document No.",
        errorText: "",
        isEmpty: false,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.function,
  }) : super(key: key);
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 1,
        ),
        Container(
          width: 130,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(5),
            color: Color(0xff4d6ff8),
          ),
          child: MyElevatedButton(
            height: 50,
            width: 175,
            buttonText: "Submit",
            bgColor: Colors.white,
            fgColor: Color(0xff4d6ff8),
            function: () {
              function();
            },
          ),
        ),
      ],
    );
  }
}
