import 'package:online_checkin_web_refactoring/screens/login/interfaces/login_data_source_interface.dart';
import 'package:online_checkin_web_refactoring/screens/login/usecases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalDataSource implements LoginDataSourceInterface {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<String> login(LoginRequest request) {
    throw UnimplementedError();
  }
}
