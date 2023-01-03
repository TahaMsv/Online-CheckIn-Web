
import 'data_source/visa_remote_ds.dart';
import 'interfaces/visa_repository_interface.dart';

class VisaRepository implements VisaRepositoryInterface {
  final VisaRemoteDataSource visaRemoteDataSource;

  VisaRepository({required this.visaRemoteDataSource});
}
