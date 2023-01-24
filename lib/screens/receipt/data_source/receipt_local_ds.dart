import 'package:online_checkin_web_refactoring/core/classes/boarding_pass_pdf.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/reserve_seat_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interface/receipt_data_source_interface.dart';

class ReceiptLocalDataSource implements ReceiptDataSourceInterface {
  final SharedPreferences sharedPreferences;

  ReceiptLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<BoardingPassPDF> getBoardingPassPdf(GetBoardingPassPdfRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<bool> reserveSeat(ReserveSeatRequest request) {
    throw UnimplementedError();
  }
}
