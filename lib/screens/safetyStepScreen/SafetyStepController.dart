import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
    checkBoxesValue[index] = value;
    print(value);
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
