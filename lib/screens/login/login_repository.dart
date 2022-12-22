
import 'package:dartz/dartz.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../screens/login/interfaces/login_repository_interface.dart';
import 'data_sources/login_remote_ds.dart';
import 'usecases/login_usecase.dart';

class LoginRepository implements LoginRepositoryInterface {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepository({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, String>> login(LoginRequest loginRequest) async {
    // if (await networkInfo.isConnected) {
    try {
      String token = await loginRemoteDataSource.login(loginRequest);
      return Right(token);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
    // } else {
    // try {
    //   User user = await loginLocalDataSource.login(loginRequest: loginRequest);
    //   return Right(user);
    // } on AppException catch (e) {
    //   return Left(CacheFailure.fromAppException(e));
    // }
    // }
  }

 }
