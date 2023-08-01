import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/screens/steps/data_source/steps_local_ds.dart';
import 'package:online_check_in/screens/steps/usecases/get_flight_information_usecase.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../../core/platform/running_mode_info.dart';
import 'data_source/steps_remote_ds.dart';
import 'interfaces/steps_repository_interface.dart';

class StepsRepository implements StepsRepositoryInterface {
  final StepsRemoteDataSource stepsRemoteDataSource = StepsRemoteDataSource();
  final StepsLocalDataSource stepsLocalDataSource = StepsLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  StepsRepository();

  @override
  Future<Either<Failure, GetFlightInformationResponse>> getFlightInformation(GetFlightInformationRequest request) async {
    try {
      GetFlightInformationResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await stepsRemoteDataSource.getFlightInformation(request);
      } else {
        res = await stepsLocalDataSource.getFlightInformation(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
