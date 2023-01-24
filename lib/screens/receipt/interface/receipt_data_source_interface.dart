import 'package:online_checkin_web_refactoring/screens/receipt/usecases/reserve_seat_usecase.dart';

import '../../../core/classes/boarding_pass_pdf.dart';
import '../usecases/get_boadingpass_pdf_usecase.dart';

abstract class ReceiptDataSourceInterface {
  Future<BoardingPassPDF> getBoardingPassPdf(GetBoardingPassPdfRequest request);

  Future<bool> reserveSeat(ReserveSeatRequest request);
}
