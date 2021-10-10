import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class PassportStepController extends MainController {
  PassportStepController._();

  static final PassportStepController _instance = PassportStepController._();

  factory PassportStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }


  @override
  void onInit() {
    print("PassportStepController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("PassportStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("PassportStepController Ready");
    super.onReady();
  }
}
