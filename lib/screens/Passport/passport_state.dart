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


  bool _requesting = false;

  bool get requesting => _requesting;

  void setRequesting(bool val) {
    _requesting = val;
    notifyListeners();
  }

  List<Traveler> travelers = <Traveler>[];
  List<int> travelersIndexInMainList = [];
  List<TextEditingController> documentNoCs = [];
  List<MyCountry> countriesList = [];
  List<PassPortType> listPassportType = [PassPortType.example()];
  List<MyCountry> countryOfIssueList = [MyCountry.example("Country of Issue")];
  List<String> listGender = ["Gender", "Male", "Female"];
  List<MyCountry> nationalitiesList = [MyCountry.example("Nationality")];

  void refreshTravelers() {
    notifyListeners();
  }
}
