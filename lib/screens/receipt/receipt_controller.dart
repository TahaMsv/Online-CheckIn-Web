import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/receipt/receipt_repository.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import 'package:online_check_in/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_check_in/screens/receipt/usecases/reserve_seat_usecase.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../core/classes/Traveler.dart';
import '../../core/classes/boarding_pass_pdf.dart';
import '../../core/classes/seat_data.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';
import '../steps/steps_state.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ReceiptController extends MainController {
  final ReceiptState receiptState = getIt<ReceiptState>();
  final ReceiptRepository receiptRepository = getIt<ReceiptRepository>();

  late GetBoardingPassPdfUseCase getBoardingPassPdfUseCase = GetBoardingPassPdfUseCase(repository: receiptRepository);
  late ReserveSeatUseCase reserveSeatUseCase = ReserveSeatUseCase(repository: receiptRepository);

  Future<bool> getBoardingPassPDF() async {
    print("30 at boardinpass");
    receiptState.setLoading(true);
    final StepsState stepsState = getIt<StepsState>();
    var req = {
      "Format": 1, //1->pdf    32->Html
      "PassengersId": "<MyTable><MyRow><FlightPax_ID>${stepsState.travelers[0].flightInformation.passengers[0].id}</FlightPax_ID></MyRow></MyTable>",
      "IsDarkMode": false,
    };

    Response response;
    try {
      print("41 at boardinpass");
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.post('https://onlinecheckinapi.abomis.com/api/MemoStrm', data: {
        "Body": {
          "MrtName": "OnlineCheckinBoardingPass-AB",
          "Token": stepsState.travelers[0].token,
          "Request": req,
        },
      });
      print("51 at boardinpass");
      if (response.statusCode == 200) {
        print("53 at boardinpass");
        receiptState.setBoardingPassPDF(BoardingPassPDF.fromJson(response.data));
        convertToPDF();
        print("56 at receipt");
        receiptState.setLoading(false);
        print("58 at receipt");
        receiptState.setSuccessfulResponse(true);
        print("60 at receipt");
        receiptState.setLoading(false);
        stepsState.setLoading(false);
        return true;
      }
      print("65 at boardinpass");
      receiptState.setLoading(false);
      stepsState.setLoading(false);
    } catch (err) {
      print("69 at boardinpass");
      receiptState.setLoading(false);
      stepsState.setLoading(false);
      return false;
    }
    print("73 at boardinpass");
    receiptState.setLoading(false);
    stepsState.setLoading(false);
    return false;
  }

  void convertToPDF() async {
    String base64String = receiptState.boardingPassPDF.buffer;
    receiptState.setBytes(base64Decode(base64String));
  }

  Future<bool> finalReserve() async {
    if (receiptState.isReserved) return true;
    final StepsState stepsState = getIt<StepsState>();
    final SeatMapState seatMapState = getIt<SeatMapState>();
    stepsState.setLoading(true);
    List<Traveler> travellers = stepsState.travelers;
    List<SeatData> seatsData = [];
    travellers.where((t) => !seatMapState.reservedSeats.containsKey(t.seatId)).toList().forEach((traveler) {
      seatsData.add(SeatData(passengerId: traveler.flightInformation.passengers.last.id, letter: traveler.seatId.substring(0, 1), line: int.parse(traveler.seatId.substring(1))));
    });

    ReserveSeatRequest reserveSeatRequest = ReserveSeatRequest(seatsData: seatsData);
    final fOrRS = await reserveSeatUseCase(request: reserveSeatRequest);
    print("65 at receipt");
    bool returnedValue = false;
    fOrRS.fold((f) => FailureHandler.handle(f, retry: () => getBoardingPassPDF()), (successful) async {
      print("68 at receipt");
      if (successful) {
        print("69 at receipt");
        final SeatMapState seatMapState = getIt<SeatMapState>();
        print(travellers);
        for (Traveler traveller in travellers) {
          seatMapState.reservedSeats[traveller.seatId] = traveller.getNickName();
          seatMapState.clickedOnSeats.remove(traveller.seatId);
          receiptState.setIsReserved(true);
        }
      }
      print("77 at receipt");
      returnedValue = successful;
    });
    print("80 at receipt");
    stepsState.setLoading(false);
    return returnedValue;
  }

  void saveBoardingPassPDF(BuildContext context) async {
    var file = File('');
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        const downloadsFolderPath = '/storage/emulated/0/Download/';
        Directory dir = Directory(downloadsFolderPath);
        file = File('${dir.path}BoardingpassPDF.pdf');
      }
    }

    final byteData = receiptState.bytes;
    try {
      PdfDocument document = PdfDocument(inputBytes: receiptState.bytes);
      List<int> bytes = await document.save();
      await file.writeAsBytes(bytes);
      String message = "File saved in: ";
      if (context.mounted) message = message.translate(context);
      nav.snackbar(Text(message + file.path, style: TextStyle(fontSize: 17)), backgroundColor: MyColors.green);
    } on FileSystemException catch (err) {
      // handle error
      print(err.message);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
