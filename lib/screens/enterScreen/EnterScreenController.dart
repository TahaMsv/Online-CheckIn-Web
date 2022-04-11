import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:network_manager/network_manager.dart';
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenController.dart';
import 'package:onlinecheckin/utility/Constants.dart';

import '../../utility/DataProvider.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import 'package:dio/dio.dart';

class EnterScreenController extends MainController {
  EnterScreenController._();

  static final EnterScreenController _instance = EnterScreenController._();

  factory EnterScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  TextEditingController bookingRefNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();

  RxBool isLastNameEmpty = false.obs;
  RxBool isBookingRefNameEmpty = false.obs;

  Future<bool> checkBoxesValidation() async {
    String lastName = lastNameC.text;
    String bookingRefName = bookingRefNameC.text;
    if (bookingRefName == "") {
      isBookingRefNameEmpty.value = true;
    } else {
      isBookingRefNameEmpty.value = false;
    }
    if (lastName == "") {
      isLastNameEmpty.value = true;
    } else {
      isLastNameEmpty.value = false;
    }
    if (bookingRefName != "" && lastName != "") {
      isBookingRefNameEmpty.value = false;
      isLastNameEmpty.value = false;
      return true;
    }
    return false;
  }

  Future<bool> loginValidation() async {
    String lastName = lastNameC.text.trim();
    String bookingRefName = bookingRefNameC.text.trim();
    if(!model.requesting){
      model.setRequesting(true);
      Response response = await DioClient.getToken(
        execution: "[OnlineCheckin].[Authenticate]",
        token: null,
        request: {
          "Code": bookingRefName,
          "Code2": lastName,
          "UrlType": 1,
        },
      );
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data["ResultCode"] == 1) {
          String? token = response.data["Body"]["Token"];
          if (token != null) {
            model.setToken(token);
            StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
            stepsScreenController.addToTravellers(token, lastName, bookingRefName);
            model.setRequesting(false);
            return Future<bool>.value(true);
          }
        }
      }
    }
    print("not ok validation");
    model.setRequesting(false);
    return Future<bool>.value(false);
  }

  // initializeApp() async {
  //   // const String token =
  //   //     "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJUb2tlbktleSI6IjBmZmVmMzg0LWFlY2QtNDY0ZC1hMDRlLTRhZTAxODA4MWJmOSIsInJvbGUiOiJNZXJjaGFudCIsIm5iZiI6MTYyNTczNzc1NywiZXhwIjoxNjM0Mzc3NzU3LCJpYXQiOjE2MjU3Mzc3NTd9.hWGpASk2cn3pwxsMvnozhUT4KiZYOoRU55-Hp1cyEv4";
  //
  //   // model.token == null ? await initializeNetworkManager(baseURL: Apis.baseUrl) :
  //                         await initializeNetworkManager( baseURL: Apis.baseUrl);
  //
  //   // await initializePreferencesSettings();
  //   //
  //   // await initializeRoute();
  //   //
  //   // initializeLocalNotification();
  //   //
  //   // initializeFlutterFire();
  // }
  //
  // initializeNetworkManager({String? token, required String baseURL}) {
  //   NetworkOption.initialize(
  //       baseUrl: baseURL,
  //       timeout: 30000,
  //       // token: token,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         // "Authorization": "Bearer $token",
  //       },
  //       onStartDefault: () {
  //         print("Start");
  //         model.setLoading(true);
  //       },
  //       onEndDefault: () {
  //         print("End");
  //         model.setLoading(false);
  //       },
  //       onSuccessDefault: (res) {
  //         print("Success");
  //       },
  //       onFailedDefault: (NetworkResponse res) {
  //         print("Failed");
  //       },
  //       errorMsgExtractor: (res) {
  //         return res["Message"] ?? "Unknown Error";
  //       },
  //       successMsgExtractor: (res) {
  //         return res["Message"] ?? "Done";
  //       });
  // }
  //
  @override
  void onInit() {
    print("EnterScreenController Init");
    // initializeApp();
    super.onInit();
  }

  @override
  void onClose() {
    print("EnterScreenController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("EnterScreenController Ready");
    super.onReady();
  }

// initializeApp() async {
//   await initializeNetworkManager(baseURL: Apis.baseUrl);
//   // await initializePreferencesSettings();
//   //
//   // await initializeRoute();
//   //
//   // initializeLocalNotification();
//   //
//   // initializeFlutterFire();
// }

// initializeNetworkManager({required String baseURL}) {
//   print("baseurl: "+baseURL);
//   NetworkOption.initialize(
//       baseUrl: baseURL,
//       timeout: 30000,
//       token: null,
//       headers: {
//       'Content-Type': 'application/json',
//       // "Authorization": token,
//       },
//       onStartDefault: () {
//         print("Start");
//         model.setLoading(true);
//       },
//       onEndDefault: () {
//         print("End");
//         model.setLoading(false);
//       },
//       onSuccessDefault: (res) {
//         print("Success");
//       },
//       onFailedDefault: (NetworkResponse res) {
//         print("Failed");
//       },
//       errorMsgExtractor: (res) {
//         return res["Message"] ?? "Unknown Error";
//       },
//       successMsgExtractor: (res) {
//         return res["Message"] ?? "Done";
//       });
// }

}
