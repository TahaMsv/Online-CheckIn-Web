import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../usecases/login_usecase.dart';

abstract class LoginRepositoryInterface {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
}
