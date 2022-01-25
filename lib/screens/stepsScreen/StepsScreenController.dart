import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/paymentStepScreen/PaymentStepController.dart';
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

  Welcome? _welcome;

  List<RxBool> _isNextButtonDisable = [false.obs, true.obs, false.obs, false.obs, false.obs, false.obs, true.obs, false.obs, false.obs];


  RxList<Traveller> travellers = <Traveller>[].obs;
  RxInt whoseTurnToSelect = 0.obs;


  bool get isNextButtonDisable => _isNextButtonDisable[step].value;

  Welcome? get welcome => _welcome;
  RxInt _step = 0.obs;

  int get step => _step.value;
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



  void updateIsNextButtonDisable() {
    if (step == 0) {
      _isNextButtonDisable[step].value = travellers.length == 0 ? true : false;
    } else if (step == 1) {
      SafetyStepScreenController safetyStepScreenController = Get.put(SafetyStepScreenController(model));
      _isNextButtonDisable[step].value = !safetyStepScreenController.checkValidation();
      // } else if (step == 2) {
      // } else if (step == 3) {
      // } else if (step == 4) {
      // } else if (step == 5) {
    } else if (step == 6) {
      for (int i = 0; i < travellers.length; i++) {
        if (travellers[i].seatId == "--") {
          _isNextButtonDisable[step].value = true;
          return;
        }
      }
      _isNextButtonDisable[step].value = false;
    } else if (step == 7) {
      PaymentStepController paymentStepController = Get.put(PaymentStepController(model));
      // paymentStepController.finalReserve();
    }
    // else if (step == 8) {}
  }

  void setStep(int newStep) {
    _step.value = newStep;
  }

  void increaseStep() async {
    int currStep = step;
    bool isSuccessful = true;

    if (currStep < 8) {
      if (step == 6 ) {
        SeatsStepController seatsStepController = Get.put(SeatsStepController(model));
        isSuccessful = await seatsStepController.clickOnSeat();
      }
      // if (step == 7) {
      //   PaymentStepController paymentStepController = Get.put(PaymentStepController(model));
      //   isSuccessful = await paymentStepController.finalReserve();
      // }
      if (isSuccessful) {
        setStep(currStep + 1);
      }
    }
  }

  void changeTurnToSelect() {
    for (int i = 0; i < travellers.length; i++) {
      if (travellers[i].seatId == "--") {
        whoseTurnToSelect.value = i;
        return;
      }
    }

    whoseTurnToSelect.value = -1;
  }

  void addToTravellers(String token, String lastName, String ticketNumber) async {
    await getInformation(token);
    Passenger passenger = welcome!.body.passengers.first;
    for (int i = 0; i < travellers.length; i++) {
      if (travellers[i].welcome.body.passengers[0].lastName == lastName && travellers[i].ticketNumber == ticketNumber) {
        return;
      }
    }
    Traveller traveller = new Traveller(token: token, ticketNumber: ticketNumber, seatId: "--", welcome: _welcome!);
    traveller.setPassportInfo(new PassportInfo());
    traveller.setVisaInfo(new VisaInfo());
    travellers.add(traveller);
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

  getInformation(String token) async {
    model.setLoading(true);
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
      _welcome = welcomeFromJson(jsonEncode(extractedData));
      model.setLoading(false);
      print("ok");
    }
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
