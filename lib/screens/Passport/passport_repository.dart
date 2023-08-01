import 'package:dartz/dartz.dart';

import 'package:online_check_in/core/classes/my_country.dart';

import 'package:online_check_in/core/classes/passport_type.dart';

import 'package:online_check_in/core/error/failures.dart';
import 'package:online_check_in/screens/Passport/data_source/passport_local_ds.dart';
import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';

import 'package:online_check_in/initialize.dart';
import '../../core/error/exception.dart';
import '../../core/platform/network_info.dart';
import '../../core/platform/running_mode_info.dart';
import 'data_source/passport_remote_ds.dart';
import 'interfaces/passport_repository_interface.dart';

class PassportRepository implements PassportRepositoryInterface {
  final PassportRemoteDataSource passportRemoteDataSource = PassportRemoteDataSource();

  final PassportLocalDataSource passportLocalDataSource = PassportLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  PassportRepository();

  @override
  Future<Either<Failure, SelectCountriesResponse>> selectCountries(SelectCountriesRequest request) async {
    try {
      SelectCountriesResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await passportRemoteDataSource.selectCountries(request);
      } else {
        res = await passportLocalDataSource.selectCountries(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Either<Failure, SelectPassportResponse>> selectPassportTypes(SelectPassportTypesRequest request) async {
    try {
      SelectPassportResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await passportRemoteDataSource.selectPassportTypes(request);
      } else {
        res = await passportLocalDataSource.selectPassportTypes(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
