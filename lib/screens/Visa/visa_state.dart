import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/MyCountry.dart';
import '../../core/classes/Traveler.dart';
import '../../core/classes/VisaType.dart';

class VisaState with ChangeNotifier {
  setState() => notifyListeners();

  List<Traveler> travelers = <Traveler>[].obs;
  List<TextEditingController> documentNoCs = [];
  List<TextEditingController> destinationCs = [];
  RxBool loading = false.obs;

  List<VisaType> listType = [ VisaType(id: -1, shortName: "", name: "", fullName: "Type")];

  List<MyCountry> listIssuePlace = [
     MyCountry(worldAreaCode: null, currencyId: null, englishName: "Place of issue", name: null, hasOnHoldBooking: null, regionId: null, code3: null, isDisabled: null, id: null)
  ];

  void refreshTravellers(){
    notifyListeners();
  }
}
