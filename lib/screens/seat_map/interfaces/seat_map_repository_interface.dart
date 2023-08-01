
import 'package:online_check_in/core/classes/visa_type.dart';
import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/seat_map/usecases/click_on_seat_usecase.dart';
import '../../../core/error/failures.dart';

abstract class SeatMapRepositoryInterface{
  Future<Either<Failure, ClickOnSeatResponse>> clickOnSeat(ClickOnSeatRequest request);
}