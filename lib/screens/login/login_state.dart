import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginState with ChangeNotifier {
  setState() => notifyListeners();

  bool _loginLoading = false;

  bool get loginLoading => _loginLoading;

  void setLoginLoading(bool val) {
    _loginLoading = val;
    notifyListeners();
  }

  bool _requesting = false;

  bool get requesting => _requesting;

  void setRequesting(bool val) {
    _requesting = val;
    notifyListeners();
  }

  String? _token;

  String get token => _token!;

  void setToken(String val) {
    _token = val;
    notifyListeners();
  }


  final TextEditingController _bookingRefNameC = TextEditingController();
  final TextEditingController _lastNameC = TextEditingController();

  TextEditingController get bookingRefNameC => _bookingRefNameC;

  TextEditingController get lastNameC => _lastNameC;

  RxBool _isLastNameEmpty = false.obs;

  bool get isLastNameEmpty => _isLastNameEmpty.value;

  void setIsLastNameEmpty(bool val) {
    _isLastNameEmpty.value = val;
    notifyListeners();
  }

  RxBool _isBookingRefNameEmpty = false.obs;

  bool get isBookingRefNameEmpty => _isBookingRefNameEmpty.value;

  void setIsBookingRefNameEmpty(bool val) {
    _isBookingRefNameEmpty.value = val;
    notifyListeners();
  }
}
