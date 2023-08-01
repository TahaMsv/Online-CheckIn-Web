import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

import 'core/constants/apis.dart';
import 'core/constants/ui.dart';
import 'core/utils/app_config.dart';
import 'initialize.dart';
import 'my_app.dart';
import 'screens/login/login_state.dart';

// void main() async {
//   // initializeDateFormatting();
//   AppConfig(
//     flavor: Flavor.abomis,
//     baseUrl: Apis.baseUrl,
//     lightTheme: MyTheme.lightAbomis,
//     darkTheme: MyTheme.dark,
//     // logoAddress: AssetImages.artemis
//   );
//   WidgetsFlutterBinding.ensureInitialized();
//    // MyRouter.initialize();
//   await init();
//   //
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => getIt<LoginState>()),
//       ChangeNotifierProvider(create: (_) => ref.read(stepsProvider);;),
//       ChangeNotifierProvider(create: (_) => getIt<AddTravelerState>()),
//       ChangeNotifierProvider(create: (_) => getIt<SafetyState>()),
//       ChangeNotifierProvider(create: (_) => getIt<RulesState>()),
//       ChangeNotifierProvider(create: (_) => getIt<PassportState>()),
//       ChangeNotifierProvider(create: (_) => getIt<VisaState>()),
//       ChangeNotifierProvider(create: (_) => getIt<UpgradesState>()),
//       ChangeNotifierProvider(create: (_) => getIt<SeatMapState>()),
//       ChangeNotifierProvider(create: (_) => getIt<PaymentState>()),
//       ChangeNotifierProvider(create: (_) => getIt<ReceiptState>()),
//     ],
//     child:  MyApp(),
//   ));
//
//   // runApp(MyApp(),);
// }

void main() async {
  AppConfig(
    flavor: Flavor.abomis,
    baseUrl: Apis.baseUrl,
    lightTheme: MyTheme.lightAbomis,
    darkTheme: MyTheme.dark,
    // logoAddress: AssetImages.artemis
  );

  await init();
  runApp(ProviderScope(child: Consumer(builder: (builder, ref, c) {
    return const MyApp();
  })));
}
