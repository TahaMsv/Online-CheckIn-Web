import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/core/error/failures.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/interfaces/add_traveler_data_source_interface.dart';
import 'package:network_manager/network_manager.dart';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../usecases/add_traveler_usecase.dart';

class AddTravelerRemoteDataSource implements AddTravelerDataSourceInterface {
  @override
  Future< String> addTraveler(AddTravelerRequest request)async {
    NetworkRequest loginNR = NetworkRequest(api: Apis.baseUrl + Apis.login, data: request.toJson(), timeOut: const Duration(days: 1));
    NetworkResponse addTResponse = await loginNR.post();
    if (addTResponse.responseStatus) {
      try {
        return addTResponse.responseBody["Body"]["Token"];
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: addTResponse.responseCode,
        message: addTResponse.extractedMessage!,
        trace: StackTrace.fromString("AddTravelerRemoteDataSource.addTraveller"),
      );
    }
  }
}
