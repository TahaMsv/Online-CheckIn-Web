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

  List<Color> colors = [Color(0xff5f6bff), Color(0xffffc365), Color(0xfffa4b4b), Color(0xffffc365), Color(0xff424242)];
  List<String> imagesPath = [];
  List<Extra> extras = [];
  RxList<int> winesNumberOfSelected = <int>[].obs;
  RxList<int> entertainmentsNumberOfSelected = <int>[].obs;

  RxList<Extra> winesList = <Extra>[].obs;

  RxList<Extra> entertainmentsList = <Extra>[].obs;

  void init() async {
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    Response response = await DioClient.selectSeatExtras(
      execution: "[OnlineCheckin].[SelectSeatExtras]",
      token: stepsScreenController.travellers[0].token,
      request: {},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        extras = List<Extra>.from(response.data["Body"]["Extras"].map((x) => Extra.fromJson(x)));
        for (var i = 0; i < extras.length - 1; ++i) {
          winesNumberOfSelected.add(0);
        }
        entertainmentsNumberOfSelected.add(0);
        for (var i = 0; i < extras.length; ++i) {
          if (i == extras.length - 1) {
            entertainmentsList.add(extras[i]);
            // print("here1");
          } else {
            winesList.add(extras[i]);
            // print("here2");
          }
        }
      }
    }
  }

  void addWine(int index) {
    winesNumberOfSelected[index]++;
    winesNumberOfSelected.refresh();
  }

  void removeWine(int index) {
    if (winesNumberOfSelected[index]> 0) {
      winesNumberOfSelected[index]--;
      winesNumberOfSelected.refresh();
    }
  }

  void addEntertainment(int index) {
    entertainmentsNumberOfSelected[index]++;
    entertainmentsNumberOfSelected.refresh();
  }

  void removeEntertainment(int index) {
    if (entertainmentsNumberOfSelected[index] > 0) {
      entertainmentsNumberOfSelected[index]--;
      entertainmentsNumberOfSelected.refresh();
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
