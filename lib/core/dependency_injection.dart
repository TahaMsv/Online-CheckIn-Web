import 'package:get_it/get_it.dart';
import 'package:network_manager/network_manager.dart';
import '../screens/addTraveler/add_traveler_controller.dart';
import '../screens/addTraveler/add_traveler_repository.dart';
import '../screens/addTraveler/add_traveler_state.dart';
import '../screens/addTraveler/data_source/add_traveler_remote_ds.dart';
import '../screens/login/data_sources/login_remote_ds.dart';
import '../screens/login/login_controller.dart';
import '../screens/login/login_repository.dart';
import '../screens/login/login_state.dart';
import '../screens/steps/data_source/steps_remote_ds.dart';
import '../screens/steps/steps_cotroller.dart';
import '../screens/steps/steps_repository.dart';
import '../screens/steps/steps_state.dart';
import 'constants/route_names.dart';
import 'navigation/navigation_service.dart';
import 'navigation/router.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initNetworkManager();
  // initFullScreen();

  // SharedPreferences sp = await SharedPreferences.getInstance();
  // ObjectBox objectBox = await ObjectBox.create();
  // Connectivity connectivity = Connectivity();
  // NetworkInfo networkInfo = NetworkInfo(connectivity);
  // MyDeviceInfo deviceInfo = await DeviceUtility.getInfo();
  //
  // ImageCatcher imageCatcher = ImageCatcher(sp);
  // SharedPrefService sharedPrefService = SharedPrefService(sp);
  NavigationService navigationService = NavigationService();

  getIt.registerSingleton(navigationService);
  // getIt.registerSingleton(sharedPrefService);
  // getIt.registerSingleton(deviceInfo);
  // getIt.registerSingleton(imageCatcher);

  ///login-------------------------------------------------------------------------------------------------------------------

  ///state
  LoginState loginState = LoginState();
  getIt.registerLazySingleton(() => loginState);

  ///data-sources
  // LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSource();

  ///repository
  LoginRepository loginRepository = LoginRepository(
    loginRemoteDataSource: loginRemoteDataSource,
    // loginLocalDataSource: loginLocalDataSource,
    // networkInfo: networkInfo,
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
  // StepsLocalDataSource stepsLocalDataSource = StepsLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  StepsRemoteDataSource stepsRemoteDataSource = StepsRemoteDataSource();

  ///repository
  StepsRepository stepsRepository = StepsRepository(
    stepsRemoteDataSource: stepsRemoteDataSource,
    // stepsLocalDataSource: stepsLocalDataSource,
    // networkInfo: networkInfo,
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
  // AddTravelerLocalDataSource addTravelerLocalDataSource = AddTravelerLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  AddTravelerRemoteDataSource addTravelerRemoteDataSource = AddTravelerRemoteDataSource();

  ///repository
  AddTravelerRepository addTravelerRepository = AddTravelerRepository(
    addTravelerRemoteDataSource: addTravelerRemoteDataSource,
    // addTravelerLocalDataSource: addTravelerLocalDataSource,
    // networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => addTravelerRepository);

  ///controller
  AddTravelerController addTravelerController = AddTravelerController();
  getIt.registerLazySingleton(() => addTravelerController);
  navigationService.registerController(RouteNames.addTraveler, addTravelerController);

  //
  // ///home-------------------------------------------------------------------------------------------------------------------
  //
  // ///state
  // HomeState homeState = HomeState();
  // getIt.registerLazySingleton(() => homeState);
  //
  // ///data-sources
  // HomeLocalDataSource homeLocalDataSource = HomeLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  // HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource(homeLocalDataSource);
  //
  // ///repository
  // HomeRepository homeRepository = HomeRepository(
  //   homeRemoteDataSource: homeRemoteDataSource,
  //   homeLocalDataSource: homeLocalDataSource,
  //   networkInfo: networkInfo,
  // );
  // getIt.registerLazySingleton(() => homeRepository);
  //
  // ///controller
  // HomeController homeController = HomeController();
  // getIt.registerLazySingleton(() => homeController);
  // navigationService.registerController(RouteNames.home, homeController);
  //
  // ///checkin-------------------------------------------------------------------------------------------------------------------
  //
  // ///state
  // CheckinState checkinState = CheckinState();
  // getIt.registerLazySingleton(() => checkinState);
  //
  // ///data-sources
  // CheckinLocalDataSource checkinLocalDataSource = CheckinLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  // CheckinRemoteDataSource checkinRemoteDataSource = CheckinRemoteDataSource(checkinLocalDataSource);
  //
  // ///repository
  // CheckinRepository checkinRepository = CheckinRepository(
  //   checkinRemoteDataSource: checkinRemoteDataSource,
  //   checkinLocalDataSource: checkinLocalDataSource,
  //   networkInfo: networkInfo,
  // );
  // getIt.registerLazySingleton(() => checkinRepository);
  //
  // ///controller
  // CheckinController checkinController = CheckinController();
  // getIt.registerLazySingleton(() => checkinController);
  // navigationService.registerController(RouteNames.checkin, checkinController);

  // ///addFlight
  //
  // ///state
  // AddFlightState addFlightState = AddFlightState();
  // getIt.registerLazySingleton(() => addFlightState);
  //
  // ///data-sources
  // AddFlightLocalDataSource addFlightLocalDataSource = AddFlightLocalDataSource(sharedPreferences: sp, objectBox: objectBox);
  // AddFlightRemoteDataSource addFlightRemoteDataSource = AddFlightRemoteDataSource(addFlightLocalDataSource);
  //
  // ///repository
  // AddFlightRepository addFlightRepository = AddFlightRepository(
  //   addFlightRemoteDataSource: addFlightRemoteDataSource,
  //   addFlightLocalDataSource: addFlightLocalDataSource,
  //   networkInfo: networkInfo,
  // );
  // getIt.registerLazySingleton(() => addFlightRepository);
  //
  // ///controller
  // AddFlightController addFlightController = AddFlightController();
  // getIt.registerLazySingleton(() => addFlightController);
  // navigationService.registerController(RouteNames.addFlight, addFlightController);

  MyRouter.initialize();
}

initNetworkManager() {
  NetworkOption.initialize(
    timeout: 100000000000,
    extraSuccessRule: (NetworkResponse nr) {
      int statusCode = int.parse((nr.responseBody["Status"]?.toString() ?? nr.responseBody["ResultCode"]?.toString() ?? "0"));
      return nr.responseCode == 200 && statusCode > 0;
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
