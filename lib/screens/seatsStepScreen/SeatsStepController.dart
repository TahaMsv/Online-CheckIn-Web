import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/global/Classes.dart';
import 'package:onlinecheckin/utility/DataProvider.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class SeatsStepController extends MainController {
  MainModel model;

  SeatsStepController(this.model);

  double eachLineWidth = 35;
  double seatWidth = 35;
  double seatHeight = 35;
  double linesMargin = 7;
  List<Cabin> cabins = [];
  double firstClassCabinsRatio = 1.5;
  double businessCabinsRatio = 1.5;

  RxInt travelerToSelectIndexTablet = 0.obs;

  int seatPrices = 0;
  final RxMap<String, String> seatsStatus = <String, String>{}.obs;
  final RxMap<String, int> seatsPrice = <String, int>{}.obs;
  final RxMap<String, String> selectedSeats = <String, String>{}.obs;
  final RxMap<String, String> clickedOnSeats = <String, String>{}.obs;
  final RxMap<String, String> reservedSeats = <String, String>{}.obs;

  ///////////// new /////////////////

  void init() {
    final myStepScreenController = Get.put(StepsScreenController(model));
    cabins = myStepScreenController.welcome!.body.seatmap.cabins;
    List<Seat> seats = myStepScreenController.welcome!.body.seats;
    for (int i = 0; i < seats.length; i++) {
      Seat seat = seats[i];
      String key = seat.letter + seat.line;
      seatsStatus[key] = seat.isUsedDescription;
      seatsPrice[key] = seat.price;
    }
    int numOfBusinessCabinCells = numberOfCabinCellsInLine("Business");
    int numOfFirstClassCabinCells = numberOfCabinCellsInLine("First Class");
    int numOfEconomyCabinCells = numberOfCabinCellsInLine("Economy");
    if (numOfFirstClassCabinCells > 0 && numOfEconomyCabinCells > 0 && 1.5 > (numOfEconomyCabinCells / numOfFirstClassCabinCells)) {
      firstClassCabinsRatio = numOfEconomyCabinCells / numOfFirstClassCabinCells;
      print("firstClassCabinsRatio => " + firstClassCabinsRatio.toString());
    }
    if (numOfBusinessCabinCells > 0 && numOfEconomyCabinCells > 0 && 1.5 > (numOfEconomyCabinCells / numOfBusinessCabinCells)) {
      businessCabinsRatio = numOfEconomyCabinCells / numOfBusinessCabinCells;
      print("businessCabinsRatio => " + businessCabinsRatio.toString());
    }
  }

  void setTravelerToSelectIndexTablet(int index) {
    final myStepScreenController = Get.put(StepsScreenController(model));
    travelerToSelectIndexTablet.value = index;
    myStepScreenController.whoseTurnToSelect.value = index;
  }

  void increaseTravelerToSelectIndexTablet() {
    final myStepScreenController = Get.put(StepsScreenController(model));
    if (travelerToSelectIndexTablet.value + 1 < myStepScreenController.travellers.length) {
      setTravelerToSelectIndexTablet(travelerToSelectIndexTablet.value + 1);
    }
  }

  void decreaseTravelerToSelectIndexTablet() {
    if (travelerToSelectIndexTablet.value > 0) {
      setTravelerToSelectIndexTablet(travelerToSelectIndexTablet.value - 1);
    }
  }

  String convertMapToFormattedString(RxMap<String, String> map) {
    List<String> keyValues = [];
    map.forEach((k, v) => keyValues.add(k + "=>" + v));
    String result = keyValues.join(",");
    return result;
  }

  void convertFormattedStringToMap(RxMap<String, String> map, String? str) {
    if (str != null) {
      List<String> keyValues = str.split(",");
      for (var i = 0; i < keyValues.length; ++i) {
        String key = keyValues[i].split("=>")[0];
        String value = keyValues[i].split("=>")[1];
        map[key] = value;
      }
      map.refresh();
    }
  }

  int numberOfCabinCellsInLine(String cabinTitle) {
    Iterable<Cabin> targetCabins = cabins.where((element) => element.cabinTitle == cabinTitle);
    if (targetCabins.length != 0) {
      return targetCabins.first.lines.where((line) => line.type == "HorizontalCode").first.cells.length;
    }
    return 0;
  }

  void updateSeatMap() {
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Seat> seats = myStepScreenController.welcome!.body.seats;
    seats.forEach((seat) {
      String key = seat.letter + seat.line;
      seatsStatus[key] = seat.isUsedDescription;
    });
    selectedSeats.forEach((k, v) => seatsStatus[k] = v);
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
    if (!model.requesting) {
      model.setRequesting(true);
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
          model.setRequesting(false);
          return true;
        }
      }
    }
    model.setRequesting(false);
    if (reservedSeats.length == travellers.length) return true; //All of them reserved a seat
    model.setRequesting(false);
    return false;
  }

  double calculatePlaneBodyLength({String mode = "web"}) {
    if (mode == "tablet") {
      seatHeight = 50;
      seatWidth = 50;
      eachLineWidth = 50;
    }
    double length = 0;
    for (var i = 0; i < cabins.length; ++i) {
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
    String cabinTitle = cabins[index].cabinTitle;
    double ratio = (cabinTitle == "First Class"
        ? firstClassCabinsRatio
        : cabinTitle == "Business"
            ? businessCabinsRatio
            : 1.0);
    return ratio * (cabins[index].linesCount * (eachLineWidth + linesMargin * 2 + 2));
  }

  double calculatePlaneBodyHeight({String mode = "web"}) {
    if (mode == "tablet") {
      seatHeight = 50;
      seatWidth = 50;
      eachLineWidth = 50;
    }
    double maxHeight = 0;
    for (var i = 0; i < cabins.length; ++i) {
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
    String cabinTitle = cabins[index].cabinTitle;
    double ratio = (cabinTitle == "First Class"
        ? firstClassCabinsRatio
        : cabinTitle == "Business"
            ? businessCabinsRatio
            : 1.0);
    cabins[index].lines[1].cells.forEach((cell) {
      int seatType = seatViewType(cell.value, cell.type, cell.code);
      double height = ratio * getSeatHeight(seatType);
      heightSum += height;
      heightSum += (mode == "web" ? 4 : 7);
    });
    return heightSum;
  }

  double getSeatHeight(int seatType, {String mode = "web"}) {
    double height = seatHeight;
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
    double width = seatWidth;
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
        if (seatsStatus[code] == "Block" || seatsStatus[code] == "TemporaryBlock" || seatsStatus[code] == "WBTemporaryBlock")
          return 3;
        else if (seatsStatus[code] == "TemporaryBlock")
          return 14;
        else if (reservedSeats.containsKey(code))
          return 13;
        else if (seatsStatus[code] == "Checked-in")
          return 4;
        else if (seatsStatus[code] == "Click") {
          if (clickedOnSeats.containsKey(code))
            return 6;
          else
            return 5;
        } else if (seatsStatus[code] == "Open") {
          return 6;
        } else if (seatsStatus[code] == "Check in other Flight") {
          return 15;
        } else
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
      case "TemporaryBlock":
      case "Block":
      case "WBTemporaryBlock":
        return Colors.black;
      case "Open":
        return Colors.white;
      case "Checked-in":
      case "Click":
      case "Check in other Flight":
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
