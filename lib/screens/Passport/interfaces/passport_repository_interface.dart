import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';
import '../../../core/error/failures.dart';

abstract class PassportRepositoryInterface {
  Future<Either<Failure, SelectCountriesResponse>> selectCountries(SelectCountriesRequest request);

  Future<Either<Failure, SelectPassportResponse>> selectPassportTypes(SelectPassportTypesRequest request);
}
