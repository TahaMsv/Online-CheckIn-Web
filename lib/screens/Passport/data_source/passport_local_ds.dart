import 'package:online_check_in/core/classes/my_country.dart';
import 'package:online_check_in/core/classes/passport_type.dart';
import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/passport_data_source_interface.dart';

class PassportLocalDataSource implements PassportDataSourceInterface {

  PassportLocalDataSource();

  @override
  Future<SelectCountriesResponse> selectCountries(SelectCountriesRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<SelectPassportResponse> selectPassportTypes(SelectPassportTypesRequest request) {
    throw UnimplementedError();
  }
}
