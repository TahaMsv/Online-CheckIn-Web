import 'dart:convert';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/paymentStepScreen/PaymentStepController.dart';
import 'package:onlinecheckin/screens/receiptStepScreen/ReceiptStepController.dart';
import 'package:onlinecheckin/screens/safetyStepScreen/SafetyStepController.dart';
import 'package:onlinecheckin/screens/seatsStepScreen/SeatsStepController.dart';
import 'package:onlinecheckin/widgets/CustomFlutterWidget.dart';
import '../../global/Classes.dart';
import '../../utility/DataProvider.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsScreenController extends MainController {
  StepsScreenController._();

  static final StepsScreenController _instance = StepsScreenController._();

  factory StepsScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  String flightType = "i"; // d = Domestic , i = International

  String language = Get.locale!.languageCode;
  RxBool isDocoNecessary = false.obs;
  RxBool isDocsNecessary = false.obs;
  RxBool isAddingBoxOpen = false.obs;

  RxBool _isNextButtonEnable = true.obs;
  RxBool _isPreviousButtonEnable = true.obs;

  RxList<Traveller> travellers = <Traveller>[].obs;
  RxInt whoseTurnToSelect = 0.obs;
  RxInt _whichOneToEdit = (-1).obs;
  RxInt _step = 6.obs;

  RxInt currButtonTextIndex = 0.obs;
  int nextButtonTextIndex = 0;

  Welcome? _welcome;

  Welcome? get welcome => _welcome;

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    /////// StepScreenController
    _step.value = (prefs.getInt('step') == null ? 0 : prefs.getInt('step')!);
    currButtonTextIndex.value = (prefs.getInt('currButtonTextIndex') == null ? 0 : prefs.getInt('currButtonTextIndex')!);
    nextButtonTextIndex = (prefs.getInt('nextButtonTextIndex') == null ? 0 : prefs.getInt('nextButtonTextIndex')!);
    whoseTurnToSelect.value = (prefs.getInt('whoseTurnToSelect') == null ? 0 : prefs.getInt('nextButtonTextIndex')!);
    _whichOneToEdit.value = (prefs.getInt('_whichOneToEdit') == null ? -1 : prefs.getInt('nextButtonTextIndex')!);
    flightType = (prefs.getString('flightType') == null ? 'i' : prefs.getString('flightType')!);
    isDocoNecessary.value = (prefs.getBool('isDocoNecessary') == null ? false : prefs.getBool('isDocoNecessary')!);
    isDocsNecessary.value = (prefs.getBool('isDocsNecessary') == null ? false : prefs.getBool('isDocsNecessary')!);
    if (_welcome == null && prefs.getString('welcome') != null) {
      setWelcome(welcomeFromJson(prefs.getString('welcome')!));
    }
    if (travellers.length == 0 && prefs.getString('travellers') != null) {
      List<String> travellersString = prefs.getString('travellers')!.split("#(#)@(@)");
      for (var i = 0; i < travellersString.length; ++i) {
        var t = travellersString[i];
        travellers.add(Traveller.fromJson(jsonDecode(t)));
      }
    }
    /////// SeatStepScreenController
    SeatsStepController seatStepScreenController = Get.put(SeatsStepController(model));
    seatStepScreenController.seatPrices = prefs.getInt('seatPrices') == null ? 0 : prefs.getInt('seatPrices')!;
    seatStepScreenController.convertFormattedStringToMap(seatStepScreenController.seatsStatus, prefs.getString('seatsStatus'));
    seatStepScreenController.convertFormattedStringToMap(seatStepScreenController.selectedSeats, prefs.getString('selectedSeats'));
    seatStepScreenController.convertFormattedStringToMap(seatStepScreenController.clickedOnSeats, prefs.getString('clickedOnSeats'));
    seatStepScreenController.convertFormattedStringToMap(seatStepScreenController.reservedSeats, prefs.getString('reservedSeats'));
  }

  void saveDataInLocalStorage() async {
    /////// StepScreenController
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('step', _step.value);
    await prefs.setInt('currButtonTextIndex', currButtonTextIndex.value);
    await prefs.setInt('nextButtonTextIndex', nextButtonTextIndex);
    await prefs.setInt('whoseTurnToSelect', whoseTurnToSelect.value);
    await prefs.setInt('whichOneToEdit', _whichOneToEdit.value);
    await prefs.setBool('isDocoNecessary', isDocoNecessary.value);
    await prefs.setBool('isDocsNecessary', isDocsNecessary.value);
    await prefs.setString('flightType', flightType);
    await prefs.setString('welcome', jsonEncode(welcome!.toJson()));
    if (travellers.length != 0) {
      List<String> travellersString = [];
      for (var i = 0; i < travellers.length; ++i) {
        var encoded = jsonEncode(travellers[i].toJson());
        travellersString.add(encoded);
      }
      await prefs.setString('travellers', travellersString.join("#(#)@(@)"));
    }
    /////// SeatStepScreenController
    SeatsStepController seatStepScreenController = Get.put(SeatsStepController(model));
    await prefs.setInt('seatPrices', seatStepScreenController.seatPrices);
    await prefs.setString('seatsStatus', seatStepScreenController.convertMapToFormattedString(seatStepScreenController.seatsStatus));
    await prefs.setString('selectedSeats', seatStepScreenController.convertMapToFormattedString(seatStepScreenController.selectedSeats));
    await prefs.setString('clickedOnSeats', seatStepScreenController.convertMapToFormattedString(seatStepScreenController.clickedOnSeats));
    await prefs.setString('reservedSeats', seatStepScreenController.convertMapToFormattedString(seatStepScreenController.reservedSeats));
  }

  void setWelcome(Welcome welcome) => _welcome = welcome;

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
    } else if (step == 3 && !newValue) {
      currButtonTextIndex.value = 4;
      setNextButtonIndex(4);
    }
  }

  void setDocsNecessary(bool newValue) {
    isDocsNecessary.value = newValue;
  }

  bool get isNextButtonEnable => _isNextButtonEnable.value;

  bool get isPreviousButtonEnable => _isPreviousButtonEnable.value;

  int get step => _step.value;
  TextEditingController editSeatC = TextEditingController();

  int get whichOneToEdit => _whichOneToEdit.value;

  void changeStateOFAddingBox() {
    bool currState = isAddingBoxOpen.value;
    isAddingBoxOpen.value = !currState;
  }

  bool isStepNeeded(int index) {
    if (index == 3 && !isDocsNecessary.value) return false;
    if (index == 4 && !isDocsNecessary.value) return false;
    if (index == 4 && !isDocoNecessary.value) return false;
    if (index == 5 && flightType == "d") return false;
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
      // PaymentStepController paymentStepController = Get.put(PaymentStepController(model));
    }
    setNextButton(true);
    // else if (step == 8) {}
  }

  void prepareNextButtonText() {
    if (step == 1 && !isDocsNecessary.value) {
      setNextButtonIndex(4);
      if (flightType == "i") return;
    } else if (step == 2) {
      if (isDocsNecessary.value && !isDocoNecessary.value) {
        setNextButtonIndex(nextButtonTextIndex + 2);
        return;
      }
    }
    setNextButtonIndex(nextButtonTextIndex + 1);
    if (nextButtonTextIndex == 4 && flightType == "d") {
      setNextButtonIndex(nextButtonTextIndex + 1);
    }
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
      if (flightType == "d") {
        nextButtonTextIndex -= 4;
        return;
      }
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
    print("step: " + _step.value.toString());
    updateIsNextButtonDisable();
  }

  void increaseStep() async {
    prepareNextButtonText();
    bool isSuccessful = true;
print("here at setstep");
    if (step < 8) {
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
        if (step == 2 && flightType == "d") {
          print("here299");
          setStep(step + 4);
          currButtonTextIndex.value = nextButtonTextIndex;
          return;
        } else if (step == 2 && !isDocsNecessary.value) {
          print("here303");
          setStep(step + 3);
          currButtonTextIndex.value = nextButtonTextIndex;
          return;
        }
        if (step == 3) {
          print("here310");
          if (!isDocoNecessary.value) {
            print("here312");
            setStep(step + 2);
            currButtonTextIndex.value = nextButtonTextIndex;

            return;
          }
        }
        print("here316");
        setStep(step + 1);
        currButtonTextIndex.value = nextButtonTextIndex;
      }
    }
  }

  void decreaseStep() async {
    int currStep = step;
    if (currStep > 0) {
      preparePreviousButtonText();
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
      if (step == 6 && flightType == "d") {
        setStep(currStep - 4);
        currButtonTextIndex.value = nextButtonTextIndex;
        return;
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
    // EnterScreenController enterScreenController = Get.put(EnterScreenController(model));
    await getInformation(token);
    for (int i = 0; i < travellers.length; i++) {
      if (travellers[i].welcome.body.passengers[0].id == welcome!.body.passengers[0].id) {
        showFlash(
          context: Get.context!,
          duration: const Duration(seconds: 4),
          builder: (context, controller) {
            return CustomFlashBar(
              controller: controller,
              contentMessage: "This passenger was added before".tr,
              titleMessage: "Duplicate traveller".tr,
            );
          },
        );
        return;
      }
    }
    Traveller traveller = new Traveller(token: token, ticketNumber: ticketNumber, seatId: "--", welcome: welcome!);
    traveller.setPassportInfo(new PassportInfo());
    traveller.setVisaInfo(new VisaInfo());

    // welcome!.body.flight[0].checkDocs == 1 && flightType == "i" ? setDocsNecessary(true) : setDocsNecessary(false);
    // flightType == "i" ? setDocsNecessary(true) : setDocsNecessary(false); // todo
    setDocsNecessary(true);
    travellers.add(traveller);
    // print(jsonEncode(traveller.toJson()));
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
      // p8
      setWelcome(welcomeFromJson(jsonEncode(extractedData)));
      model.setLoading(false);
      print("ok");
    }
  }

  @override
  void onInit() {
    print("StepsScreenController Init");
    // init();
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
