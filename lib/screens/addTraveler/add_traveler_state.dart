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

  final TextEditingController ticketNumberC = TextEditingController();
  final TextEditingController lastNameC = TextEditingController();

  bool _isLastNameEmpty = false;

  bool get isLastNameEmpty => _isLastNameEmpty;

  void setIsLastNameEmpty(bool val) {
    _isLastNameEmpty = val;
    notifyListeners();
  }

  bool _isTicketNumberEmpty = false;

  bool get isTicketNumberEmpty => _isTicketNumberEmpty;

  void setIsTicketNumberEmpty(bool val) {
    _isTicketNumberEmpty = val;
    notifyListeners();
  }
}
