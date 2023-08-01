import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/steps/steps_repository.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/classes/flight_information.dart';
import '../../../core/error/failures.dart';
import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class GetFlightInformationUseCase extends UseCase<GetFlightInformationResponse, GetFlightInformationRequest> {
  final StepsRepository repository;

  GetFlightInformationUseCase({required this.repository});

  @override
  Future<Either<Failure, GetFlightInformationResponse>> call({required GetFlightInformationRequest request}) {
    return repository.getFlightInformation(request);
  }
}

class GetFlightInformationRequest extends Request {
  GetFlightInformationRequest();

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[SelectFlightInformation]",
          "Token": token,
          "Request": {},
        },
      };
}

class GetFlightInformationResponse extends Response {
  final FlightInformation flightInformation;

  GetFlightInformationResponse({
    required int status,
    required String message,
    required this.flightInformation,
  }) : super(message: message, status: status, body: flightInformation);

  factory GetFlightInformationResponse.fromResponse(Response res) {
    return GetFlightInformationResponse(
      status: res.status,
      message: res.message,
      flightInformation: flightInformationFromJson(
        jsonEncode(res.body),
      ),
    );
  }
}
