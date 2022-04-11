import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:onlinecheckin/global/Classes.dart';
import 'package:onlinecheckin/screens/seatsStepScreen/SeatsStepController.dart';
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
  RxBool loading = false.obs;

  void init() async {
    loading.value = true;
    // model.setLoading(true);
    await finalReserve();
    final StepsScreenController stepsScreenController = Get.put(StepsScreenController(model));
    var req = {
      "Format": 1, //1->pdf    32->Html
      "PassengersId": "<MyTable><MyRow><FlightPax_ID>${stepsScreenController.travellers[0].welcome.body.passengers[0].id}</FlightPax_ID></MyRow></MyTable>",
      "IsDarkMode": false,
    };
    if (!model.requesting) {
      model.setRequesting(true);
      Response response = await DioClient.boardingPassPDF(
        mrtName: "OnlineCheckinBoardingPass-AB",
        token: stepsScreenController.travellers[0].token,
        request: req,
      );

      if (response.statusCode == 200) {
        boardingPassPDF = BoardingPassPDF.fromJson(response.data);
        convertToPDF();
        loading.value = false;
        successfulResponse.value = true;
        // model.setLoading(false);
        model.setRequesting(false);
        return;
      }
      loading.value = false;
      successfulResponse.value = false;
    }
    model.setRequesting(false);
    // model.setLoading(false);
  }

  void convertToPDF() async {
    String base64String = boardingPassPDF.buffer;
    bytes = base64Decode(base64String);
  }

  Future<bool> finalReserve() async {
    final myStepScreenController = Get.put(StepsScreenController(model));
    final seatsStepController = Get.put(SeatsStepController(model));
    List<Traveller> travellers = myStepScreenController.travellers;
    List<Map<String, dynamic>> seatsData = [];
    String token = "";
    travellers.where((t) => !seatsStepController.reservedSeats.containsKey(t.seatId)).toList().forEach((traveller) {
      token = traveller.token;
      String letter = traveller.seatId.substring(0, 1);
      int line = int.parse(traveller.seatId.substring(1));
      seatsData.add({
        "PassengerID": traveller.welcome.body.passengers[0].id,
        "Letter": letter,
        "Line": line,
      });
    });
    print(token);
    print(seatsData);
    if (!model.requesting) {
      model.setRequesting(true);
      Response response = await DioClient.reserveSeat(
        execution: "[OnlineCheckin].[ReserveSeat]",
        token: token,
        request: {"SeatsData": seatsData, "TicketData": null},
      );
      if (response.statusCode == 200) {
        if (response.data["ResultCode"] == 1) {
          final seatsStepController = Get.put(SeatsStepController(model));
          travellers.forEach((traveller) {
            seatsStepController.reservedSeats[traveller.seatId] = traveller.getNickName();
            seatsStepController.clickedOnSeats.remove(traveller.seatId);
          });
          model.setRequesting(false);
          return Future<bool>.value(true);
        }
      }
    }
    model.setRequesting(false);
    if (seatsStepController.reservedSeats.length == travellers.length) return true;
    model.setRequesting(false);
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
