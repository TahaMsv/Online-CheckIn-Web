
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../usecases/add_traveler_usecase.dart';

abstract class AddTravelerRepositoryInterface{
  Future<Either<Failure, String>> addTraveler(AddTravelerRequest request);
}