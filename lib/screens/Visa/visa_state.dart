import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/MyCountry.dart';
import '../../core/classes/Traveler.dart';
import '../../core/classes/VisaType.dart';

class VisaState with ChangeNotifier {
  setState() => notifyListeners();

  List<Traveler> travelers = <Traveler>[];
  List<TextEditingController> documentNoCs = [];
  List<TextEditingController> destinationCs = [];

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

bool _visaInit = false;

bool get visaInit => _visaInit;

  void setVisaInit(bool val) {
    _visaInit = val;
    notifyListeners();
  }

  List<VisaType> visaListType = [VisaType.example()];
  List<MyCountry> listIssuePlace = [MyCountry.example("Place of issue")];


}
