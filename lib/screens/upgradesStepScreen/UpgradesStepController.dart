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
  List<String> imagesPath =[];
  List<Extra> extras = [];
  List<RxInt> winesNumberOfSelected = [];
  List<RxInt> entertainmentsNumberOfSelected = [];

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
        winesNumberOfSelected = List.filled(extras.length - 1, 0.obs);
        entertainmentsNumberOfSelected = List.filled(1, 0.obs);
        for (var i = 0; i < extras.length; ++i) {
          if (i == extras.length - 1) {
            entertainmentsList.add(extras[i]);
            print("here1");
          } else {
            winesList.add(extras[i]);
            print("here2");
          }
        }
      }
    }
  }

  void addWine(int index) {
    winesNumberOfSelected[index].value++;
    print(index.toString() + " " + winesNumberOfSelected[index].value.toString());
  }

  void removeWine(int index) {
    if (winesNumberOfSelected[index].value > 0) {
      winesNumberOfSelected[index].value--;
      print(index.toString() + " " + winesNumberOfSelected[index].value.toString());
    }
  }

  void addEntertainment(int index) {
    entertainmentsNumberOfSelected[index].value++;
    print(index.toString() + " " + entertainmentsNumberOfSelected[index].value.toString());
  }

  void removeEntertainment(int index) {
    if (entertainmentsNumberOfSelected[index].value > 0) {
      entertainmentsNumberOfSelected[index].value--;
      print(index.toString() + " " + entertainmentsNumberOfSelected[index].value.toString());
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
