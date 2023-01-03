import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/data_source/add_traveler_local_ds.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/usecases/add_traveler_usecase.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/platform/network_info.dart';
import '../login/data_sources/login_local_ds.dart';
import 'data_source/add_traveler_remote_ds.dart';
import 'interfaces/add_traveler_repository_interface.dart';

class AddTravelerRepository implements AddTravelerRepositoryInterface {
  final AddTravelerRemoteDataSource addTravelerRemoteDataSource;
  final AddTravelerLocalDataSource addTravelerLocalDataSource;
  final NetworkInfo networkInfo;

  AddTravelerRepository({required this.addTravelerRemoteDataSource, required this.addTravelerLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> addTraveler(AddTravelerRequest request) async{
    if (await networkInfo.isConnected) {
      try {
        String token = await addTravelerRemoteDataSource.addTraveler(request);
        return Right(token);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("Add Traveler repository: addTraveler"),
          ),
        ),
      );

    }
  }
}
