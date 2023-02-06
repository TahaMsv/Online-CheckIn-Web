import 'package:online_check_in/core/classes/VisaType.dart';
import 'package:online_check_in/screens/Visa/usecases/select_visa_types_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/visa_data_source_interface.dart';

class VisaLocalDataSource implements VisaDataSourceInterface {
  final SharedPreferences sharedPreferences;

  VisaLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<List<VisaType>> selectVisaTypes(SelectVisaTypesRequest request) {
    throw UnimplementedError();
  }


}
