import 'package:flutter/material.dart';
mixin EnterScreenModel on ChangeNotifier {
  String? _token;
  String get token => _token!;
  void setToken(String t){
    _token=t;
    notifyListeners();
  }
}