import 'package:flutter/material.dart';
import 'package:onlinecheckin/screens/enterScreen/EnterScreenView.dart';
import 'package:onlinecheckin/screens/stepsScreen/stepsScreenView.dart';
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
        GetPage(name: RouteNames.initialRoute , page:()=> SplashView(_model)),
        GetPage(name: RouteNames.home , page:()=> HomeView(_model)),
        GetPage(name: RouteNames.enter , page:()=> EnterScreenView(_model)),
        GetPage(name: RouteNames.steps , page:()=> StepsScreenView(_model)),
      ],
    );
  }
}
