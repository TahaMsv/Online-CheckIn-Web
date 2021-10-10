import 'package:flutter/material.dart';

class RouteNames {
  RouteNames._();
  static const initialRoute = '/';
  static const splash = '/splashScreen';
  static const home = '/homeScreen';
  static const enter = '/enterScreen';
  static const steps = '/stepsScreen';
  static const safety = '/safetyScreen';
  static const rules = '/rulesScreen';
  static const passport = '/passportScreen';
  static const visa = '/visaScreen';

}

class Apis {
  Apis._();
  static const baseUrl = 'http://www.google.com';
  static const login = '/api/login';
  static const signUp = '/api/signUp';
}

class MyTheme {
  MyTheme._();

  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: Colors.deepOrange,
    accentColor: Colors.blue,
    textButtonTheme:TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.deepPurple,
      )
    )
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    accentColor: Colors.grey,
    textButtonTheme:TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.deepOrange,
          )
    ),
  );

}

