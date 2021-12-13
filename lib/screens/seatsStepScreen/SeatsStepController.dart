import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinecheckin/global/Classes.dart';
import 'package:onlinecheckin/utility/Constants.dart';
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

  ///////////// new /////////////////

  void init() {
    String seatMap = SeatMaps.seatMapAB6;
    Map<String, dynamic> sm = jsonDecode(seatMap);
    // print(sm);
    cabins = List<Cabin>.from(sm["Cabins"].map((x) => Cabin.fromJson(x)));
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Seat> seats = myStepScreenController.welcome!.seats;
    // print(seats.length);
    for (int i = 0; i < seats.length; i++) {
      Seat seat = seats[i];
      String key = seat.letter! + seat.line!;
      // if (seatsStatus.containsKey(key)) {
      //   print(key + " existed");
      // }
      seatsStatus[key] = seat.isUsedDescription;
      print(i.toString() + " ==> " + key + " : " + seat.isUsedDescription);
    }
  }

  final double eachLineWidth = 45;
  List<Cabin> cabins = [];

  double calculatePlaneBodyLength() {
    double length = 0;
    for (var i = 0; i < cabins.length; ++i) {
      length += cabins[i].linesCount;
    }
    return length * (eachLineWidth + 10) + (cabins.length * 60);
  }

  double calculateCabinLength(int index) {
    return cabins[index].linesCount * (eachLineWidth + 10);
  }

  double calculatePlaneBodyHeight() {
    int maxNumberOFCells = 0;
    for (var i = 0; i < cabins.length; ++i) {
      int number = cabins[i].lines[0].cells.length;
      if (number > maxNumberOFCells) {
        maxNumberOFCells = number;
      }
    }
    return maxNumberOFCells * (32);
  }

  double calculateCabinHeight(int index) {
    int number = cabins[index].lines[0].cells.length;
    return number * (32);
  }

  ///////////////////

  final RxMap<String, String> seatsStatus = <String, String>{}.obs;

  // void init() async {
  //   final myStepScreenController = Get.put(StepsScreenController(model));
  //   List<Seat> seats = myStepScreenController.welcome!.seats;
  //   print(seats.length);
  //   for (int i = 0; i < seats.length; i++) {
  //     Seat seat = seats[i];
  //     String key = seat.line! + seat.letter!;
  //     if (seatsStatus.containsKey(key)) {
  //       print(key + " existed");
  //     }
  //     seatsStatus[key] = seat.isUsedDescription;
  //     print(i.toString() + " ==> " + key + " : " + seat.isUsedDescription);
  //   }
  // }

  void changeSeatStatus(String seatId) {
    final myStepScreenController = Get.put(StepsScreenController(model));
    int whoseTurn = myStepScreenController.whoseTurnToSelect.value;
    bool unSelectedTravellerExist = whoseTurn == -1 ? false : true;
    print("change status: " + seatId);
    print(whoseTurn);
    print(unSelectedTravellerExist);
    if (unSelectedTravellerExist) {
      print("here102");
      String currStatus = seatsStatus[seatId]!;
      print("here104");
      print(seatId + " " + currStatus);
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
    if (!seatsStatus.containsKey(seatId)) return Colors.grey;

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
