import 'package:network_manager/network_manager.dart';
import 'package:online_checkin_web_refactoring/screens/seat_map/usecases/click_on_seat_usecase.dart';

import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../interfaces/seat_map_data_source_interface.dart';

class SeatMapRemoteDataSource implements SeatMapDataSourceInterface {
  @override
  Future<bool> clickOnSeat(ClickOnSeatRequest request) async {
    NetworkRequest clickOSNR = NetworkRequest(api: Apis.baseUrl + Apis.clickOnSeat, data: request.toJson(), timeOut: const Duration(seconds: 30));
    NetworkResponse reserveSeatResponse = await clickOSNR.post();
    if (reserveSeatResponse.responseStatus) {
      return true;
    } else {
      throw ServerException(
        code: reserveSeatResponse.responseCode,
        message: reserveSeatResponse.extractedMessage!,
        trace: StackTrace.fromString("SeatMapRemoteDataSource.clickOnSeat"),
      );
    }
  }
}
