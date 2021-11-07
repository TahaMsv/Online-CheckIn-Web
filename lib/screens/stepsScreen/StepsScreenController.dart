import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:network_manager/network_manager.dart';
import '../../global/Classes.dart';
import '../../utility/DataProvider.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import 'package:dio/dio.dart';

class StepsScreenController extends MainController {
  StepsScreenController._();

  static final StepsScreenController _instance = StepsScreenController._();

  factory StepsScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  Welcome? _welcome;
  RxInt _step = 0.obs;

  int get step => _step.value;

  void setStep(int newStep) {
    _step.value = newStep;
    print(_step);
  }

  RxList<String> travellers = <String>[].obs;

  void addToTravellers(String lastName) {
    travellers.add(lastName);
  }

  void removeFromTravellers(int index) {
    if (index < travellers.length && index >= 0) {
      travellers.removeAt(index);
    }
  }

  getInformation() async {
    model.setLoading(true);
    // String token = model.token;
    String token = "88DC6A75-CD1A-4249-9EEC-3BBBC54B8B9B";
    Response response = await DioClient.getInformation(
      execution: "[OnlineCheckin].[SelectFlightInformation]",
      token: token,
      request: {},
    );

    if (response.statusCode == 200) {
      final extractedData = response.data;
      if (extractedData == null) {
        return null;
      }
      _welcome = welcomeFromJson(jsonEncode(extractedData))[0];
      model.setLoading(false);
      print("ok");
    } else {}
  }

  @override
  void onInit() {
    print("StepsScreenController Init");
    getInformation();
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
