

import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';

import '../../../core/classes/MyCountry.dart';
import '../../../core/classes/PassportType.dart';

abstract class PassportDataSourceInterface{
  Future<List<MyCountry>> selectCountries(SelectCountriesRequest request);
  Future< List<PassPortType>> selectPassportTypes(SelectPassportTypesRequest request);

}