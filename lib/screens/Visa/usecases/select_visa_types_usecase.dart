import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/PassportType.dart';
import 'package:online_check_in/core/classes/VisaType.dart';
import 'package:online_check_in/screens/Passport/passport_repository.dart';
import 'package:online_check_in/screens/Visa/visa_repository.dart';
import '../../../core/classes/MyCountry.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class SelectVisaTypesUseCase extends UseCase<List<VisaType>, SelectVisaTypesRequest> {
  final VisaRepository repository;

  SelectVisaTypesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<VisaType>>> call({required SelectVisaTypesRequest request}) {
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
