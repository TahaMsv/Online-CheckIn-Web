import '../usecases/login_usecase.dart';

abstract class LoginDataSourceInterface {
  Future<LoginResponse> login(LoginRequest request);
}
