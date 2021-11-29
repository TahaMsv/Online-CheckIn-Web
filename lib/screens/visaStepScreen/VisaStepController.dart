import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinecheckin/screens/passportStepScreen/PassportStepController.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../global/Classes.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class VisaStepController extends MainController {
  VisaStepController._();

  static final VisaStepController _instance = VisaStepController._();

  factory VisaStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  RxList<Traveller> travellers = <Traveller>[].obs;
  List<TextEditingController> documentNoCs = [];
  List<TextEditingController> destinationCs = [];

  void init() async {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    final PassportStepController passportStepController = Get.put(PassportStepController(model));
    travellers = stepsScreenController.travellers;
    for (var i = 0; i < travellers.length; ++i) {
      documentNoCs.add(new TextEditingController());
      destinationCs.add(new TextEditingController());
    }
  }

  List<Traveller> travellersList() {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    return stepsScreenController.travellers;
  }

  //////////////////////////////

  List<VisaType> listType = [new VisaType(id: -1, shortName: "", name: "", fullName: "Type")];
  // final RxString selectedType = "Type".obs;
  void setSelected(int index, String value) {
    travellers[index].visaInfo.type = value;
    travellers.refresh();
  }

  //////////////////////////////

  List<Country> listIssuePlace = [
    new Country(worldAreaCode: null, currencyId: null, englishName: "Place of issue", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];
  // final RxString selectedPlace = "Place of issue".obs;
  void setSelectedPlace(int index, String value) {
    travellers[index].visaInfo.placeOfIssue = value;
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
                // SelectingDateWidget(hint: "Issue Date"),
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
            SubmitButton()
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
  }) : super(key: key);

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
            function: () {},
          ),
        ),
      ],
    );
  }
}
