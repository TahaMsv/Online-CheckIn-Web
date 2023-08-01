import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/Passport/passport_repository.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/classes/my_country.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';

class SelectCountriesUseCase extends UseCase<SelectCountriesResponse, SelectCountriesRequest> {
  final PassportRepository repository;

  SelectCountriesUseCase({required this.repository});

  @override
  Future<Either<Failure, SelectCountriesResponse>> call({required SelectCountriesRequest request}) {
    return repository.selectCountries(request);
  }
}

class SelectCountriesRequest extends Request {
  SelectCountriesRequest();

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[SelectCountries]",
          "Token": token,
          "Request": {},
        },
      };
}

class SelectCountriesResponse extends Response {
  final List<MyCountry> countriesList;

  SelectCountriesResponse({
    required int status,
    required String message,
    required this.countriesList,
  }) : super(message: message, status: status, body: countriesList);

  factory SelectCountriesResponse.fromResponse(Response res) {
    return SelectCountriesResponse(
      status: res.status,
      message: res.message,
      countriesList: List<MyCountry>.from(res.body["Countries"].map((x) => MyCountry.fromJson(x))),
    );
  }
}
