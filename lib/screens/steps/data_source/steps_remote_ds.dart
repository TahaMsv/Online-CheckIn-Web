import 'dart:convert';

import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/screens/steps/usecases/get_flight_information_usecase.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/constants/apis.dart';
import '../../../core/constants/my_json.dart';
import '../../../core/error/exception.dart';
import '../../../core/platform/network_manager.dart';
import '../../../core/platform/running_mode_info.dart';
import '../interfaces/steps_data_source_interface.dart';

class StepsRemoteDataSource implements StepsDataSourceInterface {
  final NetworkManager networkManager = NetworkManager();

  @override
  Future<GetFlightInformationResponse> getFlightInformation(GetFlightInformationRequest request) async {
    Response res;
    if (RunningModeInfo.runningType().isTest) {
      res = Response.fromJson(MyJson.flightInformationResJson);
    } else {
      res = await networkManager.post(request);
    }
    return GetFlightInformationResponse.fromResponse(res);
  }
}
