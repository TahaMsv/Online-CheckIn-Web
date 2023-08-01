import 'package:online_check_in/core/classes/extra.dart';
import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/constants/apis.dart';
import '../../../core/constants/my_json.dart';
import '../../../core/error/exception.dart';
import '../../../core/platform/network_manager.dart';
import '../../../core/platform/running_mode_info.dart';
import '../interfaces/upgrades_data_source_interface.dart';
import 'dart:io' show Platform;

class UpgradesRemoteDataSource implements UpgradesDataSourceInterface {
  final NetworkManager networkManager = NetworkManager();

  @override
  Future<GetExtrasResponse> getExtras(GetExtrasRequest request) async {
    Response res;
    if (RunningModeInfo.runningType().isTest) {
      res = Response.fromJson(MyJson.selectSeatExtrasResJson);
    } else {
      res = await networkManager.post(request);
    }
    return GetExtrasResponse.fromResponse(res);
  }
}
