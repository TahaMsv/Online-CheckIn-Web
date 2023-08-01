import '../../../core/abstract/response_abs.dart';
import '../../../core/constants/my_json.dart';
import '../../../core/platform/network_manager.dart';
import '../../../core/platform/running_mode_info.dart';
import '../../../screens/login/interfaces/login_data_source_interface.dart';
import '../usecases/login_usecase.dart';

class LoginRemoteDataSource implements LoginDataSourceInterface {
  final NetworkManager networkManager = NetworkManager();

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    Response res;
    if (RunningModeInfo.runningType().isTest) {
      res = Response.fromJson(MyJson.authenticateResJson);
    } else {
      res = await networkManager.post(request);
    }
    return LoginResponse.fromResponse(res);
  }
}
