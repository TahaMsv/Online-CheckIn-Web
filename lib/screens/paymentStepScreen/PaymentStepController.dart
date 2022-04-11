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

  bool wasPayed = false;

  RxDouble totalPrice = 0.0.obs;
  RxInt seatPrices = 0.obs;

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
    totalPrice.value = 0;
    seatPrices.value = mySeatStepScreenController.seatPrices;
    totalPrice.value += seatPrices.value;
    seatExtrasDetail = [];

    taxes.clear();
    taxes.add({"title": "Seats price", "price": seatPrices.value});

    for (int i = 0; i < myUpgradesStepController.entertainmentsList.length; ++i) {
      int numOFSelected = myUpgradesStepController.entertainmentsNumberOfSelected[i];
      if (numOFSelected > 0) {
        Extra e = myUpgradesStepController.entertainmentsList[i];
        seatExtrasDetail.add({
          "Id": e.id,
          "Price": e.price * numOFSelected,
          "Count": numOFSelected,
          "SubTotal": e.price * numOFSelected,
        });
        taxes.add(
          {"title": e.title, "price": e.price * numOFSelected},
        );
        totalPrice.value += e.price * numOFSelected;
      }
    }

    for (int i = 0; i < myUpgradesStepController.winesList.length; ++i) {
      int numOFSelected = myUpgradesStepController.winesNumberOfSelected[i];
      if (numOFSelected > 0) {
        Extra e = myUpgradesStepController.winesList[i];
        seatExtrasDetail.add({
          "Id": e.id,
          "Price": e.price * numOFSelected,
          "Count": numOFSelected,
          "SubTotal": e.price * numOFSelected,
        });
        taxes.add(
          {"title": e.title, "price": e.price * numOFSelected},
        );
        totalPrice.value += e.price * numOFSelected;
      }
    }
    taxes.refresh();
  }

  void pay(String stripeID) async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    Map<String, dynamic> request = {"StripeID": stripeID, "SeatsPrice": seatPrices.value, "SeatExtrasDetail": seatExtrasDetail, "TotalPrice": totalPrice.value};
    if (!model.requesting) {
      model.setRequesting(true);
      Response response = await DioClient.addTransaction(
        execution: "[OnlineCheckin].[AddTransaction]",
        token: myStepScreenController.travellers[0].token,
        request: request,
      );
      if (response.statusCode == 200) {
        if (response.data["ResultCode"] == 1) {
          wasPayed = true;
          myStepScreenController.setNextButton(wasPayed);
          myStepScreenController.setPreviousButton(!wasPayed);

          showResultDialog();
          model.setRequesting(false);
          return;
        }
      }
    }
    model.setRequesting(false);
    showResultDialog();
  }

  void showResultDialog() {
    String text = wasPayed ? "Payment was successful" : "Payment failed";
    Get.defaultDialog(
      middleText: text,
      title: "",
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      backgroundColor: wasPayed ? Colors.green : Colors.red,
      buttonColor: wasPayed ? Colors.greenAccent : Colors.redAccent,
      barrierDismissible: true,
      radius: 10,
    );
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
