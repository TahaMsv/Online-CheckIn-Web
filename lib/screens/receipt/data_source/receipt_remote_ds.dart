import 'package:online_checkin_web_refactoring/core/classes/boarding_pass_pdf.dart';

import 'package:online_checkin_web_refactoring/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:network_manager/network_manager.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/reserve_seat_usecase.dart';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../interface/receipt_data_source_interface.dart';

class ReceiptRemoteDataSource implements ReceiptDataSourceInterface {
  @override
  Future<BoardingPassPDF> getBoardingPassPdf(GetBoardingPassPdfRequest request) async {
    NetworkRequest selectBPPNR = NetworkRequest(api: Apis.baseUrl + Apis.boardingPassPDF, data: request.toJson(), timeOut: const Duration(seconds: 10));
    NetworkResponse selectBPPResponse = await selectBPPNR.post();
    if (selectBPPResponse.responseStatus) {
      try {
        return BoardingPassPDF.fromJson(selectBPPResponse.responseBody);
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: selectBPPResponse.responseCode,
        message: selectBPPResponse.extractedMessage!,
        trace: StackTrace.fromString("ReceiptRemoteDataSource.getBoardingPassPdf"),
      );
    }
  }

  @override
  Future<bool> reserveSeat(ReserveSeatRequest request) async {
    NetworkRequest reserveSeatNR = NetworkRequest(api: Apis.baseUrl + Apis.reserveSeat, data: request.toJson(), timeOut: const Duration(seconds: 10));
    NetworkResponse reserveSeatResponse = await reserveSeatNR.post();
    if (reserveSeatResponse.responseStatus) {
      return true;
    } else {
      throw ServerException(
        code: reserveSeatResponse.responseCode,
        message: reserveSeatResponse.extractedMessage!,
        trace: StackTrace.fromString("ReceiptRemoteDataSource.reserveSeat"),
      );
    }
  }
}
