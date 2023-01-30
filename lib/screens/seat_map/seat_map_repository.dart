import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/usecases/click_on_seat_usecase.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import 'data_source/seat_map_local_ds.dart';
import 'data_source/seat_map_remote_ds.dart';
import 'interfaces/seat_map_repository_interface.dart';

class SeatMapRepository implements SeatMapRepositoryInterface {
  final SeatMapRemoteDataSource seatMapRemoteDataSource;
  final SeatMapLocalDataSource seatMapLocalDataSource;
  final NetworkInfo networkInfo;

  SeatMapRepository({
    required this.seatMapRemoteDataSource,
    required this.seatMapLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> clickOnSeat(ClickOnSeatRequest request) async{
    if (await networkInfo.isConnected) {
      try {
        bool successful = await seatMapRemoteDataSource.clickOnSeat(request);
        return Right(successful);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("SeatMap repository: clickOnSeat"),
          ),
        ),
      );
    }
  }
}
