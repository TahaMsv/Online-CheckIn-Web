import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/classes/aircraft_body_size.dart';
import '../../core/classes/seat_map.dart';
import '../../initialize.dart';

final seatMapProvider = ChangeNotifierProvider<SeatMapState>((_) => SeatMapState());

final cabinsProvider = StateProvider<List<Cabin>?>((ref) => []);

class SeatMapState with ChangeNotifier {
  setState() => notifyListeners();

  bool _seatMapInit = false;

  bool get seatMapInit => _seatMapInit;

  void setSeatMapInit(bool val) {
    _seatMapInit = val;
    notifyListeners();
  }

  AirCraftBodySize airCraftBodySize = AirCraftBodySize.example();

  // List<Cabin> cabins = [];

  int _travelerToSelectIndexTablet = 0;

  int get travelerToSelectIndexTablet => _travelerToSelectIndexTablet;

  void setTravelerToSelectIndexTablet(int val) {
    _travelerToSelectIndexTablet = val;
    notifyListeners();
  }

  double seatPrices = 0;
  Map<String, String> seatsStatus = <String, String>{};
  Map<String, int> seatsPrice = <String, int>{};
  Map<String, String> selectedSeats = <String, String>{};
  Map<String, String> clickedOnSeats = <String, String>{};
  Map<String, String> reservedSeats = <String, String>{};

  void resetSeatMapState() {
    final ref = getIt<WidgetRef>();
    seatPrices = 0;
    seatsStatus = <String, String>{};
    seatsPrice = <String, int>{};
    selectedSeats = <String, String>{};
    clickedOnSeats = <String, String>{};
    reservedSeats = <String, String>{};
    setSeatMapInit(false);
    airCraftBodySize = AirCraftBodySize.example();
    // cabins = [];
    ref.watch(cabinsProvider.notifier).state = [];

    setTravelerToSelectIndexTablet(0);
  }
}
