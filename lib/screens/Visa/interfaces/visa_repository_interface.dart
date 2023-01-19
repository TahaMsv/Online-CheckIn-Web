
import 'package:online_checkin_web_refactoring/core/classes/VisaType.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../usecases/select_visa_types_usecase.dart';

abstract class VisaRepositoryInterface{
  Future<Either<Failure, List<VisaType>>> selectVisaTypes(SelectVisaTypesRequest request);
}