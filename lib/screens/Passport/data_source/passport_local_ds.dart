import 'package:online_check_in/core/classes/MyCountry.dart';
import 'package:online_check_in/core/classes/PassportType.dart';
import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/passport_data_source_interface.dart';

class PassportLocalDataSource implements PassportDataSourceInterface {
  final SharedPreferences sharedPreferences;

  PassportLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<List<MyCountry>> selectCountries(SelectCountriesRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<List<PassPortType>> selectPassportTypes(SelectPassportTypesRequest request) {
    throw UnimplementedError();
  }
}
