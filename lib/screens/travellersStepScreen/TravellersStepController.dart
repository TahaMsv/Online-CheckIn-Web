import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
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
        myStepScreenController.addToTravellers(lastName);
        lastNameC.text = "";
        ticketNumberC.text = "";
        isTicketNumberEmpty.value = false;
        isLastNameEmpty.value = false;
      }
    }
  }

  Future<bool> checkTravellerValidation(String ticketNumber, String lastName) async {
    return true;
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
