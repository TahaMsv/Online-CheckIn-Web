import 'package:dartz/dartz.dart';
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
  GetExtrasRequest();

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[SelectSeatExtras]",
          "Token": token,
          "Request": {},
        },
      };
}
