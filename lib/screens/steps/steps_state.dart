import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/core/classes/flight_information.dart';

import '../../core/classes/Traveler.dart';
import '../../core/constants/ui.dart';

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

  void setRequesting(bool val) {
    _requesting = val;
    notifyListeners();
  }

  FlightInformation? _flightInformation;

  FlightInformation? get flightInformation => _flightInformation;

  void setFlightInformation(FlightInformation flightInformation) {
    _flightInformation = flightInformation;
    notifyListeners();
  }

  int _step = 0;

  int get step => _step;

  void setStep(int val) {
    _step = val;
    notifyListeners();
  }

  int _whoseTurnToSelect = 0;

  int get whoseTurnToSelect => _whoseTurnToSelect;

  void setwhoseTurnToSelect(int val) {
    _whoseTurnToSelect = val;
    notifyListeners();
  }

  bool _isDocoNecessary = false;

  bool get isDocoNecessary => _isDocoNecessary;

  void setIsDocoNecessary(bool val) {
    _isDocoNecessary = val;
    notifyListeners();
  }

  bool _isDocsNecessary = false;

  bool get isDocsNecessary => _isDocsNecessary;

  void setIsDocsNecessary(bool val) {
    _isDocsNecessary = val;
    notifyListeners();
  }

  bool _isAddingBoxOpen = false;

  bool get isAddingBoxOpen => _isAddingBoxOpen;

  void setIsAddingBoxOpen(bool val) {
    _isAddingBoxOpen = val;
    notifyListeners();
  }

  bool _isNextButtonEnable = false;

  bool get isNextButtonEnable => _isNextButtonEnable;

  void setIsNextButtonEnable(bool val) {
    _isNextButtonEnable = val;
    notifyListeners();
  }

  bool _isPreviousButtonEnable = false;

  bool get isPreviousButtonEnable => _isPreviousButtonEnable;

  void setIsPreviousButtonEnable(bool val) {
    _isPreviousButtonEnable = val;
    notifyListeners();
  }

  int _currButtonTextIndex = 0;

  int get currButtonTextIndex => _currButtonTextIndex;

  void setCurrButtonTextIndex(int val) {
    _currButtonTextIndex = val;
    notifyListeners();
  }

  int _nextButtonTextIndex = 0;

  int get nextButtonTextIndex => _nextButtonTextIndex;

  void setNextButtonTextIndex(int val) {
    _nextButtonTextIndex = val;
    notifyListeners();
  }

  List<Traveler> _travellers = <Traveler>[];

  List<Traveler> get travelers => _travellers;

  void setTraveler(List<Traveler> val) {
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

  final titles = [
    "Travellers",
    "Safety",
    "Rules",
    "Passport",
    "Visa",
    "Upgrades",
    "Seats",
    "Payment",
    "Receipt",
  ];

  final List<IconData> icons = [
    MenuIcons.iconAccount,
    Icons.health_and_safety,
    MenuIcons.iconInfo,
    MenuIcons.iconPassport,
    MenuIcons.iconVisa,
    MenuIcons.star,
    MenuIcons.iconSeat,
    MenuIcons.iconCard,
    MenuIcons.iconTask,
  ];
}
