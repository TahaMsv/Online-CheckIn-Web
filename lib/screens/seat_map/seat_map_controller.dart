import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/core/constants/ui.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/seat_map_repository.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/seat_map_state.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/usecases/click_on_seat_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_controller.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';

import '../../core/classes/Traveler.dart';
import '../../core/classes/cabin.dart';
import '../../core/classes/seat.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';

class SeatMapController extends MainController {
  final SeatMapState seatMapState = getIt<SeatMapState>();
  final SeatMapRepository seatMapRepository = getIt<SeatMapRepository>();

  late ClickOnSeatUseCase clickOnSeatUseCase = ClickOnSeatUseCase(repository: seatMapRepository);

  ///////////// new /////////////////

  void init() {
    final StepsState stepsState = getIt<StepsState>();
    seatMapState.cabins = stepsState.flightInformation!.seatmap.cabins;
    List<Seat> seats = stepsState.flightInformation!.seats;
    for (int i = 0; i < seats.length; i++) {
      Seat seat = seats[i];
      String key = seat.letter + seat.line;
      seatMapState.seatsStatus[key] = seat.isUsedDescription;
      seatMapState.seatsPrice[key] = seat.price;
    }
    int numOfBusinessCabinCells = numberOfCabinCellsInLine("Business");
    int numOfFirstClassCabinCells = numberOfCabinCellsInLine("First Class");
    int numOfEconomyCabinCells = numberOfCabinCellsInLine("Economy");
    if (numOfFirstClassCabinCells > 0 && numOfEconomyCabinCells > 0 && 1.5 > (numOfEconomyCabinCells / numOfFirstClassCabinCells)) {
      seatMapState.firstClassCabinsRatio = numOfEconomyCabinCells / numOfFirstClassCabinCells;
    }
    if (numOfBusinessCabinCells > 0 && numOfEconomyCabinCells > 0 && 1.5 > (numOfEconomyCabinCells / numOfBusinessCabinCells)) {
      seatMapState.businessCabinsRatio = numOfEconomyCabinCells / numOfBusinessCabinCells;
    }
    seatMapState.refreshSeatMap();
  }

  void setTravelerToSelectIndexTablet(int index) {
    seatMapState.setTravelerToSelectIndexTablet(index);
    final StepsState stepsState = getIt<StepsState>();
    stepsState.setWhoseTurnToSelect(index);
  }

  void increaseTravelerToSelectIndexTablet() {
    final StepsState stepsState = getIt<StepsState>();
    if (seatMapState.travelerToSelectIndexTablet + 1 < stepsState.travelers.length) {
      seatMapState.setTravelerToSelectIndexTablet(seatMapState.travelerToSelectIndexTablet + 1);
    }
  }

  void decreaseTravelerToSelectIndexTablet() {
    if (seatMapState.travelerToSelectIndexTablet > 0) {
      setTravelerToSelectIndexTablet(seatMapState.travelerToSelectIndexTablet - 1);
    }
  }

  String convertMapToFormattedString(Map<String, String> map) {
    List<String> keyValues = [];
    map.forEach((k, v) => keyValues.add(k + "=>" + v));
    String result = keyValues.join(",");
    return result;
  }

  void convertFormattedStringToMap(Map<String, String> map, String? str) {
    if (str != null) {
      List<String> keyValues = str.split(",");
      for (var i = 0; i < keyValues.length; ++i) {
        String key = keyValues[i].split("=>")[0];
        String value = keyValues[i].split("=>")[1];
        map[key] = value;
      }
      seatMapState.refreshSeatMap();
    }
  }

  int numberOfCabinCellsInLine(String cabinTitle) {
    Iterable<Cabin> targetCabins = seatMapState.cabins.where((element) => element.cabinTitle == cabinTitle);
    if (targetCabins.isNotEmpty) {
      return targetCabins.first.lines.where((line) => line.type == "HorizontalCode").first.cells.length;
    }
    return 0;
  }

  void updateSeatMap() {
    final StepsState stepsState = getIt<StepsState>();
    List<Seat> seats = stepsState.flightInformation!.seats;
    for (var seat in seats) {
      String key = seat.letter + seat.line;
      seatMapState.seatsStatus[key] = seat.isUsedDescription;
    }
    seatMapState.selectedSeats.forEach((k, v) => seatMapState.seatsStatus[k] = v);
    seatMapState.refreshSeatMap();
  }

