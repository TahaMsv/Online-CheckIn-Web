import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/classes/flight_information.dart';

import '../../core/classes/traveler.dart';
import '../../core/constants/my_list.dart';
import '../../core/constants/ui.dart';
import '../../initialize.dart';

final stepsProvider = ChangeNotifierProvider<StepsState>((_) => StepsState());

final flightInformationProvider = StateProvider<FlightInformation?>((ref) => null);

class StepsState with ChangeNotifier {
  setState() => notifyListeners();
  bool stepLoading = false;

  void setLoading(bool val) {
    stepLoading = val;
    notifyListeners();
  }

  bool requesting = false;

  void setRequesting(bool val) {
    requesting = val;
    notifyListeners();
  }

  bool showSeatMap = false;

  void setShowSeatMap(bool val) {
    showSeatMap = val;
    notifyListeners();
  }

  int step = 0;

  void setStep(int val) {
    step = val;
    notifyListeners();
  }

  int whoseTurnToSelect = 0;

  void setWhoseTurnToSelect(int val) {
    whoseTurnToSelect = val;
    notifyListeners();
  }

  int whichOneToEdit = 0;

  void setWhichOneToEdit(int val) {
    whichOneToEdit = val;
    notifyListeners();
  }

  bool isDocoNecessary = false;

  void setIsDocoNecessary(bool val) {
    isDocoNecessary = val;
    notifyListeners();
  }

  bool isDocsNecessary = false;

  void setIsDocsNecessary(bool val) {
    isDocsNecessary = val;
    notifyListeners();
  }

  bool isAddingBoxOpen = false;

  void setIsAddingBoxOpen(bool val) {
    isAddingBoxOpen = val;
    notifyListeners();
  }

  bool isNextButtonEnable = false;

  void setIsNextButtonEnable(bool val) {
    isNextButtonEnable = val;
    notifyListeners();
  }

  bool isPreviousButtonEnable = true;

  void setIsPreviousButtonEnable(bool val) {
    isPreviousButtonEnable = val;
    notifyListeners();
  }

  int currButtonTextIndex = 0;

  void setCurrButtonTextIndex(int val) {
    currButtonTextIndex = val;
    notifyListeners();
  }

  int nextButtonTextIndex = 0;

  void setNextButtonTextIndex(int val) {
    nextButtonTextIndex = val;
    notifyListeners();
  }

  List<Traveler> travelers = <Traveler>[];

  void setTraveler(List<Traveler> val) {
    travelers = val;
    notifyListeners();
  }

  String flightType = "i"; // d = Domestic , i = International

  String buttonText(int index) {
    return MyList.buttonsText[index];
  }

  void resetStepsState() {
    final ref = getIt<WidgetRef>();
    setRequesting(false);
    setLoading(false);
    setShowSeatMap(false);
    setIsDocoNecessary(false);
    setIsDocsNecessary(false);
    setIsAddingBoxOpen(false);
    setIsNextButtonEnable(false);
    setIsPreviousButtonEnable(false);
    ref.watch(flightInformationProvider.notifier).state = null;
    setStep(0);
    setWhoseTurnToSelect(0);
    setWhichOneToEdit(0);
    setCurrButtonTextIndex(0);
    setNextButtonTextIndex(0);
    setTraveler(<Traveler>[]);
  }
}

