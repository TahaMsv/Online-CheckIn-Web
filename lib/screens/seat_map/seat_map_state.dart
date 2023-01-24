import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/cabin.dart';

class SeatMapState with ChangeNotifier {
  setState() => notifyListeners();

  double eachLineWidth = 35;
  double seatWidth = 35;
  double seatHeight = 35;
  double linesMargin = 7;
  double firstClassCabinsRatio = 1.5;
  double businessCabinsRatio = 1.5;

  List<Cabin> cabins = [];
  
  int _travelerToSelectIndexTablet = 0;

  int get travelerToSelectIndexTablet => _travelerToSelectIndexTablet;

  void setTravelerToSelectIndexTablet(int val) {
    _travelerToSelectIndexTablet = val;
    notifyListeners();
  }

  int seatPrices = 0;
  final Map<String, String> seatsStatus = <String, String>{};
  final Map<String, int> seatsPrice = <String, int>{};
  final Map<String, String> selectedSeats = <String, String>{};
  final Map<String, String> clickedOnSeats = <String, String>{};
  final Map<String, String> reservedSeats = <String, String>{};

  void refreshSeatMap(){
    notifyListeners();
  }
}
