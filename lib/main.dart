import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:online_checkin_web_refactoring/screens/addTraveler/add_traveler_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:online_checkin_web_refactoring/utils/shortcuts/app_config.dart';
import 'package:provider/provider.dart';

import 'core/constants/apis.dart';
import 'core/constants/ui.dart';
import 'core/dependency_injection.dart';
import 'core/navigation/navigation_service.dart';
import 'my_app.dart';
import 'screens/login/login_state.dart';
import 'screens/login/login_view.dart';

void main() async {
  initializeDateFormatting();
  AppConfig(
    flavor: Flavor.abomis,
    baseUrl: Apis.baseUrl,
    // lightTheme: MyTheme.lightAbomis,
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
    ],
    child: const MyApp(),
  ));
}
