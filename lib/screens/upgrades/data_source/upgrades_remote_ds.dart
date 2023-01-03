import 'package:network_manager/network_manager.dart';
import 'package:online_checkin_web_refactoring/core/classes/extra.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/usecases/get_extras_usecase.dart';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../interfaces/upgrades_data_source_interface.dart';

class UpgradesRemoteDataSource implements UpgradesDataSourceInterface {
  @override
  Future<List<Extra>> getExtras(GetExtrasRequest request) async{
    NetworkRequest selectENR = NetworkRequest(api: Apis.baseUrl + Apis.selectSeatExtras, data: request.toJson(), timeOut: const Duration(days: 1));
    NetworkResponse selectEResponse = await selectENR.post();
    print("here13");
    if (selectEResponse.responseStatus) {
      print("here14");
      try {
        print("here15");
        return List<Extra>.from(selectEResponse.responseBody["Body"]["Extras"].map((x) => Extra.fromJson(x)));
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: selectEResponse.responseCode,
        message: selectEResponse.extractedMessage!,
        trace: StackTrace.fromString("PassportRemoteDataSource.login"),
      );
    }
  }
}
