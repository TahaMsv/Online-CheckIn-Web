import 'package:online_check_in/core/classes/extra.dart';
import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/upgrades_data_source_interface.dart';

class UpgradesLocalDataSource implements UpgradesDataSourceInterface {
  final SharedPreferences sharedPreferences;

  UpgradesLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<List<Extra>> getExtras(GetExtrasRequest request) {
    throw UnimplementedError();
  }

}
