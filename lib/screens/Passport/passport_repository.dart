import 'package:dartz/dartz.dart';

import 'package:online_check_in/core/classes/MyCountry.dart';

import 'package:online_check_in/core/classes/PassportType.dart';

import 'package:online_check_in/core/error/failures.dart';
import 'package:online_check_in/screens/Passport/data_source/passport_local_ds.dart';
import 'package:online_check_in/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_check_in/screens/Passport/usecases/select_passport_type_usecase.dart';

import '../../core/error/exception.dart';
import '../../core/platform/network_info.dart';
import 'data_source/passport_remote_ds.dart';
import 'interfaces/passport_repository_interface.dart';

class PassportRepository implements PassportRepositoryInterface {
  final PassportRemoteDataSource passportRemoteDataSource;
  final PassportLocalDataSource passportLocalDataSource;

  final NetworkInfo networkInfo;

  PassportRepository({required this.passportRemoteDataSource, required this.passportLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<MyCountry>>> selectCountries(SelectCountriesRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        List<MyCountry> countriesList = await passportRemoteDataSource.selectCountries(request);
        return Right(countriesList);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("Passport repository: selectCountries"),
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PassPortType>>> selectPassportTypes(SelectPassportTypesRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        List<PassPortType> passportTypesList = await passportRemoteDataSource.selectPassportTypes(request);
        return Right(passportTypesList);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("Passport repository: selectPassportTypes"),
          ),
        ),
      );
    }
  }
}
