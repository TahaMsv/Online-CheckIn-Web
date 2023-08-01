import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/seat_map/usecases/click_on_seat_usecase.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../../core/platform/running_mode_info.dart';
import 'data_source/seat_map_local_ds.dart';
import 'data_source/seat_map_remote_ds.dart';
import 'interfaces/seat_map_repository_interface.dart';

class SeatMapRepository implements SeatMapRepositoryInterface {
  final SeatMapRemoteDataSource seatMapRemoteDataSource = SeatMapRemoteDataSource();
  final SeatMapLocalDataSource seatMapLocalDataSource = SeatMapLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  SeatMapRepository();

  @override
  Future<Either<Failure, ClickOnSeatResponse>> clickOnSeat(ClickOnSeatRequest request) async {
    try {
      ClickOnSeatResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await seatMapRemoteDataSource.clickOnSeat(request);
      } else {
        res = await seatMapLocalDataSource.clickOnSeat(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
