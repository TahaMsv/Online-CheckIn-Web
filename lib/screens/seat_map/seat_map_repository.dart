import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/usecases/click_on_seat_usecase.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import 'data_source/seat_map__remote_ds.dart';
import 'interfaces/seat_map_repository_interface.dart';

class SeatMapRepository implements SeatMapRepositoryInterface {
  final SeatMapRemoteDataSource seatMapRemoteDataSource;

  SeatMapRepository({required this.seatMapRemoteDataSource});

  @override
  Future<Either<Failure, bool>> clickOnSeat(ClickOnSeatRequest request) {
    // TODO: implement clickOnSeat
    throw UnimplementedError();
  }
}
