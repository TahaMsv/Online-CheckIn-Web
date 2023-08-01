import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/classes/passport_type.dart';
import '../../core/classes/traveler.dart';
import '../../core/classes/my_country.dart';
import '../../widgets/CountryListPicker/country.dart';

final passportProvider = ChangeNotifierProvider<PassportState>((_) => PassportState());

class PassportState with ChangeNotifier {
  setState() => notifyListeners();

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool _passportTypeInit = false;

  bool get passportTypeInit => _passportTypeInit;

  void setPassportTypeInit(bool val) {
    _passportTypeInit = val;
    notifyListeners();
  }

  bool _getCountriesInit = false;

  bool get getCountriesInit => _getCountriesInit;

  void setGetCountriesInit(bool val) {
    _getCountriesInit = val;
    notifyListeners();
  }

  List<Traveler> travelers = <Traveler>[];
  List<int> travelersIndexInMainList = [];
  List<TextEditingController> documentNoCs = [];
  List<PassPortType> listPassportType = [PassPortType.example()];
  List<MyCountry> countryOfIssueList = [MyCountry.example("Country of Issue")];
  List<String> listGender = ["Gender", "Male", "Female"];
  List<MyCountry> nationalitiesList = [MyCountry.example("Nationality")];

  void resetPassportState() {
    setLoading(false);
    setGetCountriesInit(false);
    setPassportTypeInit(false);
    travelers = <Traveler>[];
    travelersIndexInMainList = [];
    documentNoCs = [];
    listPassportType = [PassPortType.example()];
    countryOfIssueList = [MyCountry.example("Country of Issue")];
    nationalitiesList = [MyCountry.example("Nationality")];
  }
}
