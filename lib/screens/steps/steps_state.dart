import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/core/classes/flight_information.dart';

import '../../core/classes/Traveler.dart';

class StepsState with ChangeNotifier {
  setState() => notifyListeners();
  bool _stepLoading = false;

  bool get stepLoading => _stepLoading;

  void setLoading(bool val) {
    _stepLoading = val;
    notifyListeners();
  }

  bool _requesting = false;

  bool get requesting => _requesting;

    void setrequesting(bool val) {
      _requesting = val;
      notifyListeners();
    }

  FlightInformation? _flightInformation;

  FlightInformation? get flightInformation => _flightInformation;

  void setFlightInformation(FlightInformation flightInformation) {
    _flightInformation = flightInformation;
    notifyListeners();
  }

  RxInt _step = 0.obs;

  int get step => _step.value;

  void setStep(int val) {
    _step.value = val;
    notifyListeners();
  }

  int _whoseTurnToSelect = 0;

  int get whoseTurnToSelect => _whoseTurnToSelect;

    void setwhoseTurnToSelect(int val) {
      _whoseTurnToSelect = val;
      notifyListeners();
    }

  RxBool _isDocoNecessary = false.obs;

  bool get isDocoNecessary => _isDocoNecessary.value;

  void setIsDocoNecessary(bool val) {
    _isDocoNecessary.value = val;
    notifyListeners();
  }

  RxBool _isDocsNecessary = false.obs;

  bool get isDocsNecessary => _isDocsNecessary.value;

  void setIsDocsnecessary(bool val) {
    _isDocsNecessary.value = val;
    notifyListeners();
  }

  RxBool _isAddingBoxOpen = false.obs;

  bool get isAddingBoxOpen => _isAddingBoxOpen.value;

  void setIsAddingBoxOpen(bool val) {
    _isAddingBoxOpen.value = val;
    notifyListeners();
  }

  RxBool _isNextButtonEnable = false.obs;

  bool get isNextButtonEnable => _isNextButtonEnable.value;

  void setIsNextButtonEnable(bool val) {
    _isNextButtonEnable.value = val;
    notifyListeners();
  }

  RxBool _isPreviousButtonEnable = true.obs;

  bool get isPreviousButtonEnable => _isPreviousButtonEnable.value;

  void setIsPreviousButtonEnable(bool val) {
    _isPreviousButtonEnable.value = val;
    notifyListeners();
  }

  RxInt _currButtonTextIndex = 0.obs;

  int get currButtonTextIndex => _currButtonTextIndex.value;

  void setCurrButtonTextIndex(int val) {
    _currButtonTextIndex.value = val;
    notifyListeners();
  }

  int _nextButtonTextIndex = 0;

  int get nextButtonTextIndex => _nextButtonTextIndex;

  void setNextButtonTextIndex(int val) {
    _nextButtonTextIndex = val;
    notifyListeners();
  }

  RxList<Traveler> _travellers = <Traveler>[].obs;

  List<Traveler> get travelers => _travellers;

  void setTraveler(RxList<Traveler> val) {
    _travellers = val;
    notifyListeners();
  }

  String flightType = "i"; // d = Domestic , i = International

  final List _buttonsText = [
    "Check Pandemic Safety",
    "Check Rules",
    "Add Passports",
    "Add Visa",
    "Select Upgrades",
    "Select Seats",
    "Payment",
    "Get Boarding Pass",
  ];

  String buttonText(int index) {
    return _buttonsText[index];
  }
}
