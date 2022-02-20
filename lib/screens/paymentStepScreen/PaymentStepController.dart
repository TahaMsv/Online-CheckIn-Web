import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/seatsStepScreen/SeatsStepController.dart';
import 'package:onlinecheckin/screens/upgradesStepScreen/UpgradesStepController.dart';
import '../../utility/DataProvider.dart';
import '../../global/Classes.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';

import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class PaymentStepController extends MainController {
  PaymentStepController._();

  static final PaymentStepController _instance = PaymentStepController._();

  factory PaymentStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  int _seatPrices = 0;

  int get seatPrices => _seatPrices;
  RxList<Map<String, dynamic>> taxes = <Map<String, dynamic>>[].obs;
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

  int numberOfReserved = 0;

  void calculatePrices() {
    final mySeatStepScreenController = Get.put(SeatsStepController(model));
    final myUpgradesStepController = Get.put(UpgradesStepController(model));
    _totalPrice = 0;
    _seatPrices = mySeatStepScreenController.seatPrices;
    _totalPrice += _seatPrices;
    seatExtrasDetail = [];
    // myUpgradesStepController.winesList.where((w) => w["numberOfSelected"] > 0).forEach((element) {
    //   seatExtrasDetail.add({
    //     "Id": element["id"],
    //     "name": element["name"],
    //     "Price": element['price'],
    //     "Count": element['numberOfSelected'],
    //     "SubTotal": element['price'] * element['numberOfSelected'],
    //   });
    // });
    // myUpgradesStepController.entertainmentsList.where((w) => w["numberOfSelected"] > 0).forEach((element) {
    //   seatExtrasDetail.add({
    //     "Id": element["id"],
    //     "name": element["name"],
    //     "Price": element['price'],
    //     "Count": element['numberOfSelected'],
    //     "SubTotal": element['price'] * element['numberOfSelected'],
    //   });
    // });

    taxes.clear();
    taxes.add({"title": "Seats price", "price": seatPrices});
    seatExtrasDetail.forEach(
      (element) {
        taxes.add(
          {"title": element["name"], "price": element["SubTotal"]},
        );
      },
    );
    taxes.refresh();
  }

  void pay() async {
    final paymentMethod = await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
    String stripeID = paymentMethod.id;
    final myStepScreenController = Get.put(StepsScreenController(model));
    final mySeatStepScreenController = Get.put(SeatsStepController(model));
    final myUpgradesStepController = Get.put(UpgradesStepController(model));

    _totalPrice = 0;
    _seatPrices = mySeatStepScreenController.seatPrices;
    _totalPrice += _seatPrices;
    seatExtrasDetail = [];
    // myUpgradesStepController.winesList.where((w) => w["numberOfSelected"] > 0).forEach((element) {
    //   seatExtrasDetail.add({
    //     "Id": element["id"],
    //     "Price": element['price'],
    //     "Count": element['numberOfSelected'],
    //     "SubTotal": element['price'] * element['numberOfSelected'],
    //   });
    // });
    // myUpgradesStepController.entertainmentsList.where((w) => w["numberOfSelected"] > 0).forEach((element) {
    //   seatExtrasDetail.add({
    //     "Id": element["id"],
    //     "Price": element['price'],
    //     "Count": element['numberOfSelected'],
    //     "SubTotal": element['price'] * element['numberOfSelected'],
    //   });
    // });

    Map<String, dynamic> request = {"StripeID": stripeID, "SeatsPrice": _seatPrices, "SeatExtrasDetail": seatExtrasDetail, "TotalPrice": totalPrice};
    Response response = await DioClient.addTransaction(
      execution: "[OnlineCheckin].[AddTransaction]",
      token: myStepScreenController.travellers[0].token,
      request: request,
    );
    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {}
    }
  }

  @override
  void onInit() {
    print("PaymentStepController Init");
    Stripe.publishableKey = "pk_test_VOOyyYjgzqdm8I3SrBqmh9qY";
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
