import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/PassportType.dart';
import '../../core/classes/Traveler.dart';
import '../../core/classes/MyCountry.dart';
import '../../widgets/CountryListPicker/country.dart';

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
}