  Future<bool> clickOnSeat() async {
    final StepsState stepsState = getIt<StepsState>();
    List<Traveler> travellers = stepsState.travelers;
    List<Map<String, dynamic>> seatsData = [];
    String token = "";
    travellers.where((t) => !seatMapState.reservedSeats.containsKey(t.seatId)).toList().forEach((traveller) {
      token = traveller.token;
      String letter = traveller.seatId.substring(0, 1);
      int line = int.parse(traveller.seatId.substring(1));
      seatsData.add({
        "PassengerID": stepsState.flightInformation!.passengers[0].id,
        "Letter": letter,
        "Line": line,
      });
    });

    ClickOnSeatRequest clickOnSeatRequest = ClickOnSeatRequest(travelerToken: token, seatsData: seatsData);
    final fOrS = await clickOnSeatUseCase(request: clickOnSeatRequest);

    fOrS.fold((f) => FailureHandler.handle(f, retry: () => clickOnSeat()), (successful) async {
      for (var traveller in travellers) {
        seatMapState.clickedOnSeats[traveller.seatId] = traveller.getNickName();
      }
      return true;
    });

    if (seatMapState.reservedSeats.length == travellers.length) return true;
    return false;
  }

  double calculatePlaneBodyLength({String mode = "web"}) {
    if (mode == "tablet") {
      seatMapState.seatHeight = 50;
      seatMapState.seatWidth = 50;
      seatMapState.eachLineWidth = 50;
    }
    double length = 0;
    for (var i = 0; i < seatMapState.cabins.length; ++i) {
      length += calculateCabinLength(i);
      length += 5; // Left margin
    }
    return length;
  }

  double calculateCabinLength(int index, {String mode = "web"}) {
    return calculateCabinNameLength(index, mode: mode) + calculateCabinLinesLength(index, mode: mode);
  }

  double calculateCabinNameLength(int index, {String mode = "web"}) {
    return 50;
  }

  double calculateCabinLinesLength(int index, {String mode = "web"}) {
    String cabinTitle = seatMapState.cabins[index].cabinTitle;
    double ratio = (cabinTitle == "First Class"
        ? seatMapState.firstClassCabinsRatio
        : cabinTitle == "Business"
            ? seatMapState.businessCabinsRatio
            : 1.0);
    return ratio * (seatMapState.cabins[index].linesCount * (seatMapState.eachLineWidth + seatMapState.linesMargin * 2 + 2));
  }

  double calculatePlaneBodyHeight({String mode = "web"}) {
    if (mode == "tablet") {
      seatMapState.seatHeight = 50;
      seatMapState.seatWidth = 50;
      seatMapState.eachLineWidth = 50;
    }
    double maxHeight = 0;
    for (var i = 0; i < seatMapState.cabins.length; ++i) {
      double height = calculateCabinHeight(i, mode: mode);
      if (height > maxHeight) {
        maxHeight = height;
      }
    }
    maxHeight += 60; //Padding and margins
    return maxHeight;
  }

  double calculateCabinHeight(int index, {String mode = "web"}) {
    double heightSum = 0;
    String cabinTitle = seatMapState.cabins[index].cabinTitle;
    double ratio = (cabinTitle == "First Class"
        ? seatMapState.firstClassCabinsRatio
        : cabinTitle == "Business"
            ? seatMapState.businessCabinsRatio
            : 1.0);
    for (var cell in seatMapState.cabins[index].lines[1].cells) {
      int seatType = seatViewType(cell.value, cell.type, cell.code);
      double height = ratio * getSeatHeight(seatType);
      heightSum += height;
      heightSum += (mode == "web" ? 4 : 7);
    }
    return heightSum;
  }

  double getSeatHeight(int seatType, {String mode = "web"}) {
    double height = seatMapState.seatHeight;
    switch (seatType) {
      case 8:
      case 9:
      case 10:
        return 0;
      case 11:
        return height - 15;
      case 12:
        return height - 25;
      default:
        return height;
    }
  }

  double getSeatWidth(int seatType) {
    double width = seatMapState.seatWidth;
    switch (seatType) {
      case 2:
      case 8:
      case 9:
      case 11:
        return width - 15;
      case 10:
        return -0;
      case 12:
        return width - 25;
      default:
        return width;
    }
  }

