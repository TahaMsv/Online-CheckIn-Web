import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/safetyStepScreen/SafetyStepController.dart';
import 'package:onlinecheckin/screens/seatsStepScreen/SeatsStepController.dart';
import '../../global/Classes.dart';
import '../../utility/DataProvider.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import 'package:dio/dio.dart';

class StepsScreenController extends MainController {
  StepsScreenController._();

  static final StepsScreenController _instance = StepsScreenController._();

  factory StepsScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  TextEditingController editSeatC = TextEditingController();

  RxInt _whichOneToEdit = (-1).obs;

  int get whichOneToEdit => _whichOneToEdit.value;

  void setWhichOneToEdit(int whichOne) {
    _whichOneToEdit.value = whichOne;
  }

  void changeTravellerSeat(int index) {
    Traveller traveller = travellers[index];
    String currSeatId = traveller.seatId;
    String newSeatId = editSeatC.text.trim().toUpperCase();
    SeatsStepController seatStepScreenController = Get.put(SeatsStepController(model));
    if (seatStepScreenController.seatsStatus.containsKey(newSeatId)) {
      String currStatus = seatStepScreenController.seatsStatus[newSeatId]!;
      if (currStatus == "Open") {
        seatStepScreenController.seatsStatus[newSeatId] = traveller.getNickName();
        travellers[index].seatId = newSeatId;
        if (currSeatId != "--") {
          seatStepScreenController.seatsStatus[currSeatId] = "Open";
        }
        seatStepScreenController.seatsStatus.refresh();
      }
    } else {}
  }

  List<RxBool> _isNextButtonDisable = [false.obs, true.obs, false.obs, false.obs, false.obs, false.obs, true.obs, false.obs, false.obs];

  bool get isNextButtonDisable => _isNextButtonDisable[step].value;

  void updateIsNextButtonDisable() {
    if (step == 0) {
      _isNextButtonDisable[step].value = travellers.length == 0 ? true : false;
    } else if (step == 1) {
      SafetyStepScreenController safetyStepScreenController = Get.put(SafetyStepScreenController(model));
      _isNextButtonDisable[step].value = !safetyStepScreenController.checkValidation();
    } else if (step == 2) {
    } else if (step == 3) {
    } else if (step == 4) {
    } else if (step == 5) {
    } else if (step == 6) {
      for (int i = 0; i < travellers.length; i++) {
        if (travellers[i].seatId == "--") {
          _isNextButtonDisable[step].value = true;
          return;
        }
      }
      _isNextButtonDisable[step].value = false;
    } else if (step == 7) {
    } else if (step == 8) {}
  }

  Welcome? _welcome;

  Welcome? get welcome => _welcome;
  RxInt _step = 0.obs;

  int get step => _step.value;

  void setStep(int newStep) {
    _step.value = newStep;
  }

  void increaseStep() {
    int currStep = step;
    if (currStep < 8) {
      setStep(currStep + 1);
    }
  }

  RxList<Traveller> travellers = <Traveller>[].obs;
  RxInt whoseTurnToSelect = 0.obs;

  void changeTurnToSelect() {
    for (int i = 0; i < travellers.length; i++) {
      if (travellers[i].seatId == "--") {
        whoseTurnToSelect.value = i;
        return;
      }
    }

    whoseTurnToSelect.value = -1;
  }

  void addToTravellers(String lastName, String ticketNumber) {
    for (int i = 0; i < travellers.length; i++) {
      if (travellers[i].lastName == lastName && travellers[i].ticketNumber == ticketNumber) {
        return;
      }
    }
    travellers.add(new Traveller(lastName: lastName, ticketNumber: ticketNumber, seatId: "--"));
    updateIsNextButtonDisable();
  }

  void removeFromTravellers(int index) {
    if (index < travellers.length && index >= 0) {
      travellers.removeAt(index);
    }
    updateIsNextButtonDisable();
  }

  int findTravellerIndexBySeatId(String seatId) {
    for (int i = 0; i < travellers.length; i++) {
      if (travellers[i].seatId == seatId) {
        return i;
      }
    }
    return -1;
  }

  getInformation() async {
    model.setLoading(true);
    String token = model.token;
    Response response = await DioClient.getInformation(
      execution: "[OnlineCheckin].[SelectFlightInformation]",
      token: token,
      request: {},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final extractedData = response.data;
      if (extractedData == null) {
        return null;
      }
      _welcome = welcomeFromJson(jsonEncode(extractedData))[0];
      model.setLoading(false);
      print("ok");
    } else {}
  }

  List buttonText = [
    "Check Pandemic Safety",
    "Check Rules",
    "Add Passports",
    "Add Visa",
    "Select Upgrades",
    "Select Seats",
    "Payment",
    "Get Boarding Pass",
  ];

  @override
  void onInit() {
    print("StepsScreenController Init");
    getInformation();
    super.onInit();
  }

  @override
  void onClose() {
    print("StepsScreenController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("StepsScreenController Ready");
    super.onReady();
  }
}
