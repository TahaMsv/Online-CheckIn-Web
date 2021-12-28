import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/global/Classes.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import 'package:onlinecheckin/utility/DataProvider.dart';
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

  final double eachLineWidth = 45;
  List<Cabin> cabins = [];

  final RxMap<String, String> seatsStatus = <String, String>{}.obs;

  ///////////// new /////////////////

  void init() {
    // String seatMap = SeatMaps.seatMap320;
    // Map<String, dynamic> sm = jsonDecode(seatMap);
    // print(sm);
    final myStepScreenController = StepsScreenController(model);
    cabins = myStepScreenController.welcome!.body.seatmap.cabins;
    List<Seat> seats = myStepScreenController.welcome!.body.seats;
    // print(seats.length);
    for (int i = 0; i < seats.length; i++) {
      Seat seat = seats[i];
      String key = seat.letter + seat.line;
      // if (seatsStatus.containsKey(key)) {
      //   print(key + " existed");
      // }
      seatsStatus[key] = seat.isUsedDescription;
      print(i.toString() + " ==> " + key + " : " + seat.isUsedDescription);
    }
  }

  void clickOnSeatAndReserve() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Traveller> travellers = myStepScreenController.travellers;
    List<Map<String, dynamic>> seatsData = [];
    for (var i = 0; i < travellers.length; ++i) {
      Traveller traveller = travellers[i];
      String letter = traveller.seatId.substring(0, 1);
      int line = int.parse(traveller.seatId.substring(1));
      seatsData.add({
        "PassengerID": traveller.welcome.body.passengers[i].id,
        "Letter": letter,
        "Line": line,
      });
    }
    Response response = await DioClient.clickOnSeat(
      execution: "OnlineCheckin.ClickOnSeat",
      token: travellers[0].token,
      request: {"SeatsData": seatsData},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
      }
    } else {}
  }

  double calculatePlaneBodyLength() {
    double length = 0;
    for (var i = 0; i < cabins.length; ++i) {
      length += cabins[i].linesCount;
    }
    return length * (eachLineWidth + 10) + (cabins.length * 60);
  }

  double calculateCabinLength(int index) {
    return cabins[index].linesCount * (eachLineWidth + 11);
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
