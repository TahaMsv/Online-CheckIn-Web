import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../core/classes/flight_information.dart';
import '../usecases/get_flight_information_usecase.dart';


abstract class StepsRepositoryInterface {
  Future<Either<Failure, GetFlightInformationResponse>> getFlightInformation(GetFlightInformationRequest request);
}
