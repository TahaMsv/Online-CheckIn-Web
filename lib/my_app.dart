import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/navigation/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        // statusBarColor: AppConfig.themeLight!.appBarTheme.backgroundColor, // Color for Android
        // statusBarColor: Colors.white, // Color for Android
        statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
        ));

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: Locale('en', 'US'),
      // theme: AppConfig.themeLight,
      routeInformationParser: MyRouter.router.routeInformationParser,
      routeInformationProvider: MyRouter.router.routeInformationProvider,
      routerDelegate: MyRouter.router.routerDelegate,
    );
  }
}
