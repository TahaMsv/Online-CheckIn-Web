
import 'package:online_check_in/core/classes/VisaType.dart';
import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/seat_map/usecases/click_on_seat_usecase.dart';
import '../../../core/error/failures.dart';

abstract class SeatMapRepositoryInterface{
  Future<Either<Failure, bool>> clickOnSeat(ClickOnSeatRequest request);
}