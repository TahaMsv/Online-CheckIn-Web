import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/classes/my_country.dart';
import '../../core/classes/traveler.dart';
import '../../core/classes/visa_type.dart';

final visaProvider = ChangeNotifierProvider<VisaState>((_) => VisaState());

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

  void resetVisaState() {
    visaListType = [VisaType.example()];
    listIssuePlace = [MyCountry.example("Place of issue")];
    travelers = <Traveler>[];
    documentNoCs = [];
    destinationCs = [];
    setLoading(false);
    setVisaInit(false);
  }
}
