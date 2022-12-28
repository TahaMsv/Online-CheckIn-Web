

import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_document_type_usecase.dart';

import '../../../core/classes/MyCountry.dart';
import '../../../core/classes/PassportType.dart';

abstract class PassportDataSourceInterface{
  Future<List<MyCountry>> selectCountries(SelectCountriesRequest request);
  Future< List<PassPortType>> selectPassportTypes(SelectPassportTypesRequest request);

}