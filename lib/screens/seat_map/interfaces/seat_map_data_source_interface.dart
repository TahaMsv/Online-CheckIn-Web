import 'package:online_check_in/screens/seat_map/usecases/click_on_seat_usecase.dart';

abstract class SeatMapDataSourceInterface {
  Future<bool> clickOnSeat(ClickOnSeatRequest request);
}
