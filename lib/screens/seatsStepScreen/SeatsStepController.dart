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

  int seatPrices = 0;
  final double eachLineWidth = 50;
  List<Cabin> cabins = [];

  final RxMap<String, String> seatsStatus = <String, String>{}.obs;
  final RxMap<String, int> seatsPrice = <String, int>{}.obs;
  final RxMap<String, String> selectedSeats = <String, String>{}.obs;
  final RxMap<String, String> clickedOnSeats = <String, String>{}.obs;
  final RxMap<String, String> reservedSeats = <String, String>{}.obs;

  ///////////// new /////////////////

  void init() {
    final myStepScreenController = StepsScreenController(model);
    cabins = myStepScreenController.welcome!.body.seatmap.cabins;
    List<Seat> seats = myStepScreenController.welcome!.body.seats;
    for (int i = 0; i < seats.length; i++) {
      Seat seat = seats[i];
      String key = seat.letter + seat.line;
      seatsStatus[key] = seat.isUsedDescription;
      seatsPrice[key] = seat.price;
    }
  }

  void updateSeatMap() {
    final myStepScreenController = StepsScreenController(model);
    List<Seat> seats = myStepScreenController.welcome!.body.seats;
    seats.forEach((seat) {
      String key = seat.letter + seat.line;
      seatsStatus[key] = seat.isUsedDescription;
    });
    selectedSeats.forEach((k, v) => seatsStatus[k] = v);
    // clickedOnSeats.forEach((k, v) => seatsStatus[k] = v);
    // reservedSeats.forEach((k, v) => seatsStatus[k] = v);
  }

  Future<bool> clickOnSeat() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Traveller> travellers = myStepScreenController.travellers;
    List<Map<String, dynamic>> seatsData = [];
    String token = "";
    travellers.where((t) => !reservedSeats.containsKey(t.seatId)).toList().forEach((traveller) {
      token = traveller.token;
      String letter = traveller.seatId.substring(0, 1);
      int line = int.parse(traveller.seatId.substring(1));
      seatsData.add({
        "PassengerID": traveller.welcome.body.passengers[0].id,
        "Letter": letter,
        "Line": line,
      });
    });
    Response response = await DioClient.clickOnSeat(
      execution: "OnlineCheckin.ClickOnSeat",
      token: token,
      request: {"SeatsData": seatsData},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        travellers.forEach((traveller) {
          clickedOnSeats[traveller.seatId] = traveller.getNickName();
        });
        return true;
      }
    }
    if (reservedSeats.length == travellers.length) return true; //All of them reserved a seat
    return false;
  }

  double calculatePlaneBodyLength() {
    double length = 0;
    for (var i = 0; i < cabins.length; ++i) {
      length += calculateCabinLength(i);
      length += 5; // Left margin
    }
    return length;
  }

  double calculateCabinLength(int index) {
    return calculateCabinNameLength(index) + calculateCabinLinesLength(index);
  }

  double calculateCabinNameLength(int index) {
    return (cabins[index].cabinTitle.length * 13);
  }

  double calculateCabinLinesLength(int index) {
    return cabins[index].linesCount * (eachLineWidth + 8);
  }

  double calculatePlaneBodyHeight() {
    double maxHeight = 0;
    for (var i = 0; i < cabins.length; ++i) {
      double height =calculateCabinHeight(i);
      if (height > maxHeight) {
        maxHeight = height;
      }
    }
    maxHeight += 20; //Padding and margins
    return maxHeight;
  }

  // double calculateCabinHeight(int index) {
  //   int number = cabins[index].lines[0].cells.length;
  //   return number * (32);
  // }

  double calculateCabinHeight(int index) {
    double height = 0;
    cabins[index].lines[1].cells.forEach((element) {
      if (element.type == "Seat") {
        height += 35;
      } else {
        height += 15;
      }
      height += 5;
    });
    return height;
  }

  void changeSeatStatus(String seatId) {
    final myStepScreenController = Get.put(StepsScreenController(model));
    int price = seatsPrice[seatId]!;
    int whoseTurn = myStepScreenController.whoseTurnToSelect.value;
    bool unSelectedTravellerExist = whoseTurn == -1 ? false : true;
    if (unSelectedTravellerExist) {
      String currStatus = seatsStatus[seatId]!;
      if (currStatus == "Click" && clickedOnSeats.containsKey(seatId)) {
        currStatus = "Open";
        seatPrices -= price;
      }
      if (currStatus == "Open") {
        String newSeatId = myStepScreenController.travellers[whoseTurn].getNickName();
        seatsStatus[seatId] = newSeatId;
        seatPrices += price;
        selectedSeats[seatId] = newSeatId;
        myStepScreenController.travellers[whoseTurn].seatId = seatId;
      } else {
        int travellerIndex = myStepScreenController.findTravellerIndexBySeatId(seatId);
        if (travellerIndex != -1) {
          myStepScreenController.travellers[travellerIndex].seatId = "--";
          seatsStatus[seatId] = "Open";
          seatPrices -= price;
          selectedSeats.remove(seatId);
          // clickedOnSeats.remove(seatId);
        }
      }
    } else {
      int travellerIndex = myStepScreenController.findTravellerIndexBySeatId(seatId);
      if (travellerIndex != -1) {
        myStepScreenController.travellers[travellerIndex].seatId = "--";
        seatsStatus[seatId] = "Open";
        seatPrices -= price;
        selectedSeats.remove(seatId);
        // clickedOnSeats.remove(seatId);
      }
    }
    myStepScreenController.changeTurnToSelect();
    myStepScreenController.travellers.refresh();
    seatsStatus.refresh();
    myStepScreenController.updateIsNextButtonDisable();
  }

  bool isSeatDisable(String type, String? status) {
    return (type != "Seat" || (status == "Block" || status == "Checked-in" || status == "Click"));
  }

  int seatViewType(String? cellValue, String cellType, String? code) {
    if (cellType == "Seat") {
      if (cellValue == null) {
        return 1; // empty area
      } else if (cellValue.length == 1)
        return 2; // letter => Horizontal code
      else {
        if (seatsStatus[code] == "Block")
          return 3;
        else if (reservedSeats.containsKey(code))
          return 13;
        else if (seatsStatus[code] == "Checked-in")
          return 4;
        else if (seatsStatus[code] == "Click") {
          if (clickedOnSeats.containsKey(code))
            return 6;
          else
            return 5;
        } else if (seatsStatus[code] == "Open")
          return 6;
        else
          return 7; // selected seat
      }
    } else if (cellType == "OutEquipmentExit") {
      if (cellValue == null)
        return 8;
      else if (cellValue == "ExitDoor") return 9;
    } else if (cellType == "OutEquipmentWing")
      return 10;
    else if (cellType == "VerticalCode")
      return 11;
    else if (cellType == "Aile") return 12;
    return 0;
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
