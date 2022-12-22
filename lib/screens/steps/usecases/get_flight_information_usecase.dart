import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_repository.dart';
import '../../../core/classes/flight_information.dart';
import '../../../core/error/failures.dart';
import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class GetFlightInformationUseCase extends UseCase<FlightInformation, GetFlightInformationRequest> {
  final StepsRepository repository;

  GetFlightInformationUseCase({required this.repository});

  @override
  Future<Either<Failure, FlightInformation>> call({required GetFlightInformationRequest request}) {
    return repository.getFlightInformation(request);
  }
}

class GetFlightInformationRequest extends Request {
  final String execution;
  final dynamic token;
  final Map<String, dynamic> request;

  GetFlightInformationRequest(
    this.execution,
    this.token,
    this.request,
  );

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": execution,
          "Token": token,
          "Request": request,
        },
      };
}
