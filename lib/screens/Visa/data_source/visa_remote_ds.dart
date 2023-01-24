
import 'package:online_checkin_web_refactoring/core/classes/VisaType.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/usecases/select_visa_types_usecase.dart';
import 'package:network_manager/network_manager.dart';
import '../../../core/constants/apis.dart';
import '../../../core/error/exception.dart';
import '../interfaces/visa_data_source_interface.dart';

class VisaRemoteDataSource implements VisaDataSourceInterface {
  @override
  Future<List<VisaType>> selectVisaTypes(SelectVisaTypesRequest request)async {
    NetworkRequest selectVTNR = NetworkRequest(api: Apis.baseUrl + Apis.getDocumentType, data: request.toJson(), timeOut: const Duration(seconds: 10));
    NetworkResponse selectVTResponse = await selectVTNR.post();
    if (selectVTResponse.responseStatus) {
      try {
        return List<VisaType>.from(selectVTResponse.responseBody["Body"]["VisaTypes"].map((x) => VisaType.fromJson(x)));
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: selectVTResponse.responseCode,
        message: selectVTResponse.extractedMessage!,
        trace: StackTrace.fromString("VisaRemoteDataSource.selectVisaTypes"),
      );
    }
  }

}
