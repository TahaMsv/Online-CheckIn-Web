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
  static const payment = '/paymentScreen';
  static const upgrades = '/upgradesScreen';
  static const receipt = '/receiptScreen';
  static const seats = '/seatsScreen';

}

class Apis {
  Apis._();
  static const baseUrl = '';
  static const login = '/api/login';
  static const signUp = '/api/signUp';
  static const getTokenUrl = '';
  static const getInformation = '';
  static const getDocumentType = '';
  static const getSelectCountries = '';


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

