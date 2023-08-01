import 'dart:io' show Platform;
import 'package:online_check_in/core/classes/my_country.dart';
import 'package:online_check_in/core/classes/passport_type.dart';
import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/constants/apis.dart';
import '../../../core/constants/my_json.dart';
import '../../../core/error/exception.dart';
import '../../../core/platform/network_manager.dart';
import '../../../core/platform/running_mode_info.dart';
import '../interfaces/passport_data_source_interface.dart';

class PassportRemoteDataSource implements PassportDataSourceInterface {
  final NetworkManager networkManager = NetworkManager();

  @override
  Future<SelectCountriesResponse> selectCountries(SelectCountriesRequest request) async {
    Response res = await networkManager.post(request);
    return SelectCountriesResponse.fromResponse(res);
    // NetworkRequest selectCLNR = NetworkRequest(api: Apis.baseUrl + Apis.getSelectCountries, data: request.toJson(), timeOut: const Duration(seconds: 30));
    // NetworkResponse selectCLResponse;
    // if (RunningModeInfo.runningType().isTest) {
    //   selectCLResponse = NetworkResponse(responseStatus: true, responseCode: 200, responseBody: MyJson.selectCountriesResJson);
    // } else {
    //   selectCLResponse = await selectCLNR.post();
    // }
    // if (selectCLResponse.responseStatus) {
    //   try {
    //     return List<MyCountry>.from(selectCLResponse.responseBody["Body"]["Countries"].map((x) => MyCountry.fromJson(x)));
    //   } catch (e, trace) {
    //     throw ParseException(message: e.toString(), trace: trace);
    //   }
    // } else {
    //   throw ServerException(
    //     code: selectCLResponse.responseCode,
    //     message: selectCLResponse.extractedMessage!,
    //     trace: StackTrace.fromString("PassportRemoteDataSource.selectCountries"),
    //   );
    // }
  }

  @override
  Future<SelectPassportResponse> selectPassportTypes(SelectPassportTypesRequest request) async {
    Response res = await networkManager.post(request);
    return SelectPassportResponse.fromResponse(res);
    // NetworkRequest selectPTNR = NetworkRequest(api: Apis.baseUrl + Apis.getDocumentType, data: request.toJson(), timeOut: const Duration(seconds: 30));
    // NetworkResponse selectPTResponse;
    // if (Platform.environment.containsKey('FLUTTER_TEST')) {
    //   selectPTResponse = NetworkResponse(responseStatus: true, responseCode: 200, responseBody: MyJson.selectDocumentTypesResJson);
    // } else {
    //   selectPTResponse = await selectPTNR.post();
    // }
    // if (selectPTResponse.responseStatus) {
    //   try {
    //     return List<PassPortType>.from(selectPTResponse.responseBody["Body"]["PassportTypes"].map((x) => PassPortType.fromJson(x)));
    //   } catch (e, trace) {
    //     throw ParseException(message: e.toString(), trace: trace);
    //   }
    // } else {
    //   throw ServerException(
    //     code: selectPTResponse.responseCode,
    //     message: selectPTResponse.extractedMessage!,
    //     trace: StackTrace.fromString("PassportRemoteDataSource.selectPassportTypes"),
    //   );
    // }
  }
}
