import '../global/RequestModels.dart';
import 'package:network_manager/network_manager.dart';

import 'Constants.dart';

class DataProvider {
  static Future<NetworkResponse> login({required String username ,required String password ,required Function retry}) async {
    String api = Apis.login;
    RequestModelLogin loginRM = RequestModelLogin(username: username, password: password);
    return NetworkRequest(api: api, data: loginRM.toJson(),retry: retry).post();
  }


}