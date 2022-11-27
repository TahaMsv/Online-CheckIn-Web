import 'package:flutter/material.dart';
import 'package:onlinecheckin/screens/enterScreen/EnterScreenTabletView.dart';
import 'package:onlinecheckin/screens/safetyStepScreen/SafetyStepTabletView.dart';
import 'package:onlinecheckin/screens/stepsScreen/StepsScreenTabletView.dart';
import '../../screens/seatsStepScreen/SeatStepScreenView.dart';
import 'screens/receiptStepScreen/ReceipStepView.dart';
import 'screens/upgradesStepScreen/UpgradesStepView.dart';
import 'screens/paymentStepScreen/PaymentStepView.dart';
import 'screens/visaStepScreen/VisaStepView.dart';
import 'screens/passportStepScreen/PassportStepView.dart';
import 'screens/rulesStepScreen/RulesStepView.dart';
import 'screens/homeScreen/HomeView.dart';
import 'utility/Constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'global/MainModel.dart';
import 'global/AppConfig.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainModel _model = context.watch<MainModel>();
    return GetMaterialApp(
      enableLog: false,
      debugShowCheckedModeBanner: false,
      theme: AppConfig.themeLight,
      initialRoute: RouteNames.enter,
      translations: TranslatedWords(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      getPages: [
        // GetPage(name: RouteNames.initialRoute, page: () => SplashView(_model)),
        GetPage(name: RouteNames.home, page: () => HomeView(_model)),
        GetPage(
            name: RouteNames.enter,
            page: () =>
                // EnterScreenView(_model)),
                EnterScreenTabletView(_model)),
        GetPage(name: RouteNames.steps, page: () =>
            StepsScreenTabletView(_model)),
        // StepsScreenView(_model)),
        GetPage(name: RouteNames.safety, page: () =>
            SafetyStepTabletView(_model)),
            // SafetyStepView(_model)),
        GetPage(name: RouteNames.rules, page: () => RulesStepView(_model)),
        GetPage(name: RouteNames.passport, page: () => PassportStepView(_model)),
        GetPage(name: RouteNames.visa, page: () => VisaStepView(_model)),
        GetPage(name: RouteNames.payment, page: () => PaymentStepView(_model)),
        GetPage(name: RouteNames.upgrades, page: () => UpgradesStepView(_model)),
        GetPage(name: RouteNames.receipt, page: () => ReceiptStepView(_model)),
        GetPage(name: RouteNames.seats, page: () => SeatsStepView(_model)),
      ],
    );
  }
}
