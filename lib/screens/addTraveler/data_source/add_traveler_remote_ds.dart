
import 'package:online_check_in/screens/addTraveler/interfaces/add_traveler_data_source_interface.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/constants/apis.dart';
import '../../../core/constants/my_json.dart';
import '../../../core/error/exception.dart';
import '../../../core/platform/network_manager.dart';
import '../../../core/platform/running_mode_info.dart';
import '../usecases/add_traveler_usecase.dart';

class AddTravelerRemoteDataSource implements AddTravelerDataSourceInterface {

  final NetworkManager networkManager = NetworkManager();
  @override
  Future< AddTravelerResponse> addTraveler(AddTravelerRequest request)async {
    
    Response res =await networkManager.post(request);
    return AddTravelerResponse.fromResponse(res);
    // NetworkRequest loginNR = NetworkRequest(api: Apis.baseUrl + Apis.login, data: request.toJson(), timeOut: const Duration(seconds: 30));
    // NetworkResponse addTResponse = await loginNR.post();
    // if (RunningModeInfo.runningType().isTest) {
    //   addTResponse = NetworkResponse(responseStatus: true, responseCode: 200, responseBody: MyJson.authenticateResJson);
    // } else {
    //   addTResponse = await loginNR.post();
    // }
    // if (addTResponse.responseStatus) {
    //   try {
    //     return addTResponse.responseBody["Body"]["Token"];
    //   } catch (e, trace) {
    //     throw ParseException(message: e.toString(), trace: trace);
    //   }
    // } else {
    //   throw ServerException(
    //     code: addTResponse.responseCode,
    //     message: addTResponse.extractedMessage!,
    //     trace: StackTrace.fromString("AddTravelerRemoteDataSource.addTraveller"),
    //   );
    // }
  }
}
