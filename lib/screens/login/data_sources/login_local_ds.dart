import 'package:online_check_in/screens/login/interfaces/login_data_source_interface.dart';
import 'package:online_check_in/screens/login/usecases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalDataSource implements LoginDataSourceInterface {

  LoginLocalDataSource();

  @override
  Future<LoginResponse> login(LoginRequest request) {
    throw UnimplementedError();
  }
}
