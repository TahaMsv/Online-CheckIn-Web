import 'package:dartz/dartz.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/classes/extra.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../upgrades_repository.dart';

class GetExtrasUseCase extends UseCase<GetExtrasResponse, GetExtrasRequest> {
  final UpgradesRepository repository;

  GetExtrasUseCase({required this.repository});

  @override
  Future<Either<Failure, GetExtrasResponse>> call({required GetExtrasRequest request}) {
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

class GetExtrasResponse extends Response {
  List<Extra> extras;

  GetExtrasResponse({
    required int status,
    required String message,
    required this.extras,
  }) : super(message: message, status: status, body: extras);

  factory GetExtrasResponse.fromResponse(Response res) {
    return GetExtrasResponse(
      status: res.status,
      message: res.message,
      extras: List<Extra>.from(res.body["Extras"].map((x) => Extra.fromJson(x))),
    );
  }
}
