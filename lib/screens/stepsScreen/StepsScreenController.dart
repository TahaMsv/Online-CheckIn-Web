import 'dart:convert';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:network_manager/network_manager.dart';
import 'package:onlinecheckin/screens/paymentStepScreen/PaymentStepController.dart';
import 'package:onlinecheckin/screens/receiptStepScreen/ReceiptStepController.dart';
import 'package:onlinecheckin/screens/safetyStepScreen/SafetyStepController.dart';
import 'package:onlinecheckin/screens/seatsStepScreen/SeatsStepController.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import 'package:onlinecheckin/widgets/CustomFlutterWidget.dart';
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
  int numOFSteps = 9;

  RxBool isDocoNecessary = false.obs;
  RxBool isDocsNecessary = false.obs;
  RxBool isAddingBoxOpen = false.obs;

  RxBool _isNextButtonEnable = true.obs;
  RxBool _isPreviousButtonEnable = true.obs;

  RxList<Traveller> travellers = <Traveller>[].obs;
  RxInt whoseTurnToSelect = 0.obs;
  RxInt _step = 3.obs;

  RxInt currButtonTextIndex = 0.obs;
  int nextButtonTextIndex = 0;

  void setNextButton(bool newValue) {
    _isNextButtonEnable.value = newValue;
  }

  void setPreviousButton(bool newValue) {
    _isPreviousButtonEnable.value = newValue;
  }

  void setDocoNecessary(bool newValue) {
    isDocoNecessary.value = newValue;
    if (step == 3 && newValue) {
      currButtonTextIndex.value = 3;
      setNextButtonIndex(3);
    }else if (step == 3 && !newValue) {
      currButtonTextIndex.value = 4;
      setNextButtonIndex(4);
    }
  }

  void setDocsNecessary(bool newValue) {
    isDocsNecessary.value = newValue;

  }

  bool get isNextButtonEnable => _isNextButtonEnable.value;

  bool get isPreviousButtonEnable => _isPreviousButtonEnable.value;

  Welcome? get welcome => _welcome;

  int get step => _step.value;
  TextEditingController editSeatC = TextEditingController();

  RxInt _whichOneToEdit = (-1).obs;

  int get whichOneToEdit => _whichOneToEdit.value;

  void changeStateOFAddingBox() {
    bool currState = isAddingBoxOpen.value;
    isAddingBoxOpen.value = !currState;
  }

  bool isStepNeeded(int index) {
    if (index == 3 && !isDocsNecessary.value) {
      return false;
    }
    if (index == 4 && !isDocsNecessary.value) {
      return false;
    }
    if (index == 4 && !isDocoNecessary.value) {
      return false;
    }
    return true;
  }

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
      setNextButton(travellers.length != 0);
      return;
    } else if (step == 1) {
      SafetyStepScreenController safetyStepScreenController = Get.put(SafetyStepScreenController(model));
      setNextButton(safetyStepScreenController.checkValidation());
      return;
    } else if (step == 6) {
      for (int i = 0; i < travellers.length; i++) {
        if (travellers[i].seatId == "--") {
          setNextButton(false);
          return;
        }
      }
      setNextButton(true);
      return;
    } else if (step == 7) {
      PaymentStepController paymentStepController = Get.put(PaymentStepController(model));
      // paymentStepController.finalReserve();
    }
    setNextButton(true);
    // else if (step == 8) {}
  }

  void prepareNextButtonText() {
    if (step == 1 && !isDocsNecessary.value) {
      setNextButtonIndex(4);
      return;
    }
    if (step == 2) {
      // if () {
      //   setNextButtonIndex(nextButtonTextIndex + 1);
      //   return;
      // }
      if (isDocsNecessary.value && !isDocoNecessary.value) {
        setNextButtonIndex(nextButtonTextIndex + 2);
        return;
      }
    }
    setNextButtonIndex(nextButtonTextIndex + 1);
  }

  setNextButtonIndex(int newIndex) {
    nextButtonTextIndex = newIndex;
  }

  List buttonsText = [
    "Check Pandemic Safety",
    "Check Rules",
    "Add Passports",
    "Add Visa",
    "Select Upgrades",
    "Select Seats",
    "Payment",
    "Get Boarding Pass",
  ];

  void preparePreviousButtonText() {
    // int currStep = step;
    if (step == 2) {
      if (!isDocsNecessary.value) {
        nextButtonTextIndex -= 3;
        return;
      }
    }
    if (step == 3) {
      if (!isDocoNecessary.value) {
        nextButtonTextIndex -= 2;
        return;
      }
    }
    // else if (step == 5) {
    //   if (!isDocsNecessary.value) {
    //     nextButtonTextIndex -= 3;
    //     return;
    //   }
    //   if (!isDocoNecessary.value) {
    //     nextButtonTextIndex -= 2;
    //     return;
    //   }
    // }
    nextButtonTextIndex -= 1;
  }

  void setStep(int newStep) {
    _step.value = newStep;
    if (step == 1) {
      updateIsNextButtonDisable();
    } else if (step == 6) {
      updateIsNextButtonDisable();
      SeatsStepController seatsStepController = Get.put(SeatsStepController(model));
      seatsStepController.updateSeatMap();
    } else if (step == 7) {
      updateIsNextButtonDisable();
      PaymentStepController paymentStepController = Get.put(PaymentStepController(model));
      setNextButton(paymentStepController.wasPayed);
      paymentStepController.calculatePrices();
    }
    updateIsNextButtonDisable();
  }

  void increaseStep() async {
    prepareNextButtonText();
    int currStep = step;
    bool isSuccessful = true;

    if (currStep < 8) {
      if (step == 6) {
        SeatsStepController seatsStepController = Get.put(SeatsStepController(model));
        if (!model.requesting) {
          isSuccessful = await seatsStepController.clickOnSeat();
        }
      } else if (step == 7) {
        ReceiptStepController receiptStepController = Get.put(ReceiptStepController(model));
        if (!model.requesting) {
          isSuccessful = await receiptStepController.finalReserve();
        }
      }
      if (isSuccessful) {

        if (step == 2 && !isDocsNecessary.value) {
          setStep(currStep + 3);
          currButtonTextIndex.value = nextButtonTextIndex;
          return;
        }
        if (step == 3) {
          if (!isDocoNecessary.value) {
            setStep(currStep + 2);
            currButtonTextIndex.value = nextButtonTextIndex;

            return;
          }
        }
        setStep(currStep + 1);
        currButtonTextIndex.value = nextButtonTextIndex;
      }
    }
  }

  void decreaseStep() async {
    preparePreviousButtonText();
    int currStep = step;
    if (currStep > 0) {
      if (step == 5) {
        if (!isDocsNecessary.value) {
          setStep(currStep - 3);
          currButtonTextIndex.value = nextButtonTextIndex;
          return;
        }
        if (!isDocoNecessary.value) {
          setStep(currStep - 2);
          currButtonTextIndex.value = nextButtonTextIndex;
          return;
        }
      }
      setStep(currStep - 1);
      currButtonTextIndex.value = nextButtonTextIndex;
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
      if (travellers[i].welcome.body.passengers[0].id == _welcome!.body.passengers[0].id) {
        showFlash(
          context: Get.context!,
          duration: const Duration(seconds: 4),
          builder: (context, controller) {
            return CustomFlashBar(
              controller: controller,
              contentMessage: "This passenger was added before",
              titleMessage: "Duplicate traveller",
            );
          },
        );
        return;
      }
    }
    Traveller traveller = new Traveller(token: token, ticketNumber: ticketNumber, seatId: "--", welcome: _welcome!);
    traveller.setPassportInfo(new PassportInfo());
    traveller.setVisaInfo(new VisaInfo());
    setDocsNecessary(true);
    // welcome!.body.flight[0].checkDocs == 1 ? setDocsNecessary(true) : setDocsNecessary(false);
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
    print("here190");
    if (response.statusCode == 200) {
      final extractedData = response.data;
      if (extractedData == null) {
        model.setRequesting(false);
        return null;
      }
      print("here197");
      _welcome = welcomeFromJson(jsonEncode(extractedData));

      model.setLoading(false);
      print("ok");
    }
  }

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
