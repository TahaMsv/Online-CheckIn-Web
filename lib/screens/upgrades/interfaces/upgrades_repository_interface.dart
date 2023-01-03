import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/usecases/get_extras_usecase.dart';

import '../../../core/classes/extra.dart';
import '../../../core/error/failures.dart';

abstract class UpgradesRepositoryInterface{
  Future<Either<Failure, List<Extra>>> getExtras(GetExtrasRequest request);
}