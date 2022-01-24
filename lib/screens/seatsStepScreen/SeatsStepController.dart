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

  MainModel model;
  SeatsStepController(this.model);


  final double eachLineWidth = 45;
  List<Cabin> cabins = [];

  final RxMap<String, String> seatsStatus = <String, String>{}.obs;

  ///////////// new /////////////////

  void init() {
    final myStepScreenController = StepsScreenController(model);
    cabins = myStepScreenController.welcome!.body.seatmap.cabins;
    List<Seat> seats = myStepScreenController.welcome!.body.seats;
    for (int i = 0; i < seats.length; i++) {
      Seat seat = seats[i];
      String key = seat.letter + seat.line;
      seatsStatus[key] = seat.isUsedDescription;
    }
  }

  Future<bool> clickOnSeat() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Traveller> travellers = myStepScreenController.travellers;
    List<Map<String, dynamic>> seatsData = [];
    print(travellers);
    for (var i = 0; i < travellers.length; ++i) {
      Traveller traveller = travellers[i];
      print("here44");
      String letter = traveller.seatId.substring(0, 1);
      int line = int.parse(traveller.seatId.substring(1));
      print("here47");
      seatsData.add({
        "PassengerID": traveller.welcome.body.passengers[0].id,
        "Letter": letter,
        "Line": line,
      });
    }
    print("here54");
    Response response = await DioClient.clickOnSeat(
      execution: "OnlineCheckin.ClickOnSeat",
      token: travellers[0].token,
      request: {"SeatsData": seatsData},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        print("here");
        return true;
      }
    }
    return false;
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
    seatsStatus.refresh();
    myStepScreenController.updateIsNextButtonDisable();
  }

  bool isSeatDisable(String type, String? status){
    return (type != "Seat" || (status == "Block" || status == "Checked-in" || status == "Click"));
  }

  int seatViewType(String? cellValue , String cellType , String? seatStatus ){
    if( cellValue == "ExitDoor") return 1;  //Exit door
    if(cellType == "Seat" )
      {
        if(seatStatus == "Block") return 2;  //Block seat
        if(seatStatus == "Checked-in" || seatStatus == "Click") return 3; // Checked in or click seat
      }
    return 4; // Open seat
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
      case "Click":
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
