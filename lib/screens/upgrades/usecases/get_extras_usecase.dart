import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_repository.dart';
import '../../../core/classes/extra.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../upgrades_repository.dart';

class GetExtrasUseCase extends UseCase<List<Extra>, GetExtrasRequest> {
  final UpgradesRepository repository;

  GetExtrasUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Extra>>> call({required GetExtrasRequest request}) {
    return repository.getExtras(request);
  }
}

class GetExtrasRequest extends Request {
  GetExtrasRequest(
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
