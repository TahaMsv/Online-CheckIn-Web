import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/boarding_pass_pdf.dart';

class ReceiptState with ChangeNotifier {
  setState() => notifyListeners();

  late BoardingPassPDF boardingPassPDF;

  void setBoardingPassPDF(BoardingPassPDF bp) {
    boardingPassPDF = bp;
    notifyListeners();
  }

  late Uint8List bytes;

  void setBytes(Uint8List b) {
    bytes = b;
    notifyListeners();
  }

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

  bool _isReserved = false;

  bool get isReserved => _isReserved;

    void setIsReserved(bool val) {
      _isReserved = val;
      notifyListeners();
    }
}
