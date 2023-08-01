import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network_manager/network_manager.dart';
import 'package:online_check_in/screens/Passport/passport_controller.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/addTraveler/add_traveler_controller.dart';
import 'package:online_check_in/screens/login/login_controller.dart';
import 'package:online_check_in/screens/payment/payment_controller.dart';
import 'package:online_check_in/screens/receipt/receipt_controller.dart';
import 'package:online_check_in/screens/rules/rules_controller.dart';
import 'package:online_check_in/screens/safety/safety_controller.dart';
import 'package:online_check_in/screens/seat_map/seat_map_controller.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/upgrades/upgrades_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/navigation/navigation_service.dart';
import 'core/platform/network_info.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeDateFormatting("EN",'');
  // getIt.registerSingleton(ref);

  getIt.allowReassignment = true;

  Connectivity connectivity = Connectivity();
  NetworkInfo networkInfo = NetworkInfo(connectivity);
  getIt.registerSingleton(networkInfo);

  NavigationService navigationService = NavigationService();
  getIt.registerSingleton(navigationService);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPreferences);

  // LocalDataBase localDataBase = LocalDataBase();
  // getIt.registerSingleton(localDataBase);

  // MyDeviceInfo deviceInfo = await DeviceUtility.getInfo();
  // DeviceInfoService deviceInfoService = DeviceInfoService(deviceInfo);
  // getIt.registerSingleton(deviceInfoService);
}

initControllers() {
  if (getIt.isRegistered(instance: LoginController)) {
    return;
  }
  LoginController loginController = LoginController();
  AddTravelerController addTravelerController = AddTravelerController();
  PassportController passportController = PassportController();
  PaymentController paymentController = PaymentController();
  ReceiptController receiptController = ReceiptController();
  RulesController rulesController = RulesController();
  SafetyController safetyController = SafetyController();
  SeatMapController seatMapController = SeatMapController();
  StepsController stepsController = StepsController();
  UpgradesController upgradesController = UpgradesController();
  VisaController visaController = VisaController();

  getIt.registerSingleton(loginController);
  getIt.registerSingleton(addTravelerController);
  getIt.registerSingleton(passportController);
  getIt.registerSingleton(paymentController);
  getIt.registerSingleton(receiptController);
  getIt.registerSingleton(rulesController);
  getIt.registerSingleton(safetyController);
  getIt.registerSingleton(seatMapController);
  getIt.registerSingleton(stepsController);
  getIt.registerSingleton(upgradesController);
  getIt.registerSingleton(visaController);
}

void initFullScreen() async {}

initNetworkManager() {
  NetworkOption.initialize(
    timeout: 60000,
    headers: {
      'Content-Type': 'application/json',
    },
    extraSuccessRule: (NetworkResponse nr) {
      if (nr.responseCode != 200) return false;
      int statusCode = int.tryParse((nr.responseBody["Status"]?.toString() ?? nr.responseBody["ResultCode"]?.toString() ?? "0")) ?? 0;
      return statusCode > 0;
    },
    successMsgExtractor: (data) {
      return (data["Message"] ?? data["ResultText"] ?? "Done").toString();
    },
    errorMsgExtractor: (data) {
      return (data["Message"] ?? data["ResultText"] ?? "Unknown Error").toString();
    },
    tokenExpireRule: (NetworkResponse res) {
      return res.extractedMessage?.contains("Token Expired") ?? false;
    },
    //   onTokenExpire: (NetworkResponse res) {
    // HomeController homeController = getIt<HomeController>();
    // homeController.logout();
    // }
  );
}
