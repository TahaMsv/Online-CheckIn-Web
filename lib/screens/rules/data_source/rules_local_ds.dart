import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/rules_data_source_interface.dart';

class RulesLocalDataSource implements RulesDataSourceInterface {
  final SharedPreferences sharedPreferences;

  RulesLocalDataSource({
    required this.sharedPreferences,
  });

}

