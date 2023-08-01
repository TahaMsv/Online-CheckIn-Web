import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';

abstract class PassportDataSourceInterface {
  Future<SelectCountriesResponse> selectCountries(SelectCountriesRequest request);

  Future<SelectPassportResponse> selectPassportTypes(SelectPassportTypesRequest request);
}
