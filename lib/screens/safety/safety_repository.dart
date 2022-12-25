import 'data_source/safety_remote_ds.dart';
import 'interfaces/safety_repository_interface.dart';

class SafetyRepository implements SafetyRepositoryInterface {
  final SafetyRemoteDataSource safetyRemoteDataSource;

  SafetyRepository({required this.safetyRemoteDataSource});
}