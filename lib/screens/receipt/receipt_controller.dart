import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:online_check_in/screens/receipt/receipt_repository.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import 'package:online_check_in/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_check_in/screens/receipt/usecases/reserve_seat_usecase.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';

import '../../core/classes/Traveler.dart';
import '../../core/classes/boarding_pass_pdf.dart';
import '../../core/classes/seat_data.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';
import '../steps/steps_state.dart';

class ReceiptController extends MainController {
  final ReceiptState receiptState = getIt<ReceiptState>();
  final ReceiptRepository receiptRepository = getIt<ReceiptRepository>();

  late GetBoardingPassPdfUseCase getBoardingPassPdfUseCase = GetBoardingPassPdfUseCase(repository: receiptRepository);
  late ReserveSeatUseCase reserveSeatUseCase = ReserveSeatUseCase(repository: receiptRepository);

  void init() async {
    receiptState.setLoading(true);
    // model.setLoading(true);
    print("27 at receipt");
    // await finalReserve();
    print("29 at receipt");
    // final StepsState stepsState = getIt<StepsState>();
    //
    // GetBoardingPassPdfRequest getBoardingPassPdfRequest = GetBoardingPassPdfRequest(passengerToken: stepsState.travelers[0].token, fligthId: stepsState.travelers[0].flightInformation.flight[0].id);
    // final fOrBP = await getBoardingPassPdfUseCase(request: getBoardingPassPdfRequest);
    // print("35 at receipt");
    // fOrBP.fold((f) => FailureHandler.handle(f, retry: () => init()), (boardingPass) async {
    //   print("37 at receipt");
    //   receiptState.setBoardingPassPDF(boardingPass);
    //   print("39 at receipt");
    //   convertToPDF();
    //   print("341 at receipt");
    //   receiptState.setLoading(false);
    //   receiptState.setSuccessfulResponse(false);
    // });
    final StepsState stepsState = getIt<StepsState>();
    var req = {
      "Format": 1, //1->pdf    32->Html
      "PassengersId": "<MyTable><MyRow><FlightPax_ID>${stepsState.travelers[0].flightInformation.passengers[0].id}</FlightPax_ID></MyRow></MyTable>",
      "IsDarkMode": false,
    };

    Response response;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    response = await dio.post('https://onlinecheckinapi.abomis.com/api/MemoStrm', data: {
      "Body": {
        "MrtName": "OnlineCheckinBoardingPass-AB",
        "Token": stepsState.travelers[0].token,
        "Request": req,
      },
    });

    if (response.statusCode == 200) {
      receiptState.setBoardingPassPDF(BoardingPassPDF.fromJson(response.data));
      convertToPDF();
      receiptState.setLoading(false);
      receiptState.setSuccessfulResponse(true);
      return;
    }
  }

  void convertToPDF() async {
    String base64String = receiptState.boardingPassPDF.buffer;
    print(base64String);
    print("49 at receipt");
    receiptState.setBytes(base64Decode(base64String));
  }

  Future<bool> finalReserve() async {
    final StepsState stepsState = getIt<StepsState>();
    final SeatMapState seatMapState = getIt<SeatMapState>();
    List<Traveler> travellers = stepsState.travelers;
    List<SeatData> seatsData = [];
    travellers.where((t) => !seatMapState.reservedSeats.containsKey(t.seatId)).toList().forEach((traveler) {
      seatsData.add(SeatData(passengerId: traveler.flightInformation.passengers.last.id, letter: traveler.seatId.substring(0, 1), line: int.parse(traveler.seatId.substring(1))));
    });

    ReserveSeatRequest reserveSeatRequest = ReserveSeatRequest(seatsData: seatsData);
    final fOrRS = await reserveSeatUseCase(request: reserveSeatRequest);
    print("65 at receipt");
    bool returnedValue = false;
    fOrRS.fold((f) => FailureHandler.handle(f, retry: () => init()), (successful) async {
      print("68 at receipt");
      if (successful) {
        print("69 at receipt");
        final SeatMapState seatMapState = getIt<SeatMapState>();
        print(travellers);
        for (Traveler traveller in travellers) {
          seatMapState.reservedSeats[traveller.seatId] = traveller.getNickName();
          seatMapState.clickedOnSeats.remove(traveller.seatId);
        }
      }
      print("77 at receipt");
      returnedValue = successful;
    });
    print("80 at receipt");
    return returnedValue;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
