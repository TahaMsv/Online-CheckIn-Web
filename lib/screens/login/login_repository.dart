import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/login/data_sources/login_local_ds.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../../core/platform/running_mode_info.dart';
import '../../screens/login/interfaces/login_repository_interface.dart';
import 'data_sources/login_remote_ds.dart';
import 'usecases/login_usecase.dart';

class LoginRepository implements LoginRepositoryInterface {
  final LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSource();
  final LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  LoginRepository();

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      LoginResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await loginRemoteDataSource.login(request);
      } else {
        res = await loginLocalDataSource.login(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
