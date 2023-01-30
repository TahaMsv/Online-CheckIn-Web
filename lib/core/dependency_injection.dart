import 'package:get_it/get_it.dart';
import 'package:network_manager/network_manager.dart';
import 'package:online_checkin_web_refactoring/core/platform/network_info.dart';
import '../screens/Passport/data_source/passport_local_ds.dart';
import '../screens/Passport/data_source/passport_remote_ds.dart';
import '../screens/Passport/passport_controller.dart';
import '../screens/Passport/passport_repository.dart';
import '../screens/Passport/passport_state.dart';
import '../screens/Visa/data_source/visa_local_ds.dart';
import '../screens/Visa/data_source/visa_remote_ds.dart';
import '../screens/Visa/visa_controller.dart';
import '../screens/Visa/visa_repository.dart';
import '../screens/Visa/visa_state.dart';
import '../screens/addTraveler/add_traveler_controller.dart';
import '../screens/addTraveler/add_traveler_repository.dart';
import '../screens/addTraveler/add_traveler_state.dart';
import '../screens/addTraveler/data_source/add_traveler_local_ds.dart';
import '../screens/addTraveler/data_source/add_traveler_remote_ds.dart';
import '../screens/login/data_sources/login_local_ds.dart';
import '../screens/login/data_sources/login_remote_ds.dart';
import '../screens/login/login_controller.dart';
import '../screens/login/login_repository.dart';
import '../screens/login/login_state.dart';
import '../screens/payment/data_source/payment_local_ds.dart';
import '../screens/payment/data_source/payment_remote_ds.dart';
import '../screens/payment/payment_controller.dart';
import '../screens/payment/payment_repository.dart';
import '../screens/payment/payment_state.dart';
import '../screens/receipt/data_source/receipt_local_ds.dart';
import '../screens/receipt/data_source/receipt_remote_ds.dart';
import '../screens/receipt/receipt_controller.dart';
import '../screens/receipt/receipt_repository.dart';
import '../screens/receipt/receipt_state.dart';
import '../screens/rules/data_source/rules_remote_ds.dart';
import '../screens/rules/rules_controller.dart';
import '../screens/rules/rules_repository.dart';
import '../screens/rules/rules_state.dart';
import '../screens/safety/data_source/safety_remote_ds.dart';
import '../screens/safety/safety_controller.dart';
import '../screens/safety/safety_repository.dart';
import '../screens/safety/safety_state.dart';
import '../screens/seat_map/data_source/seat_map_local_ds.dart';
import '../screens/seat_map/data_source/seat_map_remote_ds.dart';
import '../screens/seat_map/seat_map_controller.dart';
import '../screens/seat_map/seat_map_repository.dart';
import '../screens/seat_map/seat_map_state.dart';
import '../screens/steps/data_source/steps_local_ds.dart';
import '../screens/steps/data_source/steps_remote_ds.dart';
import '../screens/steps/steps_controller.dart';
import '../screens/steps/steps_repository.dart';
import '../screens/steps/steps_state.dart';
import '../screens/upgrades/data_source/upgrades_local_ds.dart';
import '../screens/upgrades/data_source/upgrades_remote_ds.dart';
import '../screens/upgrades/upgrades_controller.dart';
import '../screens/upgrades/upgrades_repository.dart';
import '../screens/upgrades/upgrades_state.dart';
import 'constants/route_names.dart';
import 'database/share_pref.dart';
import 'navigation/navigation_service.dart';
import 'navigation/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:artemis_utils/artemis_utils.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initNetworkManager();
  // initFullScreen();

  SharedPreferences sp = await SharedPreferences.getInstance();
  // ObjectBox objectBox = await ObjectBox.create();
  Connectivity connectivity = Connectivity();
  NetworkInfo networkInfo = NetworkInfo(connectivity);
  // MyDeviceInfo deviceInfo = await DeviceUtility.getInfo();
  //
  // ImageCatcher imageCatcher = ImageCatcher(sp);
  SharedPrefService sharedPrefService = SharedPrefService(sp);
  NavigationService navigationService = NavigationService();

  getIt.registerSingleton(navigationService);
  getIt.registerSingleton(sharedPrefService);
  // getIt.registerSingleton(deviceInfo);
  // getIt.registerSingleton(imageCatcher);

  ///login-------------------------------------------------------------------------------------------------------------------

  ///state
  LoginState loginState = LoginState();
  getIt.registerLazySingleton(() => loginState);

  ///data-sources
  LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource(
    sharedPreferences: sp,
  );
  LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSource(loginLocalDataSource);

  ///repository
  LoginRepository loginRepository = LoginRepository(
    loginRemoteDataSource: loginRemoteDataSource,
    loginLocalDataSource: loginLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => loginRepository);

  ///controller
  LoginController loginController = LoginController();
  getIt.registerLazySingleton(() => loginController);
  navigationService.registerController(RouteNames.login, loginController);

  ///Steps-------------------------------------------------------------------------------------------------------------------

  ///state
  StepsState stepsState = StepsState();
  getIt.registerLazySingleton(() => stepsState);

  ///data-sources
  StepsLocalDataSource stepsLocalDataSource = StepsLocalDataSource(sharedPreferences: sp);
  StepsRemoteDataSource stepsRemoteDataSource = StepsRemoteDataSource();

  ///repository
  StepsRepository stepsRepository = StepsRepository(
    stepsRemoteDataSource: stepsRemoteDataSource,
    stepsLocalDataSource: stepsLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => stepsRepository);

  ///controller
  StepsController stepsController = StepsController();
  getIt.registerLazySingleton(() => stepsController);
  navigationService.registerController(RouteNames.steps, stepsController);

  ///AddTraveler-------------------------------------------------------------------------------------------------------------------

  ///state
  AddTravelerState addTravelerState = AddTravelerState();
  getIt.registerLazySingleton(() => addTravelerState);

  ///data-sources
  AddTravelerLocalDataSource addTravelerLocalDataSource = AddTravelerLocalDataSource(
    sharedPreferences: sp,
  );
  AddTravelerRemoteDataSource addTravelerRemoteDataSource = AddTravelerRemoteDataSource();

  ///repository
  AddTravelerRepository addTravelerRepository = AddTravelerRepository(
    addTravelerRemoteDataSource: addTravelerRemoteDataSource,
    addTravelerLocalDataSource: addTravelerLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => addTravelerRepository);

  ///controller
  AddTravelerController addTravelerController = AddTravelerController();
  getIt.registerLazySingleton(() => addTravelerController);
  navigationService.registerController(RouteNames.addTraveler, addTravelerController);

  ///Rules-------------------------------------------------------------------------------------------------------------------

  ///state
  RulesState rulesState = RulesState();
  getIt.registerLazySingleton(() => rulesState);

  ///data-sources
  // RulesLocalDataSource rulesLocalDataSource = RulesLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  RulesRemoteDataSource rulesRemoteDataSource = RulesRemoteDataSource();

  ///repository
  RulesRepository rulesRepository = RulesRepository(
    rulesRemoteDataSource: rulesRemoteDataSource,
    // rulesLocalDataSource: rulesLocalDataSource,
    // networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => rulesRepository);

  ///controller
  RulesController rulesController = RulesController();
  getIt.registerLazySingleton(() => rulesController);
  navigationService.registerController(RouteNames.rules, rulesController);

  ///Safety-------------------------------------------------------------------------------------------------------------------

  ///state
  SafetyState safetyState = SafetyState();
  getIt.registerLazySingleton(() => safetyState);

  ///data-sources
  // SafetyLocalDataSource safetyLocalDataSource = SafetyLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  SafetyRemoteDataSource safetyRemoteDataSource = SafetyRemoteDataSource();

  ///repository
  SafetyRepository safetyRepository = SafetyRepository(
    safetyRemoteDataSource: safetyRemoteDataSource,
    // safetyLocalDataSource: safetyLocalDataSource,
    // networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => safetyRepository);

  ///controller
  SafetyController safetyController = SafetyController();
  getIt.registerLazySingleton(() => safetyController);
  navigationService.registerController(RouteNames.safety, safetyController);

  ///Passport-------------------------------------------------------------------------------------------------------------------

  ///state
  PassportState passportState = PassportState();
  getIt.registerLazySingleton(() => passportState);

  ///data-sources
  PassportLocalDataSource passportLocalDataSource = PassportLocalDataSource(sharedPreferences: sp);
  PassportRemoteDataSource passportRemoteDataSource = PassportRemoteDataSource();

  ///repository
  PassportRepository passportRepository = PassportRepository(
    passportRemoteDataSource: passportRemoteDataSource,
    passportLocalDataSource: passportLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => passportRepository);

  ///controller
  PassportController passportController = PassportController();
  getIt.registerLazySingleton(() => passportController);
  navigationService.registerController(RouteNames.passport, passportController);

  ///Visa-------------------------------------------------------------------------------------------------------------------

  ///state
  VisaState visaState = VisaState();
  getIt.registerLazySingleton(() => visaState);

  ///data-sources
  VisaLocalDataSource visaLocalDataSource = VisaLocalDataSource(sharedPreferences: sp);
  VisaRemoteDataSource visaRemoteDataSource = VisaRemoteDataSource();

  ///repository
  VisaRepository visaRepository = VisaRepository(
    visaRemoteDataSource: visaRemoteDataSource,
    visaLocalDataSource: visaLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => visaRepository);

  ///controller
  VisaController visaController = VisaController();
  getIt.registerLazySingleton(() => visaController);
  navigationService.registerController(RouteNames.visa, visaController);

  ///Upgrades-------------------------------------------------------------------------------------------------------------------

  ///state
  UpgradesState upgradesState = UpgradesState();
  getIt.registerLazySingleton(() => upgradesState);

  ///data-sources
  UpgradesLocalDataSource upgradesLocalDataSource = UpgradesLocalDataSource(sharedPreferences: sp);
  UpgradesRemoteDataSource upgradesRemoteDataSource = UpgradesRemoteDataSource();

  ///repository
  UpgradesRepository upgradesRepository = UpgradesRepository(
    upgradesRemoteDataSource: upgradesRemoteDataSource,
    upgradesLocalDataSource: upgradesLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => upgradesRepository);

  ///controller
  UpgradesController upgradesController = UpgradesController();
  getIt.registerLazySingleton(() => upgradesController);
  navigationService.registerController(RouteNames.upgrades, upgradesController);

  ///SeatMap-------------------------------------------------------------------------------------------------------------------

  ///state
  SeatMapState seatMapState = SeatMapState();
  getIt.registerLazySingleton(() => seatMapState);

  ///data-sources
  SeatMapLocalDataSource seatMapLocalDataSource = SeatMapLocalDataSource(sharedPreferences: sp);
  SeatMapRemoteDataSource seatMapRemoteDataSource = SeatMapRemoteDataSource();

  ///repository
  SeatMapRepository seatMapRepository = SeatMapRepository(
    seatMapRemoteDataSource: seatMapRemoteDataSource,
    seatMapLocalDataSource: seatMapLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => seatMapRepository);

  ///controller
  SeatMapController seatMapController = SeatMapController();
  getIt.registerLazySingleton(() => seatMapController);
  navigationService.registerController(RouteNames.seatMap, seatMapController);


    ///Payment-------------------------------------------------------------------------------------------------------------------

    ///state
    PaymentState paymentState = PaymentState();
    getIt.registerLazySingleton(() => paymentState);

    ///data-sources
    PaymentLocalDataSource paymentLocalDataSource = PaymentLocalDataSource(sharedPreferences: sp);
    PaymentRemoteDataSource paymentRemoteDataSource = PaymentRemoteDataSource();

    ///repository
    PaymentRepository paymentRepository = PaymentRepository(
      paymentRemoteDataSource: paymentRemoteDataSource,
      paymentLocalDataSource: paymentLocalDataSource,
      networkInfo: networkInfo,
    );
    getIt.registerLazySingleton(() => paymentRepository);

    ///controller
    PaymentController paymentController = PaymentController();
    getIt.registerLazySingleton(() => paymentController);
    navigationService.registerController(RouteNames.payment, paymentController);

  ///Receipt-------------------------------------------------------------------------------------------------------------------

  ///state
  ReceiptState receptState = ReceiptState();
  getIt.registerLazySingleton(() => receptState);

  ///data-sources
  ReceiptLocalDataSource receptLocalDataSource = ReceiptLocalDataSource(sharedPreferences: sp);
  ReceiptRemoteDataSource receptRemoteDataSource = ReceiptRemoteDataSource();

  ///repository
  ReceiptRepository receptRepository = ReceiptRepository(
    receiptRemoteDataSource: receptRemoteDataSource,
    receiptLocalDataSource: receptLocalDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => receptRepository);

  ///controller
  ReceiptController receptController = ReceiptController();
  getIt.registerLazySingleton(() => receptController);
  navigationService.registerController(RouteNames.receipt, receptController);

  MyRouter.initialize();
}

initNetworkManager() {
  NetworkOption.initialize(
    timeout: 60000,
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
