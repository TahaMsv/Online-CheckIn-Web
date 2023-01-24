import 'dart:convert';

import 'package:online_checkin_web_refactoring/screens/receipt/receipt_repository.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/receipt_state.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/reserve_seat_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/seat_map_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_controller.dart';

import '../../core/classes/Traveler.dart';
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

    await finalReserve();

    final StepsState stepsState = getIt<StepsState>();

    GetBoardingPassPdfRequest getBoardingPassPdfRequest =
        GetBoardingPassPdfRequest(passengerToken: stepsState.travelers[0].token, passengerId: stepsState.travelers[0].flightInformation.passengers[0].id);
    final fOrBP = await getBoardingPassPdfUseCase(request: getBoardingPassPdfRequest);

    fOrBP.fold((f) => FailureHandler.handle(f, retry: () => init()), (boardingPass) async {
      receiptState.boardingPassPDF = boardingPass;
      convertToPDF();
      receiptState.setLoading(false);
      receiptState.setSuccessfulResponse(false);

      return;
    });
    receiptState.setLoading(false);
    receiptState.setSuccessfulResponse(false);
  }

  void convertToPDF() async {
    String base64String = receiptState.boardingPassPDF.buffer;
    receiptState.bytes = base64Decode(base64String);
  }

  Future<bool> finalReserve() async {
    final StepsState stepsState = getIt<StepsState>();
    final SeatMapState seatMapState = getIt<SeatMapState>();
    List<Traveler> travellers = stepsState.travelers;
    List<Map<String, dynamic>> seatsData = [];
    String token = "";
    travellers.where((t) => !seatMapState.reservedSeats.containsKey(t.seatId)).toList().forEach((traveler) {
      token = traveler.token;
      String letter = traveler.seatId.substring(0, 1);
      int line = int.parse(traveler.seatId.substring(1));
      seatsData.add({
        "PassengerID": traveler.flightInformation.passengers[0].id,
        "Letter": letter,
        "Line": line,
      });
    });

    ReserveSeatRequest reserveSeatRequest = ReserveSeatRequest(passengerToken: token, seatsData: seatsData);
    final fOrRS = await reserveSeatUseCase(request: reserveSeatRequest);

    fOrRS.fold((f) => FailureHandler.handle(f, retry: () => init()), (successful) async {
      if(successful){
        final SeatMapState seatMapState = getIt<SeatMapState>();
        travellers.forEach((traveller) {
          seatMapState.reservedSeats[traveller.seatId] = traveller.getNickName();
          seatMapState.clickedOnSeats.remove(traveller.seatId);
        });
        return Future<bool>.value(true);
      }
    });

    if (seatMapState.reservedSeats.length == travellers.length) return true;
    return Future<bool>.value(false);
  }


  @override
  void onCreate() {}
}
