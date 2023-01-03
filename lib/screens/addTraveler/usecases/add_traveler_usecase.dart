import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../add_traveler_repository.dart';


class AddTravelerUseCase extends UseCase<String, AddTravelerRequest> {
  final AddTravelerRepository repository;

  AddTravelerUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call({required AddTravelerRequest request}) {
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
