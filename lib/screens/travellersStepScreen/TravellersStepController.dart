import 'package:dio/dio.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:network_manager/network_manager.dart';
import 'package:onlinecheckin/screens/enterScreen/EnterScreenController.dart';
import 'package:onlinecheckin/widgets/CustomFlutterWidget.dart';
import '../../global/Classes.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../utility/DataProvider.dart';
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
  Welcome? welcome;
  void init() {
    final myStepScreenController = Get.put(StepsScreenController(model));
    welcome= myStepScreenController.welcome!;
  }

  void addTraveller() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    String lastName = lastNameC.text;
    String ticketNumber = ticketNumberC.text;
    if (ticketNumber == "") {
      // isTicketNumberEmpty.value = true;
      showFlash(
        context: Get.context!,
        duration: const Duration(seconds: 4),
        builder: (context, controller) {
          return CustomFlashBar(controller: controller,contentMessage: "Ticket Number can not be empty",titleMessage: "Error",);
        },
      );
    } else {
      isTicketNumberEmpty.value = false;
    }
    if (lastName == "") {
      // isLastNameEmpty.value = true;
      showFlash(
        context: Get.context!,
        duration: const Duration(seconds: 4),
        builder: (context, controller) {
          return CustomFlashBar(controller: controller,contentMessage: "LastName can not be empty",titleMessage: "Error",);
        },
      );
    } else {
      isLastNameEmpty.value = false;
    }
    if (ticketNumber != "" && lastName != "") {
      String token = await checkTravellerValidation(ticketNumber, lastName);
      if (token != "") {
        myStepScreenController.addToTravellers(token, lastName, ticketNumber);
        lastNameC.text = "";
        ticketNumberC.text = "";
        isTicketNumberEmpty.value = false;
        isLastNameEmpty.value = false;
      }else{
        showFlash(
          context: Get.context!,
          duration: const Duration(seconds: 4),
          builder: (context, controller) {
            return CustomFlashBar(controller: controller,contentMessage: "Wrong LastName or Booking reference name",titleMessage: "Error",);
          },
        );
      }
    }
  }

  Future<String> checkTravellerValidation(String ticketNumber, String lastName) async {
    String lastName = lastNameC.text.trim();
    String ticketNumber = ticketNumberC.text.trim();
    String token = model.token!;

    if (!model.requesting) {
      model.setRequesting(true);
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
          String? token = response.data["Body"]["Token"];
          model.setRequesting(false);
          return Future<String>.value(token);
        }
      }
    }
    model.setRequesting(false);
    return Future<String>.value("");
  }

  @override
  void onInit() {
    print("TravellersStepScreenController Init");
    super.onInit();
    init();
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
