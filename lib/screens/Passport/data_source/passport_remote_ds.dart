
import 'package:network_manager/network_manager.dart';
import 'package:online_checkin_web_refactoring/core/classes/MyCountry.dart';

import 'package:online_checkin_web_refactoring/core/classes/PassportType.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_passport_type_usecase.dart';

import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../interfaces/passport_data_source_interface.dart';

class PassportRemoteDataSource implements PassportDataSourceInterface {
  @override
  Future<List<MyCountry>> selectCountries(SelectCountriesRequest request)async {
    NetworkRequest selectCLNR = NetworkRequest(api: Apis.baseUrl + Apis.getSelectCountries, data: request.toJson(), timeOut: const Duration(seconds: 10));
    NetworkResponse selectCLResponse = await selectCLNR.post();
    if (selectCLResponse.responseStatus) {
      try {
        return List<MyCountry>.from(selectCLResponse.responseBody["Body"]["Countries"].map((x) => MyCountry.fromJson(x)));
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: selectCLResponse.responseCode,
        message: selectCLResponse.extractedMessage!,
        trace: StackTrace.fromString("PassportRemoteDataSource.selectCountries"),
      );
    }
  }

  @override
  Future<List<PassPortType>> selectPassportTypes( SelectPassportTypesRequest request) async{
    NetworkRequest selectPTNR = NetworkRequest(api: Apis.baseUrl + Apis.getDocumentType, data: request.toJson(), timeOut: const Duration(seconds: 10));
    NetworkResponse selectPTResponse = await selectPTNR.post();
    if (selectPTResponse.responseStatus) {
      try {
        return List<PassPortType>.from(selectPTResponse.responseBody["Body"]["PassportTypes"].map((x) => PassPortType.fromJson(x)));
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: selectPTResponse.responseCode,
        message: selectPTResponse.extractedMessage!,
        trace: StackTrace.fromString("PassportRemoteDataSource.selectPassportTypes"),
      );
    }
  }
}
