import 'package:online_checkin_web_refactoring/screens/seat_map/usecases/click_on_seat_usecase.dart';

abstract class SeatMapDataSourceInterface {
  Future<bool> clickOnSeat(ClickOnSeatRequest request);
}
