import 'package:flutter/material.dart';
mixin SplashModel on ChangeNotifier {
  String _test = "TEST";
  String get test =>_test;
  void setTest(String t){
    _test = t;
    notifyListeners();
  }
}