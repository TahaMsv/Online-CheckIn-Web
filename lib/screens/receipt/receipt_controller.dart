import 'dart:convert';


import 'package:online_checkin_web_refactoring/screens/receipt/receipt_repository.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/receipt_state.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/reserve_seat_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/seat_map_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_controller.dart';

import '../../core/classes/Traveler.dart';
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

    await finalReserve();

    final StepsState stepsState = getIt<StepsState>();

    GetBoardingPassPdfRequest getBoardingPassPdfRequest =
        GetBoardingPassPdfRequest(passengerToken: stepsState.travelers[0].token, passengerId: stepsState.travelers[0].flightInformation.passengers[0].id);
    final fOrBP = await getBoardingPassPdfUseCase(request: getBoardingPassPdfRequest);

    fOrBP.fold((f) => FailureHandler.handle(f, retry: () => init()), (boardingPass) async {
      receiptState.boardingPassPDF = boardingPass;
      convertToPDF();
    });
    receiptState.setLoading(false);
    receiptState.setSuccessfulResponse(false);
  }

  void convertToPDF() async {
    String base64String = receiptState.boardingPassPDF.buffer;
    receiptState.bytes = base64Decode(base64String);
    receiptState.setState();
  }

  Future<bool> finalReserve() async {
    final StepsState stepsState = getIt<StepsState>();
    final SeatMapState seatMapState = getIt<SeatMapState>();
    List<Traveler> travellers = stepsState.travelers;
    List<SeatData> seatsData = [];
    travellers.where((t) => !seatMapState.reservedSeats.containsKey(t.seatId)).toList().forEach((traveler) {
      seatsData.add(SeatData(passengerId: traveler.flightInformation.passengers[0].id, letter: traveler.seatId.substring(0, 1), line: int.parse(traveler.seatId.substring(1))));
    });

    ReserveSeatRequest reserveSeatRequest = ReserveSeatRequest(seatsData: seatsData);
    final fOrRS = await reserveSeatUseCase(request: reserveSeatRequest);

    fOrRS.fold((f) => FailureHandler.handle(f, retry: () => init()), (successful) async {
      if (successful) {
        final SeatMapState seatMapState = getIt<SeatMapState>();
        for (Traveler traveller in travellers) {
          seatMapState.reservedSeats[traveller.seatId] = traveller.getNickName();
          seatMapState.clickedOnSeats.remove(traveller.seatId);
        }
      }
    });
    if (seatMapState.reservedSeats.length == travellers.length) return true;
    return false;
  }

  @override
  void onCreate() {}
}
