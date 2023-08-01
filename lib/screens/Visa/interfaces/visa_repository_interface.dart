
import 'package:online_check_in/core/classes/visa_type.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../usecases/select_visa_types_usecase.dart';

abstract class VisaRepositoryInterface{
  Future<Either<Failure, SelectVisaResponse>> selectVisaTypes(SelectVisaTypesRequest request);
}