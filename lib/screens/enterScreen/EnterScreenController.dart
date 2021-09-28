import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class EnterScreenController extends MainController {
  EnterScreenController._();
  static final EnterScreenController _instance = EnterScreenController._();
  factory EnterScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }



  @override
  void onInit() {
    print("EnterScreenController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("EnterScreenController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("EnterScreenController Ready");
    super.onReady();
  }


}