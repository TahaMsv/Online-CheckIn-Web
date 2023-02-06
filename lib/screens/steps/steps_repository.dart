import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/screens/steps/data_source/steps_local_ds.dart';
import 'package:online_check_in/screens/steps/usecases/get_flight_information_usecase.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import 'data_source/steps_remote_ds.dart';
import 'interfaces/steps_repository_interface.dart';

class StepsRepository implements StepsRepositoryInterface {
  final StepsRemoteDataSource stepsRemoteDataSource;
  final StepsLocalDataSource stepsLocalDataSource;
  final NetworkInfo networkInfo;
  StepsRepository( {required this.stepsRemoteDataSource,required this.stepsLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, FlightInformation>> getFlightInformation(GetFlightInformationRequest request) async {
    if(await networkInfo.isConnected){
      try {
        FlightInformation flightInformation = await stepsRemoteDataSource.getFlightInformation(request);
        return Right(flightInformation);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    }else{
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("Steps repository: getFlightInformation"),
          ),
        ),
      );
    }

  }
}
