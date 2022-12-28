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
  List<PassPortType> listPassportType = [ PassPortType(id: -1, shortName: "", name: "", fullName: "Passport Type")];
  List<MyCountry> countryOfIssueList = [
    MyCountry(worldAreaCode: null, currencyId: null, englishName: "Country of Issue", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];
  List<String> listGender = ["Gender", "Male", "Female"];
  List<MyCountry> nationalitiesList = [
     MyCountry(worldAreaCode: null, currencyId: null, englishName: "Nationality", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

  void refreshTravelers(){
    notifyListeners();
  }
}

