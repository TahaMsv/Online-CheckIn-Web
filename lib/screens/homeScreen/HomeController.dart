import 'package:flutter/cupertino.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class HomeController extends MainController {
  HomeController._();
  static final HomeController _instance = HomeController._();
  factory HomeController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  TextEditingController nameC = TextEditingController();

  @override
  void onInit() {
    print("Home Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("Home Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("Home Ready");
    super.onReady();
  }


}