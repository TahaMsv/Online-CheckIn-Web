import 'package:dartz/dartz.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/usecase.dart';
import '../add_traveler_repository.dart';

class AddTravelerUseCase extends UseCase<AddTravelerResponse, AddTravelerRequest> {
  final AddTravelerRepository repository;

  AddTravelerUseCase({required this.repository});

  @override
  Future<Either<Failure, AddTravelerResponse>> call({required AddTravelerRequest request}) {
    return repository.addTraveler(request);
  }
}

class AddTravelerRequest extends Request {
  AddTravelerRequest({
    required this.lastname,
    required this.ticketNumber,
  });

  final String lastname;
  final String ticketNumber;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[Authenticate]",
          "Token": token,
          "Request": {
            "Code": ticketNumber,
            "Code2": lastname,
            "UrlType": 1,
          },
        },
      };
}

class AddTravelerResponse extends Response {
  final String token;

  AddTravelerResponse({
    required int status,
    required String message,
    required this.token,
  }) : super(message: message, status: status, body: {});

  factory AddTravelerResponse.fromResponse(Response res) {
    return AddTravelerResponse(
      status: res.status,
      message: res.message,
      token: res.body["Token"],
    );
  }
}
