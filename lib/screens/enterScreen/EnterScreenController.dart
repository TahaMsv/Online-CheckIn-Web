import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

// import 'package:network_manager/network_manager.dart';
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
  TextEditingController firstNameC = TextEditingController();

  RxBool isLastNameEmpty = false.obs;
  RxBool isFirstNameEmpty = false.obs;
  RxBool isBookingRefNameEmpty = false.obs;

  Future<bool> checkBoxesValidation() async {
    String firstName = firstNameC.text;
    String lastName = lastNameC.text;
    String bookingRefName = bookingRefNameC.text;
    if (firstName == "") {
      isFirstNameEmpty.value = true;
    } else {
      isFirstNameEmpty.value = false;
    }
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
    if (bookingRefName != "" && lastName != "" && firstName != "") {
      bool isValid = await checkTravellerValidation(firstName, lastName, bookingRefName);
      if (isValid) {
        firstNameC.text = "";
        lastNameC.text = "";
        bookingRefNameC.text = "";
        isBookingRefNameEmpty.value = false;
        isLastNameEmpty.value = false;
        isFirstNameEmpty.value = false;
        return true;
      }
    }
    return false;
  }

  Future<bool> checkTravellerValidation(String firstName, String lastName, String bookingRefName) async {
    return true;
  }

  Future<bool> loginValidation() async {
    Response response = await DioClient.getToken(
      execution: "[OnlineCheckin].[Authenticate]",
      token: null,
      request: {"Code": "9999999999", "Code2": "2999", "UrlType": 4},
    );

    if (response.statusCode == 200) {
      String? token = response.data["Body"]["Token"];
      if (token != null) {
        model.setToken(token);
        print(token);
        print("ok validation");
      }
      return Future<bool>.value(true);
    }
    print("not ok validation");
    return Future<bool>.value(false);
  }

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
