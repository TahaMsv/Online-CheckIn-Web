import '../../../core/classes/boarding_pass_pdf.dart';
import '../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../usecases/get_boadingpass_pdf_usecase.dart';
import '../usecases/reserve_seat_usecase.dart';

abstract class ReceiptRepositoryInterface {
  Future<Either<Failure, BoardingPassPDF>> getBoardingPassPdf(GetBoardingPassPdfRequest request);

  Future<Either<Failure, bool>> reserveSeat(ReserveSeatRequest request);
}
