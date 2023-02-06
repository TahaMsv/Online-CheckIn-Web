import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/PassportType.dart';
import 'package:online_check_in/screens/Passport/passport_repository.dart';
import '../../../core/classes/MyCountry.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class SelectPassportTypesUseCase extends UseCase<List<PassPortType>, SelectPassportTypesRequest> {
  final PassportRepository repository;

  SelectPassportTypesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PassPortType>>> call({required SelectPassportTypesRequest request}) {
    return repository.selectPassportTypes(request);
  }
}

class SelectPassportTypesRequest extends Request {
  SelectPassportTypesRequest();
  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[SelectDocumentTypes]",
          "Token": token,
          "Request": {},
        },
      };
}
