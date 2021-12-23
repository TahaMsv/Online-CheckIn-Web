import 'package:dio/dio.dart';
import 'package:onlinecheckin/global/Classes.dart';
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
import 'package:onlinecheckin/utility/DataProvider.dart';

import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/material.dart';

class UpgradesStepController extends MainController {
  UpgradesStepController._();

  static final UpgradesStepController _instance = UpgradesStepController._();

  factory UpgradesStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  List<Extra> extras = [];
  List<RxInt> numberOfSelected=[];

  RxList<Map<String, dynamic>> winesList = [
    {
      "name": "Sparkling Wine",
      "description": "Sparkling wine is a wine with significant levels of carbon dioxide in it. Making it fizzy",
      "imagePath": "assets/images/sparkling-wine.png",
      "color": Color(0xffffc365),
      "numberOfSelected": 0,
      "price":0.0
    },
    {
      "name": "Prosecco",
      "description": "Prosecco is a sparkling wine that’s often taken for granted",
      "imagePath": "assets/images/prosecco-wine.png",
      "color": Color(0xff5f6bff),
      "numberOfSelected": 0,
      "price":0.0
    },
    {
      "name": "Champagne",
      "description": "Champagne is a French sparkling wine",
      "imagePath": "assets/images/champagne.png",
      "color": Color(0xfffa4b4b),
      "numberOfSelected": 0,
      "price":0.0
    },
    {
      "name": "Champagne",
      "description": "Champagne is a French sparkling wine",
      "imagePath": "assets/images/champagne.png",
      "color": Color(0xffffc365),
      "numberOfSelected": 0,
      "price":0.0
    },
  ].obs;

  RxList<Map<String, dynamic>> entertainmentsList = [
    {
      "name": "Photo print",
      "description": "Confirm your flight details and see which extras you already purchased",
      "imagePath": "assets/images/printer.png",
      "color": Color(0xff424242),
      "numberOfSelected": 0,
      "price":0.0
    },
  ].obs;

  // RxList<int> winesNumberList = <int>[].obs;
  // List<double> winesCost = [];
  //
  // RxList<int> entertainmentsNumberList = <int>[].obs;
  // List<double> entertainmentsCost = [];

  void init() async {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    Response response = await DioClient.selectCountries(
      execution: "[OnlineCheckin].[SelectSeatExtras]",
      token: stepsScreenController.travellers[0].token,
      request: {},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        extras = List<Extra>.from(response.data["Body"]["Extras"].map((x) => Extra.fromJson(x)));
        numberOfSelected = List.filled(extras.length, 0.obs);
        for (var i = 0; i < extras.length ; ++i) {
          if (i == extras.length - 1) {
            entertainmentsList[i]["name"] = extras[i].title;
            entertainmentsList[i]["description"] = extras[i].description;
            entertainmentsList[i]["price"] = extras[i].price;
          } else {
            winesList[i]["name"] = extras[i].title;
            winesList[i]["description"] = extras[i].description;
            winesList[i]["price"] = extras[i].price;
          }
        }

      }
    } else {}
  }

  void addWine(int index) {
    winesList[index]["numberOfSelected"]++;
    winesList.refresh();
    print(index.toString() + " " + winesList[index]["numberOfSelected"]);
  }

  void removeWine(int index) {
    if (winesList[index]["numberOfSelected"] > 0) {
      winesList[index]["numberOfSelected"]--;
      winesList.refresh();
      print(index.toString() + " " + winesList[index]["numberOfSelected"]);
    }
  }

  void addEntertainment(int index) {
    entertainmentsList[index]["numberOfSelected"]++;
    entertainmentsList.refresh();
    print(index.toString() + " " + entertainmentsList[index]["numberOfSelected"]);
  }

  void removeEntertainment(int index) {
    if (entertainmentsList[index]["numberOfSelected"] > 0) {
      entertainmentsList[index]["numberOfSelected"]--;
      entertainmentsList.refresh();
      print(index.toString() + " " + entertainmentsList[index]["numberOfSelected"]);
    }
  }

  @override
  void onInit() {
    print("UpgradesStepController Init");
    init();
    super.onInit();
  }

  @override
  void onClose() {
    print("UpgradesStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("UpgradesStepController Ready");
    super.onReady();
  }
}
