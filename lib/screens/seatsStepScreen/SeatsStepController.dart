import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class SeatsStepController extends MainController {
  SeatsStepController._();

  static final SeatsStepController _instance = SeatsStepController._();

  factory SeatsStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  final RxMap<String, String> seatsStatus = <String, String>{}.obs;

  void init() {
    for (int i = 65; i <= 70; i++) {
      for (int j = 1; j <= 30; j++) {
        String key = j.toString() + String.fromCharCode(i);
        seatsStatus[key] = j == 1 ? "blocked" : "unSelected";
      }
    }
  }

  void changeSeatStatus(String seatId) {
    String currStatus = seatsStatus[seatId]!;
    if (currStatus == "selected") {
      seatsStatus[seatId] = "unSelected";
    } else {
      seatsStatus[seatId] = "selected";
    }
  }

  Color getColor(String seatId) {
    switch (seatsStatus[seatId]) {
      case "blocked":
        return Colors.black;
      case "selected":
        return Colors.amberAccent;
      case "unSelected":
        return Colors.white;
    }
    return Colors.white;
  }

  @override
  void onInit() {
    print("SeatsStepController Init");
    init();
    super.onInit();
  }

  @override
  void onClose() {
    print("SeatsStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("SeatsStepController Ready");
    super.onReady();
  }
}
