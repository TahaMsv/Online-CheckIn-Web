import 'package:online_check_in/core/classes/visa_type.dart';
import 'package:online_check_in/screens/Visa/usecases/select_visa_types_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/visa_data_source_interface.dart';

class VisaLocalDataSource implements VisaDataSourceInterface {

  VisaLocalDataSource();

  @override
  Future<SelectVisaResponse> selectVisaTypes(SelectVisaTypesRequest request) {
    throw UnimplementedError();
  }


}
