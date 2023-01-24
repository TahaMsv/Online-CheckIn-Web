import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/boarding_pass_pdf.dart';

class ReceiptState with ChangeNotifier {
  setState() => notifyListeners();

  late BoardingPassPDF boardingPassPDF;
  late Uint8List bytes;

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool _successfulResponse = false;

  bool get successfulResponse => _successfulResponse;

  void setSuccessfulResponse(bool val) {
    _successfulResponse = val;
    notifyListeners();
  }
}
