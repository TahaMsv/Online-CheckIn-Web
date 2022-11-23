import 'package:dio/dio.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/seatsStepScreen/SeatsStepController.dart';
import 'package:onlinecheckin/screens/upgradesStepScreen/UpgradesStepController.dart';
import 'package:onlinecheckin/widgets/CustomFlutterWidget.dart';
import '../../utility/DataProvider.dart';
import '../../global/Classes.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_stripe_web/flutter_stripe_web.dart';

import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import 'dart:html' as html;
import 'package:zarinpal/zarinpal.dart';

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
  late PaymentRequest paymentRequest;
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

    // for (int i = 0; i < myUpgradesStepController.entertainmentsList.length; ++i) {
    //   int numOFSelected = myUpgradesStepController.entertainmentsNumberOfSelected[i];
    //   if (numOFSelected > 0) {
    //     Extra e = myUpgradesStepController.entertainmentsList[i];
    //     seatExtrasDetail.add({
    //       "Id": e.id,
    //       "Price": e.price * numOFSelected,
    //       "Count": numOFSelected,
    //       "SubTotal": e.price * numOFSelected,
    //     });
    //     taxes.add(
    //       {"title": e.title, "price": e.price * numOFSelected},
    //     );
    //     totalPrice.value += e.price * numOFSelected;
    //   }
    // }
    //
    // for (int i = 0; i < myUpgradesStepController.winesList.length; ++i) {
    //   int numOFSelected = myUpgradesStepController.winesNumberOfSelected[i];
    //   if (numOFSelected > 0) {
    //     Extra e = myUpgradesStepController.winesList[i];
    //     seatExtrasDetail.add({
    //       "Id": e.id,
    //       "Price": e.price * numOFSelected,
    //       "Count": numOFSelected,
    //       "SubTotal": e.price * numOFSelected,
    //     });
    //     taxes.add(
    //       {"title": e.title, "price": e.price * numOFSelected},
    //     );
    //     totalPrice.value += e.price * numOFSelected;
    //   }
    // }
    taxes.refresh();
  }

  void pay(String stripId) async {
    final stepsScreenController = Get.put(StepsScreenController(model));
    stepsScreenController.saveDataInLocalStorage();
    html.window.open("https://sandbox.zarinpal.com/pg/StartPay/A00000000000000000000000000358274572", "_self");

    // paymentRequest = PaymentRequest()
    //   ..setIsSandBox(true) // if your application is in developer mode, then set the sandBox as True otherwise set sandBox as false
    //   ..setMerchantID("1344b5d4-0048-11e8-94db-005056a205be")
    //   ..setCallbackURL("http://localhost:12282/#/stepsScreen")
    //   ..setDescription("Reserve seat")
    //   ..setAmount(1000);
    //
    //
    // ZarinPal().startPayment(
    //   paymentRequest,
    //       (status, paymentGatewayUri) => {
    //     if (status == 100)
    //       {
    //         html.window.open(paymentGatewayUri.toString(), "_self")
    //         // _paymentUrl = paymentGatewayUri
    //       }
    //   },
    // );

    //   Map<String, dynamic> request = {"StripeID": stripeID, "SeatsPrice": seatPrices.value, "SeatExtrasDetail": seatExtrasDetail, "TotalPrice": totalPrice.value};
    //   if (!model.requesting) {
    //     model.setRequesting(true);
    //     Response response = await DioClient.addTransaction(
    //       execution: "[OnlineCheckin].[AddTransaction]",
    //       token: myStepScreenController.travellers[0].token,
    //       request: request,
    //     );
    //     if (response.statusCode == 200) {
    //       if (response.data["ResultCode"] == 1) {
    //         wasPayed = true;
    //         myStepScreenController.setNextButton(wasPayed);
    //         myStepScreenController.setPreviousButton(!wasPayed);
    //
    //         showResultDialog();
    //         model.setRequesting(false);
    //         return;
    //       }
    //     }
    //   }
    //   model.setRequesting(false);
    //   showResultDialog();
  }

  initPlatformStateForUriUniLinks() async {
    String url = Uri.base.toString(); //get complete url
    if (url.contains("Status")) {
      //URL:http://localhost:21943/#/?Authority=000000000000000000000000000000872973&Status=OK
      List<String> parameters = url.substring(url.lastIndexOf("?") + 1).split("&");
      print(parameters);
      String status = parameters[parameters.length - 1].substring(parameters[parameters.length - 1].indexOf("=") + 1);
      String authority = parameters[parameters.length - 2].substring(parameters[parameters.length - 2].indexOf("=") + 1);
      print("status: " + status);
      print("pr in method2: ");
      print(paymentRequest);

      if (status == "OK") {
        print("pr in if: ");
        print(paymentRequest);
        ZarinPal().verificationPayment(status, authority, paymentRequest, (isPaymentSuccess, refID, paymentRequest) => {print(isPaymentSuccess), print(refID)});
      }
    }
  }

  // void pay(String stripeID) async {
  //   final myStepScreenController = Get.put(StepsScreenController(model));
  //   Map<String, dynamic> request = {"StripeID": stripeID, "SeatsPrice": seatPrices.value, "SeatExtrasDetail": seatExtrasDetail, "TotalPrice": totalPrice.value};
  //   if (!model.requesting) {
  //     model.setRequesting(true);
  //     Response response = await DioClient.addTransaction(
  //       execution: "[OnlineCheckin].[AddTransaction]",
  //       token: myStepScreenController.travellers[0].token,
  //       request: request,
  //     );
  //     if (response.statusCode == 200) {
  //       if (response.data["ResultCode"] == 1) {
  //         wasPayed = true;
  //         myStepScreenController.setNextButton(wasPayed);
  //         myStepScreenController.setPreviousButton(!wasPayed);
  //
  //         showResultDialog();
  //         model.setRequesting(false);
  //         return;
  //       }
  //     }
  //   }
  //   model.setRequesting(false);
  //   showResultDialog();
  // }

  void showResultDialog() {
    String text = wasPayed ? "Payment was successful" : "Payment failed";
    String title = wasPayed ? "" : "Error";
    showFlash(
      context: Get.context!,
      duration: const Duration(seconds: 4),
      builder: (context, controller) {
        return CustomFlashBar(
          controller: controller,
          contentMessage: text,
          titleMessage: title,
          colors: [Colors.greenAccent, Colors.green],
        );
      },
    );
  }

  @override
  void onInit() {
    print("PaymentStepController Init");
    // Stripe.publishableKey = "pk_test_VOOyyYjgzqdm8I3SrBqmh9qY";
    calculatePrices();
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
