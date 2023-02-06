import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentState with ChangeNotifier {
  setState() => notifyListeners();

  bool wasPayed = false;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  void setTotalPrice(double val) {
    _totalPrice = val;
    notifyListeners();
  }

  double _seatPrices = 0;

  double get seatPrices => _seatPrices;

  void setSeatPrices(double val) {
    _seatPrices = val;
    notifyListeners();
  }

  int _numberOfReserved = 0;

  int get numberOfReserved => _numberOfReserved;

  void setNumberOfReserved(int val) {
    _numberOfReserved = val;
    notifyListeners();
  }

  List<Map<String, dynamic>> taxes = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> seatExtrasDetail = [];

  TextEditingController cardHolderNameC = TextEditingController();
  TextEditingController cardNumberC = TextEditingController();
  TextEditingController expiryMonthC = TextEditingController();
  TextEditingController expiryYearC = TextEditingController();
  TextEditingController cvv2C = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController billingAddressCardNumberC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController provinceC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController postalC = TextEditingController();
}
