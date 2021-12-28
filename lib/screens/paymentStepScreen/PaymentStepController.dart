import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../../utility/DataProvider.dart';
import '../../global/Classes.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';

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

  int numberOfReserved = 0;

  void finalReserve() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Traveller> travellers = myStepScreenController.travellers;
    List<Map<String, dynamic>> seatsData = [];
    for (var i = 0; i < travellers.length; ++i) {
      Traveller traveller = travellers[i];
      String letter = traveller.seatId.substring(0, 1);
      int line = int.parse(traveller.seatId.substring(1));
      seatsData.add({
        "PassengerID": traveller.welcome.body.passengers[i].id,
        "Letter": letter,
        "Line": line,
      });
    }
    Response response = await DioClient.reserveSeat(
      execution: "[OnlineCheckin].[ReserveSeat]",
      token: travellers[0].token,
      request: {"SeatsData": seatsData},
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {}
    } else {}
  }

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
