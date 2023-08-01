import 'package:online_check_in/screens/seat_map/usecases/click_on_seat_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/seat_map_data_source_interface.dart';

class SeatMapLocalDataSource implements SeatMapDataSourceInterface {

  SeatMapLocalDataSource();

  @override
  Future<ClickOnSeatResponse> clickOnSeat(ClickOnSeatRequest request) {
    throw UnimplementedError();
  }
}
