import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_check_in/screens/addTraveler/data_source/add_traveler_local_ds.dart';
import 'package:online_check_in/screens/addTraveler/usecases/add_traveler_usecase.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../../core/platform/running_mode_info.dart';
import '../login/data_sources/login_local_ds.dart';
import 'data_source/add_traveler_remote_ds.dart';
import 'interfaces/add_traveler_repository_interface.dart';

class AddTravelerRepository implements AddTravelerRepositoryInterface {
  final AddTravelerRemoteDataSource addTravelerRemoteDataSource = AddTravelerRemoteDataSource();
  final AddTravelerLocalDataSource addTravelerLocalDataSource = AddTravelerLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  AddTravelerRepository();

  @override
  Future<Either<Failure, AddTravelerResponse>> addTraveler(AddTravelerRequest request) async {
    try {
      AddTravelerResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await addTravelerRemoteDataSource.addTraveler(request);
      } else {
        res = await addTravelerLocalDataSource.addTraveler(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
