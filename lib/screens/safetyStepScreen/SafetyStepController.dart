import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class SafetyStepScreenController extends MainController {
  SafetyStepScreenController._();

  static final SafetyStepScreenController _instance = SafetyStepScreenController._();

  factory SafetyStepScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  RxList<bool> checkBoxesValue = <bool>[false, false, false].obs;

  changeValue(int index, bool value) {
    final myStepScreenController = Get.put(StepsScreenController(model));
    checkBoxesValue[index] = value;
    myStepScreenController.updateIsNextButtonDisable();
  }

  bool checkValidation() {
    for (int i = 0; i < checkBoxesValue.length; i++) {
      if (checkBoxesValue[i] == false) return false;
    }
    return true;
  }

  @override
  void onInit() {
    print("SafetyStepScreenController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("SafetyStepScreenController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("SafetyStepScreenController Ready");
    super.onReady();
  }
}
