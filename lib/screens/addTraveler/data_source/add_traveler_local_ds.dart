
import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/add_traveler_data_source_interface.dart';
import '../usecases/add_traveler_usecase.dart';

class AddTravelerLocalDataSource implements AddTravelerDataSourceInterface {
  final SharedPreferences sharedPreferences;

  AddTravelerLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<String> addTraveler(AddTravelerRequest request) {
    throw UnimplementedError();
  }


}
