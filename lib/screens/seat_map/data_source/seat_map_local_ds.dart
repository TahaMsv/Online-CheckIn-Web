import 'package:online_checkin_web_refactoring/screens/seat_map/usecases/click_on_seat_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/seat_map_data_source_interface.dart';

class SeatMapLocalDataSource implements SeatMapDataSourceInterface {
  final SharedPreferences sharedPreferences;

  SeatMapLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<bool> clickOnSeat(ClickOnSeatRequest request) {
    throw UnimplementedError();
  }
}
