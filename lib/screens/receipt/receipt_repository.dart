import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/receipt/usecases/get_boadingpass_pdf_usecase.dart';
import 'package:online_check_in/screens/receipt/usecases/reserve_seat_usecase.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../../core/platform/running_mode_info.dart';
import 'data_source/receipt_local_ds.dart';
import 'data_source/receipt_remote_ds.dart';
import 'interface/receipt_repository_interface.dart';

class ReceiptRepository implements ReceiptRepositoryInterface {
  final ReceiptRemoteDataSource receiptRemoteDataSource = ReceiptRemoteDataSource();
  final ReceiptLocalDataSource receiptLocalDataSource = ReceiptLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  ReceiptRepository();

  @override
  Future<Either<Failure, GetBoardingPassPdfResponse>> getBoardingPassPdf(GetBoardingPassPdfRequest request) async {
    try {
      GetBoardingPassPdfResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await receiptRemoteDataSource.getBoardingPassPdf(request);
      } else {
        res = await receiptLocalDataSource.getBoardingPassPdf(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }

    // if (await networkInfo.isConnected) {
    //   try {
    //     BoardingPassPDF boardingPassPDF = await receiptRemoteDataSource.getBoardingPassPdf(request);
    //     return Right(boardingPassPDF);
    //   } on AppException catch (e) {
    //     return Left(ServerFailure.fromAppException(e));
    //   }
    // } else {
    //   return Left(
    //     ConnectionFailure.fromAppException(
    //       ConnectionException(
    //         message: "You are not connected to internet!",
    //         trace: StackTrace.fromString("Receipt repository: getBoardingPassPdf"),
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  Future<Either<Failure, ReserveSeatResponse>> reserveSeat(ReserveSeatRequest request) async {
    try {
      ReserveSeatResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await receiptRemoteDataSource.reserveSeat(request);
      } else {
        res = await receiptLocalDataSource.reserveSeat(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }

    // if (await networkInfo.isConnected) {
    //   try {
    //     bool successful = await receiptRemoteDataSource.reserveSeat(request);
    //     return Right(successful);
    //   } on AppException catch (e) {
    //     return Left(ServerFailure.fromAppException(e));
    //   }
    // } else {
    //   return Left(
    //     ConnectionFailure.fromAppException(
    //       ConnectionException(
    //         message: "You are not connected to internet!",
    //         trace: StackTrace.fromString("Receipt repository: reserveSeat"),
    //       ),
    //     ),
    //   );
    // }
  }
}
