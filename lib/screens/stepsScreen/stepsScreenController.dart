import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class StepsScreenController extends MainController {
  StepsScreenController._();

  static final StepsScreenController _instance = StepsScreenController._();

  factory StepsScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  RxInt _step = 3.obs;

  int get step => _step.value;

  @override
  void onInit() {
    print("StepsScreenController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("StepsScreenController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("StepsScreenController Ready");
    super.onReady();
  }
}
