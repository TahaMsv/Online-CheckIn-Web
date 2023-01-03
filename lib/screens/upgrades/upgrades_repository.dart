import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/core/classes/extra.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/usecases/get_extras_usecase.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import 'data_source/upgrades_remote_ds.dart';
import 'interfaces/upgrades_repository_interface.dart';

class UpgradesRepository implements UpgradesRepositoryInterface {
  final UpgradesRemoteDataSource upgradesRemoteDataSource;

  UpgradesRepository({required this.upgradesRemoteDataSource});

  @override
  Future<Either<Failure, List<Extra>>> getExtras(GetExtrasRequest request) async{
    try {
      List<Extra> extrasList = await upgradesRemoteDataSource.getExtras(request);
      return Right(extrasList);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
