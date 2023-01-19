import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SafetyState with ChangeNotifier {
  setState() => notifyListeners();

  List<bool> _checkBoxesValue = <bool>[false, false, false];

  List<bool> get checkBoxesValue => _checkBoxesValue;

  void toggleCheckBoxesValue(int index) {
    _checkBoxesValue[index] = !_checkBoxesValue[index];
    notifyListeners();
  }
}
