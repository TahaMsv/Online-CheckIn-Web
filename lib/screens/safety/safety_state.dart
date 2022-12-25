
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SafetyState with ChangeNotifier {
  setState() => notifyListeners();

  RxList<bool> checkBoxesValue = <bool>[false, false, false].obs;


}
