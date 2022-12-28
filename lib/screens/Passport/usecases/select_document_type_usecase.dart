import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/core/classes/PassportType.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_repository.dart';
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
  SelectPassportTypesRequest(
    this.execution,
    this.token,
    this.request,
  );

  final String execution;
  final dynamic token;
  final Map<String, dynamic> request;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": execution,
          "Token": null,
          "Request": request,
        },
      };
}
