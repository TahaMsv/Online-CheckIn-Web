import 'package:flutter/material.dart';
import 'package:onlinecheckin/screens/visaStepScreen/VisaStepView.dart';
import 'screens/passportStepScreen/PassportStepView.dart';
import 'screens/enterScreen/EnterScreenView.dart';
import 'screens/rulesStepScreen/RulesStepView.dart';
import 'screens/safetyStepScreen/SafetyStepView.dart';
import 'screens/stepsScreen/StepsScreenView.dart';
import 'screens/homeScreen/HomeView.dart';
import 'utility/Constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'global/MainModel.dart';
import 'screens/splashScreen/SplashView.dart';
import 'global/AppConfig.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainModel _model = context.watch<MainModel>();
    return GetMaterialApp(
      enableLog: false,
      debugShowCheckedModeBanner: false,
      theme: AppConfig.themeLight,
      initialRoute: RouteNames.steps,
      getPages: [
        GetPage(name: RouteNames.initialRoute, page: () => SplashView(_model)),
        GetPage(name: RouteNames.home, page: () => HomeView(_model)),
        GetPage(name: RouteNames.enter, page: () => EnterScreenView(_model)),
        GetPage(name: RouteNames.steps, page: () => StepsScreenView(_model)),
        GetPage(name: RouteNames.safety, page: () => SafetyStepView(_model)),
        GetPage(name: RouteNames.rules, page: () => RulesStepView(_model)),
        GetPage(
            name: RouteNames.passport, page: () => PassportStepView(_model)),
        GetPage(name: RouteNames.visa, page: () => VisaStepView(_model)),
      ],
    );
  }
}
