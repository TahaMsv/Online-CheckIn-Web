import '../../utility/Constants.dart';
import 'package:get/get.dart';
import 'package:network_manager/network_manager.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class SplashController extends MainController {
  SplashController._();
  static final SplashController _instance = SplashController._();
  factory SplashController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  RxBool loadingSplash = false.obs;

  justLoadSplash(){
    loadingSplash.toggle();
  }

  @override
  void onInit() {
    print("Splash Init");
    super.onInit();
  }


  initializeApp() async {
    await initializeNetworkManager(baseURL: Apis.baseUrl);

    await initializePreferencesSettings();

    await initializeRoute();

    initializeLocalNotification();

    initializeFlutterFire();
  }

  initializeNetworkManager({String? token, required String baseURL}) {
    NetworkOption.initialize(
        baseUrl: baseURL,
        timeout: 30000,
        token: token,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        onStartDefault: () {
          print("Start");
          model.setLoading(true);
        },
        onEndDefault: () {
          print("End");
          model.setLoading(false);
        },
        onSuccessDefault: (res) {
          print("Success");
        },
        onFailedDefault: (NetworkResponse res) {
          print("Failed");
        },
        errorMsgExtractor: (res) {
          return res["Message"] ?? "Unknown Error";
        },
        successMsgExtractor: (res) {
          return res["Message"] ?? "Done";
        });
  }

  Future<void> initializeFlutterFire() async {
  }

  Future<void> initializeRoute() async {

  }

  Future<void> initializePreferencesSettings() async {

  }

  Future<void> initializeLocalNotification() async {

  }



}