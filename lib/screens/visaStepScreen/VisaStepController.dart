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

  List<String> listType = ["Type1", "Type2"];

  final RxString selectedType = "Type1".obs;

  void setSelected(String value) {
    selectedType.value = value;
  }

  List<String> listIssuePlace = ["Place1", "Place2"];

  final RxString selectedPlace = "Place1".obs;

  void setSelectedPlace(String value) {
    selectedPlace.value = value;
  }

  void showDOCOPopup() {
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
              Container(
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
                    child: DropdownButton(
                      hint: Text(
                        'Type',
                      ),
                      onChanged: (newValue) {
                        setSelected(newValue.toString());
                      },
                      value: selectedType.value,
                      items:listType.map(
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
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: UserTextInput(
                  controller: documentNoC,
                  hint: "Document No.",
                  errorText: "",
                  isEmpty: true,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
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
                    child: DropdownButton(
                      hint: Text(
                        'Place of Issue',
                      ),
                      onChanged: (newValue) {
                        setSelectedPlace(newValue.toString());
                      },
                      value:selectedPlace.value,
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
              SizedBox(
                width: 20,
              ),
              SelectingDateWidget(hint:"Issue Date"),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: UserTextInput(
                  controller: destinationC,
                  hint: "Destination",
                  errorText: "",
                  isEmpty: true,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 1,),
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
