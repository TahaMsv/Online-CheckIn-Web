import 'package:dartz/dartz.dart';

import 'package:online_checkin_web_refactoring/core/classes/MyCountry.dart';

import 'package:online_checkin_web_refactoring/core/classes/PassportType.dart';

import 'package:online_checkin_web_refactoring/core/error/failures.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_countries_usecase.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/usecases/select_document_type_usecase.dart';

import '../../core/error/exception.dart';
import 'data_source/passport_remote_ds.dart';
import 'interfaces/passport_repository_interface.dart';

class PassportRepository implements PassportRepositoryInterface {
  final PassportRemoteDataSource passportRemoteDataSource;

  PassportRepository({required this.passportRemoteDataSource});

  @override
  Future<Either<Failure, List<MyCountry>>> selectCountries(SelectCountriesRequest request) async {
    try {
      List<MyCountry> countriesList = await passportRemoteDataSource.selectCountries(request);
      return Right(countriesList);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Either<Failure, List<PassPortType>>> selectPassportTypes(SelectPassportTypesRequest request) async {
    try {
      List<PassPortType> passportTypesList = await passportRemoteDataSource.selectPassportTypes(request);
      return Right(passportTypesList);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