  void changeSeatStatus(String seatId) {
    final StepsState stepsState = getIt<StepsState>();
    final StepsController stepsController = getIt<StepsController>();
    int price = seatMapState.seatsPrice[seatId]!;
    int whoseTurn = stepsState.whoseTurnToSelect;
    bool unSelectedTravellerExist = whoseTurn == -1 ? false : true;
    if (unSelectedTravellerExist) {
      String currStatus = seatMapState.seatsStatus[seatId]!;
      if (currStatus == "Click" && seatMapState.clickedOnSeats.containsKey(seatId)) {
        currStatus = "Open";
        seatMapState.seatPrices -= price;
      }
      if (currStatus == "Open") {
        String newSeatId = stepsState.travelers[whoseTurn].getNickName();
        seatMapState.seatsStatus[seatId] = newSeatId;
        seatMapState.seatPrices += price;
        seatMapState.selectedSeats[seatId] = newSeatId;
        stepsState.travelers[whoseTurn].seatId = seatId;
      } else {
        int travellerIndex = stepsController.findTravellerIndexBySeatId(seatId);
        if (travellerIndex != -1) {
          stepsState.travelers[travellerIndex].seatId = "--";
          seatMapState.seatsStatus[seatId] = "Open";
          seatMapState.seatPrices -= price;
          seatMapState.selectedSeats.remove(seatId);
          // clickedOnSeats.remove(seatId);
        }
      }
    } else {
      int travellerIndex = stepsController.findTravellerIndexBySeatId(seatId);
      if (travellerIndex != -1) {
        stepsState.travelers[travellerIndex].seatId = "--";
        seatMapState.seatsStatus[seatId] = "Open";
        seatMapState.seatPrices -= price;
        seatMapState.selectedSeats.remove(seatId);
        // clickedOnSeats.remove(seatId);
      }
    }
    stepsController.changeTurnToSelect();
    stepsState.refreshStepState();
    seatMapState.refreshSeatMap();
    stepsController.updateIsNextButtonDisable();
  }

  bool isSeatDisable(String type, String? status) {
    return (type != "Seat" || (status == "Block" || status == "Checked-in" || status == "Click"));
  }

  int seatViewType(String? cellValue, String cellType, String? code) {
    if (cellType == "Seat") {
      if (cellValue == null) {
        return 1; // empty area
      } else if (cellValue.length == 1) {
        return 2;
      } else {
        if (seatMapState.seatsStatus[code] == "Block" || seatMapState.seatsStatus[code] == "TemporaryBlock" || seatMapState.seatsStatus[code] == "WBTemporaryBlock") {
          return 3;
        } else if (seatMapState.seatsStatus[code] == "TemporaryBlock") {
          return 14;
        } else if (seatMapState.reservedSeats.containsKey(code)) {
          return 13;
        } else if (seatMapState.seatsStatus[code] == "Checked-in") {
          return 4;
        } else if (seatMapState.seatsStatus[code] == "Click") {
          if (seatMapState.clickedOnSeats.containsKey(code)) {
            return 6;
          } else {
            return 5;
          }
        } else if (seatMapState.seatsStatus[code] == "Open") {
          return 6;
        } else if (seatMapState.seatsStatus[code] == "Check in other Flight") {
          return 15;
        } else {
          return 7;
        } // selected seat
      }
    } else if (cellType == "OutEquipmentExit") {
      if (cellValue == null) {
        return 8;
      } else if (cellValue == "ExitDoor") {
        return 9;
      }
    } else if (cellType == "OutEquipmentWing") {
      return 10;
    } else if (cellType == "VerticalCode") {
      return 11;
    } else if (cellType == "Aile") {
      return 12;
    }
    return 0;
  }

  Color getColor(String seatId) {
    if (!seatMapState.seatsStatus.containsKey(seatId)) return MyColors.grey;

    switch (seatMapState.seatsStatus[seatId]) {
      case "TemporaryBlock":
      case "Block":
      case "WBTemporaryBlock":
        return MyColors.black;
      case "Open":
        return MyColors.white;
      case "Checked-in":
      case "Click":
      case "Check in other Flight":
        return MyColors.grey;
      default:
        return MyColors.brightYellow;
    }
  }

  @override
  void onCreate() {}
}
