
import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_passport_type_usecase.dart';
import '../../../core/classes/MyCountry.dart';
import '../../../core/classes/PassportType.dart';
import '../../../core/error/failures.dart';

abstract class PassportRepositoryInterface{
  Future<Either<Failure, List<MyCountry>>> selectCountries(SelectCountriesRequest request);
  Future<Either<Failure, List<PassPortType>>> selectPassportTypes(SelectPassportTypesRequest request);
}