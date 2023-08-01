import 'package:online_check_in/core/classes/extra.dart';
import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/upgrades_data_source_interface.dart';

class UpgradesLocalDataSource implements UpgradesDataSourceInterface {

  UpgradesLocalDataSource();

  @override
  Future<GetExtrasResponse> getExtras(GetExtrasRequest request) {
    throw UnimplementedError();
  }

}
