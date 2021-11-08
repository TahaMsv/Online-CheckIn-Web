import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
import 'package:onlinecheckin/utility/DataProvider.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class TravellersStepScreenController extends MainController {
  TravellersStepScreenController._();

  static final TravellersStepScreenController _instance = TravellersStepScreenController._();

  factory TravellersStepScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  TextEditingController ticketNumberC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();

  RxBool isLastNameEmpty = false.obs;
  RxBool isTicketNumberEmpty = false.obs;

  void addTraveller() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    String lastName = lastNameC.text;
    String ticketNumber = ticketNumberC.text;
    if (ticketNumber == "") {
      isTicketNumberEmpty.value = true;
    } else {
      isTicketNumberEmpty.value = false;
    }
    if (lastName == "") {
      isLastNameEmpty.value = true;
    } else {
      isLastNameEmpty.value = false;
    }
    if (ticketNumber != "" && lastName != "") {
      bool isValid = await checkTravellerValidation(ticketNumber, lastName);
      if (isValid) {
        myStepScreenController.addToTravellers(lastName, ticketNumber);
        lastNameC.text = "";
        ticketNumberC.text = "";
        isTicketNumberEmpty.value = false;
        isLastNameEmpty.value = false;
      }
    }
  }

  Future<bool> checkTravellerValidation(String ticketNumber, String lastName) async {
    String lastName = lastNameC.text;
    String ticketNumber = ticketNumberC.text;
    String token = model.token;
    Response response = await DioClient.getToken(
      execution: "[OnlineCheckin].[Authenticate]",
      token: token,
      request: {
        "Code": ticketNumber,
        "Code2": lastName,
        "UrlType": 1,
      },
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        return Future<bool>.value(true);
      }
    } else {}
    return Future<bool>.value(false);
  }

  @override
  void onInit() {
    print("TravellersStepScreenController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("TravellersStepScreenController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("TravellersStepScreenController Ready");
    super.onReady();
  }
}
