import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  TextEditingController documentNoC = TextEditingController();
  TextEditingController destinationC = TextEditingController();

  List<String> listType = ["Type","Type1", "Type2"];

  final RxString selectedType = "Type".obs;

  void setSelected(String value) {
    selectedType.value = value;
  }

  List<String> listIssuePlace = ["Place of issue","Place1", "Place2"];

  final RxString selectedPlace = "Place of issue".obs;

  void setSelectedPlace(String value) {
    selectedPlace.value = value;
  }

  void showDOCOPopup() {
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
                TypeDropDown(),
                SizedBox(
                  width: 20,
                ),
                DocumentNoWidget(documentNoC: documentNoC)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                placeOfIssueDropDown(),
                SizedBox(
                  width: 20,
                ),
                SelectingDateWidget(hint: "Issue Date"),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: UserTextInput(
                    controller: destinationC,
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

  Container placeOfIssueDropDown() {
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
                          setSelectedPlace(newValue.toString());
                        },
                        value: selectedPlace.value,
                        items: listIssuePlace.map(
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
  Container TypeDropDown() {
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
                        value: selectedType.value,
                        items: listType.map(
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
    print("VisaStepController Init");
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
