import 'package:shared_preferences/shared_preferences.dart';

import '../interface/payment_data_source_interface.dart';

class PaymentLocalDataSource implements PaymentDataSourceInterface {
  final SharedPreferences sharedPreferences;

  PaymentLocalDataSource({
    required this.sharedPreferences,
  });

}
