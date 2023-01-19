import 'package:dartz/dartz.dart';

import 'package:online_checkin_web_refactoring/core/classes/VisaType.dart';

import 'package:online_checkin_web_refactoring/core/error/failures.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/data_source/visa_local_ds.dart';

import 'package:online_checkin_web_refactoring/screens/Visa/usecases/select_visa_types_usecase.dart';
import '../../core/platform/network_info.dart';
import '../../core/error/exception.dart';
import 'data_source/visa_remote_ds.dart';
import 'interfaces/visa_repository_interface.dart';

class VisaRepository implements VisaRepositoryInterface {
  final VisaRemoteDataSource visaRemoteDataSource;
  final NetworkInfo networkInfo;

  VisaRepository({required this.visaRemoteDataSource, required this.networkInfo, required VisaLocalDataSource visaLocalDataSource});

  @override
  Future<Either<Failure, List<VisaType>>> selectVisaTypes(SelectVisaTypesRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        List<VisaType> visaTypesList = await visaRemoteDataSource.selectVisaTypes(request);
        return Right(visaTypesList);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {
      return Left(
        ConnectionFailure.fromAppException(
          ConnectionException(
            message: "You are not connected to internet!",
            trace: StackTrace.fromString("Visa repository: selectVisaTypes"),
          ),
        ),
      );
    }
  }
}
