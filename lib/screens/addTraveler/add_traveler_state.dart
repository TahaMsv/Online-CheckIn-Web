import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTravelerState with ChangeNotifier {
  setState() => notifyListeners();

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool _requesting = false;

  bool get requesting => _requesting;

    void setRequesting(bool val) {
      _requesting = val;
      notifyListeners();
    }

  final TextEditingController _ticketNumberC = TextEditingController();
  final TextEditingController _lastNameC = TextEditingController();

  TextEditingController get ticketNumberC => _ticketNumberC;

  TextEditingController get lastNameC => _lastNameC;

  RxBool _isLastNameEmpty = false.obs;

  bool get isLastNameEmpty => _isLastNameEmpty.value;

  void setIsLastNameEmpty(bool val) {
    _isLastNameEmpty.value = val;
    notifyListeners();
  }

  RxBool _isTicketNumberEmpty = false.obs;

  bool get isTicketNumberEmpty => _isTicketNumberEmpty.value;

  void setIsTicketNumberEmpty(bool val) {
    _isTicketNumberEmpty.value = val;
    notifyListeners();
  }
}
