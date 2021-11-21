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

  void init() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Seat> seats = myStepScreenController.welcome!.seats;
    print(seats.length);
    for (int i = 0; i < seats.length; i++) {
      Seat seat = seats[i];
      String key = seat.line! + seat.letter!;
      if (seatsStatus.containsKey(key)) {
        print(key + " existed");
      }
      seatsStatus[key] = seat.isUsedDescription;
      print(i.toString() + " ==> " + key + " : " + seat.isUsedDescription);
    }
  }

  void changeSeatStatus(String seatId) {
    final myStepScreenController = Get.put(StepsScreenController(model));
    int whoseTurn = myStepScreenController.whoseTurnToSelect.value;
    bool unSelectedTravellerExist = whoseTurn == -1 ? false : true;
    if (unSelectedTravellerExist) {
      String currStatus = seatsStatus[seatId]!;
      if (currStatus == "Open") {
        String newSeatId = myStepScreenController.travellers[whoseTurn].getNickName();
        seatsStatus[seatId] = newSeatId;
        myStepScreenController.travellers[whoseTurn].seatId = seatId;
      } else {
        int travellerIndex = myStepScreenController.findTravellerIndexBySeatId(seatId);
        if (travellerIndex != -1) {
          myStepScreenController.travellers[travellerIndex].seatId = "--";
          seatsStatus[seatId] = "Open";
        }
      }
    } else {
      int travellerIndex = myStepScreenController.findTravellerIndexBySeatId(seatId);
      if (travellerIndex != -1) {
        myStepScreenController.travellers[travellerIndex].seatId = "--";
        seatsStatus[seatId] = "Open";
      }
    }
    myStepScreenController.changeTurnToSelect();
    myStepScreenController.travellers.refresh();
    myStepScreenController.updateIsNextButtonDisable();
  }

  Color getColor(String seatId) {
    switch (seatsStatus[seatId]) {
      case "Block":
        return Colors.black;
      case "Open":
        return Colors.white;
      case "Checked-in":
        return Colors.grey;
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
