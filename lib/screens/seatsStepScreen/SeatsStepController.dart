import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinecheckin/global/Classes.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
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
    final myStepScreenController = Get.put(StepsScreenController(model));
    int whoseTurn = myStepScreenController.whoseTurnToSelect.value;
    bool unSelectedTravellerExist = whoseTurn == -1 ? false : true;
    if (unSelectedTravellerExist) {
      String currStatus = seatsStatus[seatId]!;
      if (currStatus == "unSelected") {
        String travellerFullName = myStepScreenController.travellers[whoseTurn].lastName;
        int idx = travellerFullName.indexOf(" ");
        String newSeatId = "";
        if (idx == -1) {
          newSeatId = travellerFullName.substring(0, 1).toUpperCase();
        } else {
          List<String> nameParts = [travellerFullName.substring(0, idx).trim(), travellerFullName.substring(idx + 1).trim()];
          newSeatId = (nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1)).toUpperCase();
        }
        seatsStatus[seatId] = newSeatId;
        myStepScreenController.travellers[whoseTurn].seatId = seatId;
      }else{
        print("here");
        int travellerIndex = myStepScreenController.findTravellerIndexBySeatId(seatId);
        if (travellerIndex != -1) {
          print("here1");
          myStepScreenController.travellers[travellerIndex].seatId = "--";
          seatsStatus[seatId] = "unSelected";
        }
      }
    } else {
      int travellerIndex = myStepScreenController.findTravellerIndexBySeatId(seatId);
      if (travellerIndex != -1) {
        myStepScreenController.travellers[travellerIndex].seatId = "--";
        seatsStatus[seatId] = "unSelected";
      }
    }
    myStepScreenController.changeTurnToSelect();
  }

  Color getColor(String seatId) {
    switch (seatsStatus[seatId]) {
      case "blocked":
        return Colors.black;
      case "unSelected":
        return Colors.white;
      default:
        return Color(0xffffae2c);
    }
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
