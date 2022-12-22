import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/core/classes/flight_information.dart';
import 'package:online_checkin_web_refactoring/screens/steps/usecases/get_flight_information_usecase.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import 'data_source/steps_remote_ds.dart';
import 'interfaces/steps_repository_interface.dart';

class StepsRepository implements StepsRepositoryInterface {
  final StepsRemoteDataSource stepsRemoteDataSource;

  StepsRepository({required this.stepsRemoteDataSource});

  @override
  Future<Either<Failure, FlightInformation>> getFlightInformation(GetFlightInformationRequest request) async {
    try {
      FlightInformation flightInformation = await stepsRemoteDataSource.getFlightInformation(request);
      return Right(flightInformation);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
