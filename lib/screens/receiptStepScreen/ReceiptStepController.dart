import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/global/Classes.dart';
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

  late BoardingPassPDF boardingPassPDF;

  void init() async {
    // "Token": "1B690A28-96B3-4F0A-AED6-FDD4B6C6893D",
    // "MrtName": "OnlineCheckinBoardingPass-AB",
    // "Request": {
    // "Format": 1, //1->pdf    32->Html
    // "PassengersId": "<MyTable><MyRow><FlightPax_ID>590529</FlightPax_ID></MyRow></MyTable>",
    // "IsDarkMode": false
    // }
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    Response response = await DioClient.boardingPassPDF(
      mrtName: "OnlineCheckinBoardingPass-AB",
      token: stepsScreenController.travellers[0].token,
      request: {
        "Format": 1, //1->pdf    32->Html
        "PassengersId": stepsScreenController.travellers[0].welcome.body.passengers[0].id,
        "IsDarkMode": false,
      },
    );

    if (response.statusCode == 200) {
      if (response.data["ResultCode"] == 1) {
        boardingPassPDF = BoardingPassPDF.fromJson(response.data);
      }
    } else {}
  }

  void convertToPDF() async {
    // String buffer = boardingPassPDF.buffer;
    // String fileName = "boardingPassPdf";
    // final dir = await getExternalStorageDirectory();
    // final file = File("${dir.path}/$fileName.pdf");
    // await file.writeAsBytes(buffer.codeUnits);
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
