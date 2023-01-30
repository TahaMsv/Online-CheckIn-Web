import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/core/classes/boarding_pass_pdf.dart';
import 'package:online_checkin_web_refactoring/screens/payment/data_source/payment_local_ds.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/receipt/usecases/reserve_seat_usecase.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import 'data_source/receipt_local_ds.dart';
import 'data_source/receipt_remote_ds.dart';
import 'interface/receipt_repository_interface.dart';

class ReceiptRepository implements ReceiptRepositoryInterface {
  final ReceiptRemoteDataSource receiptRemoteDataSource;
  final ReceiptLocalDataSource receiptLocalDataSource;
  final NetworkInfo networkInfo;

  ReceiptRepository({required this.receiptRemoteDataSource, required this.receiptLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, BoardingPassPDF>> getBoardingPassPdf(GetBoardingPassPdfRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        BoardingPassPDF boardingPassPDF = await receiptRemoteDataSource.getBoardingPassPdf(request);
        return Right(boardingPassPDF);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("Receipt repository: getBoardingPassPdf"),
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> reserveSeat(ReserveSeatRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        bool successful = await receiptRemoteDataSource.reserveSeat(request);
        return Right(successful);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("Receipt repository: reserveSeat"),
          ),
        ),
      );
    }
  }
}
