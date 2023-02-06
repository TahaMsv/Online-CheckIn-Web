import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/addTraveler/add_traveler_state.dart';
import 'package:online_check_in/screens/payment/payment_state.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import 'package:online_check_in/screens/rules/rules_state.dart';
import 'package:online_check_in/screens/safety/safety_state.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';
import 'package:provider/provider.dart';

import 'core/constants/apis.dart';
import 'core/constants/ui.dart';
import 'core/dependency_injection.dart';
import 'core/navigation/navigation_service.dart';
import 'core/utils/app_config.dart';
import 'my_app.dart';
import 'screens/login/login_state.dart';
import 'screens/login/login_view.dart';

void main() async {
  initializeDateFormatting();
  AppConfig(
    flavor: Flavor.abomis,
    baseUrl: Apis.baseUrl,
    lightTheme: MyTheme.lightAbomis,
    darkTheme: MyTheme.dark,
    // logoAddress: AssetImages.artemis
  );
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => getIt<LoginState>()),
      ChangeNotifierProvider(create: (_) => getIt<StepsState>()),
      ChangeNotifierProvider(create: (_) => getIt<AddTravelerState>()),
      ChangeNotifierProvider(create: (_) => getIt<SafetyState>()),
      ChangeNotifierProvider(create: (_) => getIt<RulesState>()),
      ChangeNotifierProvider(create: (_) => getIt<PassportState>()),
      ChangeNotifierProvider(create: (_) => getIt<VisaState>()),
      ChangeNotifierProvider(create: (_) => getIt<UpgradesState>()),
      ChangeNotifierProvider(create: (_) => getIt<SeatMapState>()),
      ChangeNotifierProvider(create: (_) => getIt<PaymentState>()),
      ChangeNotifierProvider(create: (_) => getIt<ReceiptState>()),
    ],
    child: const MyApp(),
  ));
}
