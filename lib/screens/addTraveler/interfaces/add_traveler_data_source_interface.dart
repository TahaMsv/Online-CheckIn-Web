
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../usecases/add_traveler_usecase.dart';

abstract class AddTravelerDataSourceInterface{
  Future<String> addTraveler(AddTravelerRequest request);
}