import 'package:online_check_in/screens/Visa/usecases/select_visa_types_usecase.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/platform/network_manager.dart';
import '../interfaces/visa_data_source_interface.dart';

class VisaRemoteDataSource implements VisaDataSourceInterface {
  final NetworkManager networkManager = NetworkManager();

  @override
  Future<SelectVisaResponse> selectVisaTypes(SelectVisaTypesRequest request) async {
    Response res = await networkManager.post(request);
    return SelectVisaResponse.fromResponse(res);
    // NetworkRequest selectVTNR = NetworkRequest(api: Apis.baseUrl + Apis.getDocumentType, data: request.toJson(), timeOut: const Duration(seconds: 30));
    // NetworkResponse selectVTResponse;
    // if (RunningModeInfo.runningType().isTest) {
    //   selectVTResponse = NetworkResponse(responseStatus: true, responseCode: 200, responseBody: MyJson.selectDocumentTypesResJson);
    // } else {
    //   selectVTResponse = await selectVTNR.post();
    // }
    // if (selectVTResponse.responseStatus) {
    //   try {
    //     return List<VisaType>.from(selectVTResponse.responseBody["Body"]["VisaTypes"].map((x) => VisaType.fromJson(x)));
    //   } catch (e, trace) {
    //     throw ParseException(message: e.toString(), trace: trace);
    //   }
    // } else {
    //   throw ServerException(
    //     code: selectVTResponse.responseCode,
    //     message: selectVTResponse.extractedMessage!,
    //     trace: StackTrace.fromString("VisaRemoteDataSource.selectVisaTypes"),
    //   );
    // }
  }
}
