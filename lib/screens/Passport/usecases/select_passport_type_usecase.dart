import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/passport_type.dart';
import 'package:online_check_in/screens/Passport/passport_repository.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/classes/my_country.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class SelectPassportTypesUseCase extends UseCase<SelectPassportResponse, SelectPassportTypesRequest> {
  final PassportRepository repository;

  SelectPassportTypesUseCase({required this.repository});

  @override
  Future<Either<Failure, SelectPassportResponse>> call({required SelectPassportTypesRequest request}) {
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

class SelectPassportResponse extends Response {
  List<PassPortType> passportTypesList;

  SelectPassportResponse({
    required int status,
    required String message,
    required this.passportTypesList,
  }) : super(message: message, status: status, body: passportTypesList);

  factory SelectPassportResponse.fromResponse(Response res) {
    return SelectPassportResponse(
      status: res.status,
      message: res.message,
      passportTypesList: List<PassPortType>.from(res.body["PassportTypes"].map((x) => PassPortType.fromJson(x))),
    );
  }
}
