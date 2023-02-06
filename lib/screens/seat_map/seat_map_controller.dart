import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:online_check_in/core/classes/seat_data.dart';
import 'package:online_check_in/core/constants/route_names.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:online_check_in/screens/seat_map/seat_map_repository.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/seat_map/usecases/click_on_seat_usecase.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';

import '../../core/classes/Traveler.dart';
import '../../core/classes/seat.dart';
import '../../core/classes/seat_map.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';

class SeatMapController extends MainController {
  final SeatMapState seatMapState = getIt<SeatMapState>();
  final SeatMapRepository seatMapRepository = getIt<SeatMapRepository>();

  late ClickOnSeatUseCase clickOnSeatUseCase = ClickOnSeatUseCase(repository: seatMapRepository);

  void init() {
    print("seat map init");
    if (!seatMapState.seatMapInit) {
      final StepsState stepsState = getIt<StepsState>();
      seatMapState.cabins = stepsState.flightInformation!.seatmap.cabins;
      List<Seat> seats = stepsState.flightInformation!.seats;
      for (int i = 0; i < seats.length; i++) {
        Seat seat = seats[i];
        String key = seat.letter + seat.line;
        seatMapState.seatsStatus[key] = seat.isUsedDescription;
        seatMapState.seatsPrice[key] = seat.price;
      }
      int numOfBusinessCabinCells = numberOfCabinCellsInLine(CabinClass.business);
      int numOfFirstClassCabinCells = numberOfCabinCellsInLine(CabinClass.firstClass);
      int numOfEconomyCabinCells = numberOfCabinCellsInLine(CabinClass.economy);

      if (numOfFirstClassCabinCells > 0 && numOfEconomyCabinCells > 0 && 1.5 > (numOfEconomyCabinCells / numOfFirstClassCabinCells)) {
        seatMapState.airCraftBodySize.firstClassCabinsRatio = numOfEconomyCabinCells / numOfFirstClassCabinCells;
      }
      if (numOfBusinessCabinCells > 0 && numOfEconomyCabinCells > 0 && 1.5 > (numOfEconomyCabinCells / numOfBusinessCabinCells)) {
        seatMapState.airCraftBodySize.businessCabinsRatio = numOfEconomyCabinCells / numOfBusinessCabinCells;
      }
      seatMapState.setSeatMapInit(true);
      seatMapState.setState();
    }
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
    map.forEach((k, v) => keyValues.add("$k=>$v"));
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
      seatMapState.setState();
    }
  }

  int numberOfCabinCellsInLine(CabinClass cabinClass) {
    Iterable<Cabin> targetCabins = seatMapState.cabins.where((element) => element.cabinTitle == cabinClass.name);
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
    seatMapState.setState();
  }

  Future<bool> clickOnSeat() async {
    final StepsState stepsState = getIt<StepsState>();
    List<Traveler> travellers = stepsState.travelers;
    List<SeatData> seatsData = [];
    travellers.where((t) => !seatMapState.reservedSeats.containsKey(t.seatId)).toList().forEach((traveller) {
      seatsData.add(SeatData(
        passengerId: stepsState.flightInformation!.passengers[0].id,
        letter: traveller.seatId.substring(0, 1),
        line: int.parse(traveller.seatId.substring(1)),
      ));
    });
    ClickOnSeatRequest clickOnSeatRequest = ClickOnSeatRequest(seatsData: seatsData);
    final fOrS = await clickOnSeatUseCase(request: clickOnSeatRequest);

    bool returnValue = false;
    fOrS.fold((f) => FailureHandler.handle(f, retry: () => clickOnSeat()), (successful) async {
      print(travellers);
      if (successful) {
        for (var traveller in travellers) {
          seatMapState.clickedOnSeats[traveller.seatId] = traveller.getNickName();
        }
      }
      returnValue = successful;
    });
    return returnValue;
  }

  double calculatePlaneBodyLength({RunningMode mode = RunningMode.web}) {
    if (mode == RunningMode.tablet) {
      seatMapState.airCraftBodySize.setSeatHeight(50);
      seatMapState.airCraftBodySize.setSeatWidth(50);
      seatMapState.airCraftBodySize.setEachLineWidth(50);
    } else if (mode == RunningMode.phone) {
      seatMapState.airCraftBodySize.setSeatHeight(25);
      seatMapState.airCraftBodySize.setSeatWidth(25);
      seatMapState.airCraftBodySize.setEachLineWidth(25);
    }
    double length = 0;
    for (var i = 0; i < seatMapState.cabins.length; ++i) {
      length += calculateCabinLength(i);
      length += 5; // Left margin
    }
    return length;
  }

  double calculateCabinLength(int index, {RunningMode mode = RunningMode.web}) {
    return calculateCabinNameLength(index, mode: mode) + calculateCabinLinesLength(index, mode: mode);
  }

  double calculateCabinNameLength(int index, {RunningMode mode = RunningMode.web}) {
    return 50;
  }

  double calculateCabinLinesLength(int index, {RunningMode mode = RunningMode.web}) {
    String cabinTitle = seatMapState.cabins[index].cabinTitle;
    double ratio = (cabinTitle == CabinClass.firstClass.name
        ? seatMapState.airCraftBodySize.firstClassCabinsRatio
        : cabinTitle == CabinClass.business.name
            ? seatMapState.airCraftBodySize.businessCabinsRatio
            : 1.0);
    return ratio * (seatMapState.cabins[index].linesCount * (seatMapState.airCraftBodySize.eachLineWidth + seatMapState.airCraftBodySize.linesMargin * 2 + 2));
  }

  double calculatePlaneBodyHeight({RunningMode mode = RunningMode.web}) {
    if (mode == RunningMode.tablet) {
      seatMapState.airCraftBodySize.setSeatHeight(50);
      seatMapState.airCraftBodySize.setSeatWidth(50);
      seatMapState.airCraftBodySize.setEachLineWidth(50);
    } else if (mode == RunningMode.phone) {
      seatMapState.airCraftBodySize.setSeatHeight(25);
      seatMapState.airCraftBodySize.setSeatWidth(25);
      seatMapState.airCraftBodySize.setEachLineWidth(25);
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

  double calculateCabinHeight(int index, {RunningMode mode = RunningMode.web}) {
    double heightSum = 0;
    String cabinTitle = seatMapState.cabins[index].cabinTitle;
    double ratio = (cabinTitle == CabinClass.firstClass.name
        ? seatMapState.airCraftBodySize.firstClassCabinsRatio
        : cabinTitle == CabinClass.business.name
            ? seatMapState.airCraftBodySize.businessCabinsRatio
            : 1.0);
    for (var cell in seatMapState.cabins[index].lines[1].cells) {
      int seatType = seatViewType(cell.value, cell.type, cell.code);
      double height = ratio * getSeatHeight(seatType);
      heightSum += height;
      heightSum += (mode == RunningMode.web ? 4 : 7);
    }
    return heightSum;
  }

  double getSeatHeight(int seatType, {RunningMode mode = RunningMode.web}) {
    double height = seatMapState.airCraftBodySize.seatHeight;
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
    double width = seatMapState.airCraftBodySize.seatWidth;
    switch (seatType) {
      case 2:
      case 8:
      case 9:
      case 11:
        return width - 15;
      case 10:
        return 0;
      case 12:
        return width - 25;
      default:
        return width;
    }
  }

  void goToSeatMapTablet(int index) {
    setTravelerToSelectIndexTablet(index);
    final StepsState stepsState = getIt<StepsState>();
    stepsState.setShowSeatMap(true);
    nav.pushNamed(RouteNames.seatMapPlane);
  }

  void getBackFromPlane() {
    final StepsState stepsState = getIt<StepsState>();
    stepsState.setShowSeatMap(false);
    nav.pop();
  }

  void changeSeatStatus(String seatId) {
    print("Change status 250");
    final StepsState stepsState = getIt<StepsState>();
    final StepsController stepsController = getIt<StepsController>();
    int price = seatMapState.seatsPrice[seatId]!;
    int whoseTurn = stepsState.whoseTurnToSelect;
    print(whoseTurn);
    bool unSelectedTravellerExist = whoseTurn == -1 ? false : true;
    print(unSelectedTravellerExist);
    if (unSelectedTravellerExist) {
      print("Change status 259");
      String currStatus = seatMapState.seatsStatus[seatId]!;
      if (currStatus == SeatType.click.name && seatMapState.clickedOnSeats.containsKey(seatId)) {
        print("Change status 262");
        currStatus = SeatType.open.name;
        seatMapState.seatPrices -= price;
      }
      if (currStatus == SeatType.open.name) {
        print("Change status 267");
        String newSeatId = stepsState.travelers[whoseTurn].getNickName();
        seatMapState.seatsStatus[seatId] = newSeatId;
        seatMapState.seatPrices += price;
        seatMapState.selectedSeats[seatId] = newSeatId;
        stepsState.travelers[whoseTurn].seatId = seatId;
      } else {
        print("Change status 274");
        int travellerIndex = stepsController.findTravellerIndexBySeatId(seatId);
        if (travellerIndex != -1) {
          print("Change status 277");
          stepsState.travelers[travellerIndex].seatId = "--";
          seatMapState.seatsStatus[seatId] = SeatType.open.name;
          seatMapState.seatPrices -= price;
          seatMapState.selectedSeats.remove(seatId);
        }
      }
    } else {
      print("Change status 285");
      int travellerIndex = stepsController.findTravellerIndexBySeatId(seatId);
      if (travellerIndex != -1) {
        print("Change status 288");
        stepsState.travelers[travellerIndex].seatId = "--";
        seatMapState.seatsStatus[seatId] = SeatType.open.name;
        seatMapState.seatPrices -= price;
        seatMapState.selectedSeats.remove(seatId);
      }
    }
    stepsController.changeTurnToSelect();
    stepsState.setState();
    seatMapState.setState();
    stepsController.updateIsNextButtonDisable();
  }

  void changeSeatStatusTablet(String seatId) {
    final StepsState stepsState = getIt<StepsState>();
    final StepsController stepsController = getIt<StepsController>();
    int newPrice = seatMapState.seatsPrice[seatId]!;
    int whoseTurn = seatMapState.travelerToSelectIndexTablet;
    String currStatus = seatMapState.seatsStatus[seatId]!;
    print(whoseTurn);
    print(currStatus);
    print("Change status 309");
    if (currStatus == SeatType.click.name) return;
    print("Change status 311");
    if (currStatus == SeatType.open.name) {
      print("Change status 313");
      String currSeatId = stepsState.travelers[whoseTurn].seatId;
      print(currSeatId);
      if (currSeatId != "--") {
        seatMapState.seatsStatus[currSeatId] = SeatType.open.name;
        int lastPrice = seatMapState.seatsPrice[currSeatId]!;
        seatMapState.seatPrices -= lastPrice;
      }

      String newSeatId = stepsState.travelers[whoseTurn].getNickName();
      print(newSeatId);
      seatMapState.seatsStatus[seatId] = newSeatId;
      stepsState.travelers[whoseTurn].seatId = seatId;
      seatMapState.seatPrices += newPrice;
    }
    stepsState.setState();
    seatMapState.setState();
    stepsController.updateIsNextButtonDisable();
  }

  int seatViewType(String? cellValue, String cellType, String? code) {
    if (cellType == CellType.seat.name) {
      if (cellValue == null) {
        return 1; // empty area
      } else if (cellValue.length == 1) {
        return 2;
      } else {
        if (seatMapState.seatsStatus[code] == SeatType.block.name ||
            seatMapState.seatsStatus[code] == SeatType.temporaryBlock.name ||
            seatMapState.seatsStatus[code] == SeatType.wBTemporaryBlock.name) {
          return 3;
        } else if (seatMapState.seatsStatus[code] == SeatType.temporaryBlock.name) {
          return 14;
        } else if (seatMapState.reservedSeats.containsKey(code)) {
          return 13;
        } else if (seatMapState.seatsStatus[code] == SeatType.checkedIn.name) {
          return 4;
        } else if (seatMapState.seatsStatus[code] == SeatType.click.name) {
          if (seatMapState.clickedOnSeats.containsKey(code)) {
            return 6;
          } else {
            return 5;
          }
        } else if (seatMapState.seatsStatus[code] == SeatType.open.name) {
          return 6;
        } else if (seatMapState.seatsStatus[code] == SeatType.checkInOtherFlight.name) {
          return 15;
        } else {
          return 7;
        } // selected seat
      }
    } else if (cellType == CellType.outEquipmentExit.name) {
      if (cellValue == null) {
        return 8;
      } else if (cellValue == "ExitDoor") {
        return 9;
      }
    } else if (cellType == CellType.outEquipmentWing.name) {
      return 10;
    } else if (cellType == CellType.verticalCode.name) {
      return 11;
    } else if (cellType == CellType.aile.name) {
      return 12;
    }
    return 0;
  }

  List<dynamic> seatView(Cell cell, double cabinRatio, bool isTabletMode) {
    int seatType = seatViewType(cell.value, cell.type, cell.code);
    double width = cabinRatio * (isTabletMode ? getSeatHeight(seatType) : getSeatWidth(seatType));
    double height = cabinRatio * (!isTabletMode ? getSeatHeight(seatType) : getSeatWidth(seatType));
    bool isSeatClickable = false;
    bool hasShadow = false;
    Color color = MyColors.grey;
    String seatText = "";
    Color textColor = MyColors.white;

    switch (seatType) {
      case 1:
        color = MyColors.grey;
        break;
      case 2:
        seatText = cell.code!;
        break;
      case 3:
        color = MyColors.black;
        break;
      case 4:
        color = MyColors.lightGrey;
        hasShadow = true;
        break;
      case 5:
        color = Colors.grey.withOpacity(0.5);
        hasShadow = true;
        break;
      case 6:
        color = MyColors.white;
        isSeatClickable = true;
        seatText = cell.code!;
        textColor = MyColors.darkGrey;
        hasShadow = true;
        break;
      case 7:
        isSeatClickable = true;
        color = MyColors.brightYellow;
        seatText = seatMapState.seatsStatus[cell.code]!;
        hasShadow = true;
        break;
      case 11:
        seatText = cell.value!;
        width +=5;
        height +=5;
        break;
      case 13:
        isSeatClickable = false;
        color = MyColors.oceanGreen;
        hasShadow = true;
        seatText = seatMapState.seatsStatus[cell.code]!;
        break;
      case 14:
        isSeatClickable = false;
        seatText = "";
        break;
      case 15:
        isSeatClickable = false;
        seatText = "";
        hasShadow = true;
        break;
    }
    return [width, height, isSeatClickable, hasShadow, seatText, color, textColor];
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}