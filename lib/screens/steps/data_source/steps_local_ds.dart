import 'package:online_checkin_web_refactoring/core/classes/flight_information.dart';
import 'package:online_checkin_web_refactoring/screens/steps/usecases/get_flight_information_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/steps_data_source_interface.dart';

class StepsLocalDataSource implements StepsDataSourceInterface {
  final SharedPreferences sharedPreferences;

  StepsLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<FlightInformation> getFlightInformation(GetFlightInformationRequest request) {
    throw UnimplementedError();
  }

}
