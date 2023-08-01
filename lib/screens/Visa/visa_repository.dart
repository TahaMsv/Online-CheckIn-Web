import 'package:dartz/dartz.dart';

import 'package:online_check_in/core/classes/visa_type.dart';

import 'package:online_check_in/core/error/failures.dart';
import 'package:online_check_in/screens/Visa/data_source/visa_local_ds.dart';

import 'package:online_check_in/screens/Visa/usecases/select_visa_types_usecase.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/platform/network_info.dart';
import '../../core/error/exception.dart';
import '../../core/platform/running_mode_info.dart';
import '../Passport/usecases/select_passport_type_usecase.dart';
import 'data_source/visa_remote_ds.dart';
import 'interfaces/visa_repository_interface.dart';

class VisaRepository implements VisaRepositoryInterface {
  final VisaRemoteDataSource visaRemoteDataSource = VisaRemoteDataSource();
  final VisaLocalDataSource visaLocalDataSource = VisaLocalDataSource();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  VisaRepository();

  @override
  Future<Either<Failure, SelectVisaResponse>> selectVisaTypes(SelectVisaTypesRequest request) async {
    try {
      SelectVisaResponse res;
      if (RunningModeInfo.runningType().isTest || await networkInfo.isConnected) {
        res = await visaRemoteDataSource.selectVisaTypes(request);
      } else {
        res = await visaLocalDataSource.selectVisaTypes(request);
      }
      return Right(res);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }
}
