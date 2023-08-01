import '../../../core/classes/flight_information.dart';
import '../usecases/get_flight_information_usecase.dart';

abstract class StepsDataSourceInterface {
  Future<GetFlightInformationResponse> getFlightInformation(GetFlightInformationRequest request);
}
