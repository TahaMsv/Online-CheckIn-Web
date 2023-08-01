import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/extra.dart';
import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../../core/platform/running_mode_info.dart';
import 'data_source/upgrades_local_ds.dart';
import 'data_source/upgrades_remote_ds.dart';
import 'interfaces/upgrades_repository_interface.dart';

class UpgradesRepository implements UpgradesRepositoryInterface {
  final UpgradesRemoteDataSource upgradesRemoteDataSource = UpgradesRemoteDataSource();
  final UpgradesLocalDataSource upgradesLocalDataSource = UpgradesLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  UpgradesRepository();

  @override
  Future<Either<Failure, GetExtrasResponse>> getExtras(GetExtrasRequest request) async {
    try {
      GetExtrasResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await upgradesRemoteDataSource.getExtras(request);
      } else {
        res = await upgradesLocalDataSource.getExtras(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
