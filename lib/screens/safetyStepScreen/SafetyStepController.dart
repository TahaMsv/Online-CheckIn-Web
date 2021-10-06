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
