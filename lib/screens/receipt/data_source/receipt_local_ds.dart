import 'package:online_check_in/core/classes/boarding_pass_pdf.dart';
import 'package:online_check_in/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_check_in/screens/receipt/usecases/reserve_seat_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interface/receipt_data_source_interface.dart';

class ReceiptLocalDataSource implements ReceiptDataSourceInterface {

  ReceiptLocalDataSource();

  @override
  Future<GetBoardingPassPdfResponse> getBoardingPassPdf(GetBoardingPassPdfRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<ReserveSeatResponse> reserveSeat(ReserveSeatRequest request) {
    throw UnimplementedError();
  }
}
