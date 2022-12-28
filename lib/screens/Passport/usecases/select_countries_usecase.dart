import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_repository.dart';
import '../../../core/classes/MyCountry.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class SelectCountriesUseCase extends UseCase<List<MyCountry>, SelectCountriesRequest> {
  final PassportRepository repository;

  SelectCountriesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MyCountry>>> call({required SelectCountriesRequest request}) {
    return repository.selectCountries(request);
  }
}

class SelectCountriesRequest extends Request {
  SelectCountriesRequest(
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
