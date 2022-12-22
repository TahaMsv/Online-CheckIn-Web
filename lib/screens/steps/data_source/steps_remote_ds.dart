import 'dart:convert';

import 'package:online_checkin_web_refactoring/core/classes/flight_information.dart';
import 'package:online_checkin_web_refactoring/screens/steps/usecases/get_flight_information_usecase.dart';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import 'package:network_manager/network_manager.dart';

import '../interfaces/steps_data_source_interface.dart';

class StepsRemoteDataSource implements StepsDataSourceInterface {
  // final LoginLocalDataSource localDataSource;

  // LoginRemoteDataSource(this.localDataSource);

  @override
  Future<FlightInformation> getFlightInformation(GetFlightInformationRequest request) async {
    NetworkRequest getFlightInfoNR = NetworkRequest(api: Apis.baseUrl + Apis.getInformation, data: request.toJson());
    NetworkResponse getFlightInfoResponse = await getFlightInfoNR.post();

    if (getFlightInfoResponse.responseStatus) {
      try {
        FlightInformation flightInformation = flightInformationFromJson(jsonEncode(getFlightInfoResponse.responseBody["Body"]));
        return flightInformation;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: getFlightInfoResponse.responseCode,
        message: getFlightInfoResponse.extractedMessage!,
        trace: StackTrace.fromString("RemoteDataSource.getSalt"),
      );
    }
  }
}
