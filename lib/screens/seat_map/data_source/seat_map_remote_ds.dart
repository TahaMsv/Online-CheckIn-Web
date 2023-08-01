import 'package:online_check_in/screens/seat_map/usecases/click_on_seat_usecase.dart';

import '../../../core/abstract/response_abs.dart';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../../../core/platform/network_manager.dart';
import '../../login/usecases/login_usecase.dart';
import '../interfaces/seat_map_data_source_interface.dart';

class SeatMapRemoteDataSource implements SeatMapDataSourceInterface {
  final NetworkManager networkManager = NetworkManager();

  @override
  Future<ClickOnSeatResponse> clickOnSeat(ClickOnSeatRequest request) async {
    MyResponse res = await networkManager.myPost(request);
    return ClickOnSeatResponse.fromResponse(res);

    // NetworkRequest clickOSNR = NetworkRequest(api: Apis.baseUrl + Apis.clickOnSeat, data: request.toJson(), timeOut: const Duration(seconds: 30));
    // NetworkResponse reserveSeatResponse = await clickOSNR.post();
    // if (reserveSeatResponse.responseStatus) {
    //   return true;
    // } else {
    //   throw ServerException(
    //     code: reserveSeatResponse.responseCode,
    //     message: reserveSeatResponse.extractedMessage!,
    //     trace: StackTrace.fromString("SeatMapRemoteDataSource.clickOnSeat"),
    //   );
    // }
  }
}
