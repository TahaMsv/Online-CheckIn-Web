import 'package:flutter/material.dart';

import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class PaymentStepController extends MainController {
  PaymentStepController._();

  static final PaymentStepController _instance = PaymentStepController._();

  factory PaymentStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

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

  @override
  void onInit() {
    print("PaymentStepController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("PaymentStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("PaymentStepController Ready");
    super.onReady();
  }
}
