import 'package:network_manager/network_manager.dart';
import 'package:online_check_in/core/classes/extra.dart';
import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../interfaces/upgrades_data_source_interface.dart';

class UpgradesRemoteDataSource implements UpgradesDataSourceInterface {
  @override
  Future<List<Extra>> getExtras(GetExtrasRequest request) async{
    NetworkRequest selectENR = NetworkRequest(api: Apis.baseUrl + Apis.selectSeatExtras, data: request.toJson(), timeOut: const Duration(seconds: 30));
    NetworkResponse selectEResponse = await selectENR.post();
    if (selectEResponse.responseStatus) {
      try {
        return List<Extra>.from(selectEResponse.responseBody["Body"]["Extras"].map((x) => Extra.fromJson(x)));
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: selectEResponse.responseCode,
        message: selectEResponse.extractedMessage!,
        trace: StackTrace.fromString("UpgradesRemoteDataSource.getExtras"),
      );
    }
  }
}
