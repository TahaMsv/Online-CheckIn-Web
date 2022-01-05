import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/global/Classes.dart';
import '../../screens/stepsScreen/StepsScreenController.dart';
import '../../utility/DataProvider.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class ReceiptStepController extends MainController {
  MainModel model;

  ReceiptStepController(this.model);

  late BoardingPassPDF boardingPassPDF;
  late Uint8List bytes;
  RxBool successfulResponse = false.obs;
  RxBool loading=false.obs;

  void init() async {
    loading.value=true;
    // model.setLoading(true);
    await finalReserve();
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    print("aa");
    var req = {
      "Format": 1, //1->pdf    32->Html
      "PassengersId": "<MyTable><MyRow><FlightPax_ID>${stepsScreenController.travellers[0].welcome.body.passengers[0].id}</FlightPax_ID></MyRow></MyTable>",
      "IsDarkMode": false,
    };
    print(req);
    Response response = await DioClient.boardingPassPDF(
      mrtName: "OnlineCheckinBoardingPass-AB",
      token: stepsScreenController.travellers[0].token,
      request: req,
    );
    print("aa1");

    if (response.statusCode == 200) {
      print("here1");
      boardingPassPDF = BoardingPassPDF.fromJson(response.data);
      print("here2");
      convertToPDF();
      print("here4");
      loading.value=false;
      successfulResponse.value = true;
      // model.setLoading(false);
      return;
    }
    print("here5");
    loading.value=false;
    successfulResponse.value = false;
    // model.setLoading(false);
  }

  void convertToPDF() async {
    print("here3");
    String base64String = boardingPassPDF.buffer;
    bytes = base64Decode(base64String);
  }

  Future<bool> finalReserve() async {
    print("here11");
    final myStepScreenController = Get.put(StepsScreenController(model));
    List<Traveller> travellers = myStepScreenController.travellers;
    List<Map<String, dynamic>> seatsData = [];
    print("here12");
    for (var i = 0; i < travellers.length; ++i) {
      Traveller traveller = travellers[i];
      String letter = traveller.seatId.substring(0, 1);
      int line = int.parse(traveller.seatId.substring(1));
      seatsData.add({
        "PassengerID": traveller.welcome.body.passengers[i].id,
        "Letter": letter,
        "Line": line,
      });
    }
    print(seatsData);
    print("here13");
    Response response = await DioClient.reserveSeat(
      execution: "[OnlineCheckin].[ReserveSeat]",
      token: travellers[0].token,
      request: {"SeatsData": seatsData, "TicketData": null},
    );
    print("here14");

    print(jsonEncode(response.data));
    if (response.statusCode == 200) {
      print("here15");
      if (response.data["ResultCode"] == 1) {
        print("here16");

        return Future<bool>.value(true);
      }
    }
    print("here17");

    return Future<bool>.value(false);
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
