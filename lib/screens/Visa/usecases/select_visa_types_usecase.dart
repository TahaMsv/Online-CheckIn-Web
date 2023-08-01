import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/passport_type.dart';
import 'package:online_check_in/core/classes/visa_type.dart';
import 'package:online_check_in/screens/Passport/passport_repository.dart';
import 'package:online_check_in/screens/Visa/visa_repository.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/classes/my_country.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class SelectVisaTypesUseCase extends UseCase<SelectVisaResponse, SelectVisaTypesRequest> {
  final VisaRepository repository;

  SelectVisaTypesUseCase({required this.repository});

  @override
  Future<Either<Failure, SelectVisaResponse>> call({required SelectVisaTypesRequest request}) {
    return repository.selectVisaTypes(request);
  }
}

class SelectVisaTypesRequest extends Request {
  SelectVisaTypesRequest();

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[SelectDocumentTypes]",
          "Token": token,
          "Request": {},
        },
      };
}

class SelectVisaResponse extends Response {
  final List<VisaType> visaTypesList;

  SelectVisaResponse({
    required int status,
    required String message,
    required this.visaTypesList,
  }) : super(message: message, status: status, body: visaTypesList);

  factory SelectVisaResponse.fromResponse(Response res) {
    return SelectVisaResponse(
      status: res.status,
      message: res.message,
      visaTypesList: List<VisaType>.from(res.body["VisaTypes"].map((x) => VisaType.fromJson(x))),
    );
  }
}
