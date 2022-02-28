import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:network_manager/network_manager.dart';
import 'package:onlinecheckin/screens/paymentStepScreen/PaymentStepController.dart';
import 'package:onlinecheckin/screens/receiptStepScreen/ReceiptStepController.dart';
import 'package:onlinecheckin/screens/safetyStepScreen/SafetyStepController.dart';
import 'package:onlinecheckin/screens/seatsStepScreen/SeatsStepController.dart';
import 'package:onlinecheckin/utility/Constants.dart';
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
    if (step == 6) {
      updateIsNextButtonDisable();
      SeatsStepController seatsStepController = Get.put(SeatsStepController(model));
      seatsStepController.updateSeatMap();
    }
    if (step == 7) {
      updateIsNextButtonDisable();
      PaymentStepController paymentStepController = Get.put(PaymentStepController(model));
      paymentStepController.calculatePrices();
    }
  }

  void increaseStep() async {
    int currStep = step;
    bool isSuccessful = true;

    if (currStep < 8) {
      if (step == 6) {
        SeatsStepController seatsStepController = Get.put(SeatsStepController(model));
        isSuccessful = await seatsStepController.clickOnSeat();
      }
      if (step == 7) {
        ReceiptStepController receiptStepController = Get.put(ReceiptStepController(model));
        isSuccessful = await receiptStepController.finalReserve();
      }
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
    changeTurnToSelect();
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

    // NetworkResponse response = await DataProvider.getInformation(
    //   execution: "[OnlineCheckin].[SelectFlightInformation]",
    //   token: token,
    //   request: {},
    //   retry: getInformation,
    // );
    // print(response.responseDetails);
    // print("here190");
    // if (response.responseStatus) {
    //   print("here192");
    //   final extractedData = response.responseBody;
    //   if (extractedData == null) {
    //     return null;
    //   }
    //   print(extractedData);
    //   _welcome = welcomeFromJson(jsonEncode(extractedData));
    //   print("here198");
    //   model.setLoading(false);
    //   print("ok");
    // }

    // Response response = await DioClient.getInformation(
    //   execution: "[OnlineCheckin].[SelectFlightInformation]",
    //   token: token,
    //   request: {},
    // );
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   final extractedData = response.data;
    //   if (extractedData == null) {
    //     return null;
    //   }
    //   _welcome = welcomeFromJson(jsonEncode(extractedData));
    //   model.setLoading(false);
    //   print("ok");
    // }
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

  // initializeApp() async {
  //   // const String token =
  //   //     "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJUb2tlbktleSI6IjBmZmVmMzg0LWFlY2QtNDY0ZC1hMDRlLTRhZTAxODA4MWJmOSIsInJvbGUiOiJNZXJjaGFudCIsIm5iZiI6MTYyNTczNzc1NywiZXhwIjoxNjM0Mzc3NzU3LCJpYXQiOjE2MjU3Mzc3NTd9.hWGpASk2cn3pwxsMvnozhUT4KiZYOoRU55-Hp1cyEv4";
  //
  //   // model.token == null ? await initializeNetworkManager(baseURL: Apis.baseUrl) :
  //   await initializeNetworkManager(token: model.token, baseURL: Apis.baseUrl);
  //
  //   // await initializePreferencesSettings();
  //   //
  //   // await initializeRoute();
  //   //
  //   // initializeLocalNotification();
  //   //
  //   // initializeFlutterFire();
  // }
  //
  // initializeNetworkManager({String? token, required String baseURL}) {
  //   NetworkOption.initialize(
  //       baseUrl: baseURL,
  //       timeout: 30000,
  //       token: token,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         "Authorization": "Bearer $token",
  //       },
  //       onStartDefault: () {
  //         print("Start");
  //         model.setLoading(true);
  //       },
  //       onEndDefault: () {
  //         print("End");
  //         model.setLoading(false);
  //       },
  //       onSuccessDefault: (res) {
  //         print("Success");
  //       },
  //       onFailedDefault: (NetworkResponse res) {
  //         print("Failed");
  //       },
  //       errorMsgExtractor: (res) {
  //         return res["Message"] ?? "Unknown Error";
  //       },
  //       successMsgExtractor: (res) {
  //         return res["Message"] ?? "Done";
  //       });
  // }

  @override
  void onInit() {
    print("StepsScreenController Init");
    // initializeApp();
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
