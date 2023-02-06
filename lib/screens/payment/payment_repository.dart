
import '../../core/platform/network_info.dart';
import 'data_source/payment_local_ds.dart';
import 'data_source/payment_remote_ds.dart';
import 'interface/payment_repository_interface.dart';

class PaymentRepository implements PaymentRepositoryInterface {
  final PaymentRemoteDataSource paymentRemoteDataSource;
  final PaymentLocalDataSource paymentLocalDataSource;
  final NetworkInfo networkInfo;

  PaymentRepository({required this.paymentRemoteDataSource,required this.paymentLocalDataSource,required this.networkInfo,});
}
