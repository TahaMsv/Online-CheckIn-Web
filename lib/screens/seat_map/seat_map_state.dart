import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/aircraft_body_size.dart';
import '../../core/classes/cabin.dart';

class SeatMapState with ChangeNotifier {
  setState() => notifyListeners();

  AirCraftBodySize airCraftBodySize = AirCraftBodySize.example();

  List<Cabin> cabins = [];

  int _travelerToSelectIndexTablet = 0;

  int get travelerToSelectIndexTablet => _travelerToSelectIndexTablet;

  void setTravelerToSelectIndexTablet(int val) {
    _travelerToSelectIndexTablet = val;
    notifyListeners();
  }

  int seatPrices = 0;
  final Map<String, String> seatsStatus = <String, String>{}; //todo
  final Map<String, int> seatsPrice = <String, int>{};
  final Map<String, String> selectedSeats = <String, String>{};
  final Map<String, String> clickedOnSeats = <String, String>{};
  final Map<String, String> reservedSeats = <String, String>{};
}
