
import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/add_traveler_data_source_interface.dart';
import '../usecases/add_traveler_usecase.dart';

class AddTravelerLocalDataSource implements AddTravelerDataSourceInterface {
  AddTravelerLocalDataSource();

  @override
  Future<AddTravelerResponse> addTraveler(AddTravelerRequest request) {
    throw UnimplementedError();
  }


}
