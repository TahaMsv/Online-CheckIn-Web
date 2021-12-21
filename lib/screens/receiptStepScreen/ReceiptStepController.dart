
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../utility/DataProvider.dart';

import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class ReceiptStepController extends MainController {
  ReceiptStepController._();

  static final ReceiptStepController _instance = ReceiptStepController._();

  factory ReceiptStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  void init() async{
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    Response response = await DioClient.selectCountries(
      execution: "[OnlineCheckin].[SelectBoardingPass]",
      token: stepsScreenController.travellers[0].token,
      request: {
        "PassengersId": stepsScreenController.travellers[0].welcome.body.passengers[0].id
      },
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {

        }
      }
    else {}
  }


  @override
  void onInit() {
    print("ReceiptStepController Init");
    init();
    super.onInit();
  }

  @override
  void onClose() {
    print("ReceiptStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("ReceiptStepController Ready");
    super.onReady();
  }
}
