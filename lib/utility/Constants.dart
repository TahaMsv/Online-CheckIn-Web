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

  static const baseUrl = 'https://onlinecheckinapi.abomis.com/';
  // static const baseUrl = 'https://onlinecheckinapi-test.abomis.com/';
  static const login = '/api/login';
  static const signUp = '/api/signUp';
  static const getTokenUrl = 'api/Execute';
  static const getInformation = 'api/Execute';
  static const getDocumentType = 'api/Execute';
  static const getSelectCountries = 'api/Execute';
  static const saveDocsDocoDoca = 'api/Execute';
  static const clickOnSeat = 'api/Execute';
  static const reserveSeat = 'api/Execute';
  static const selectBoardingPass = 'api/Execute';
  static const addTransaction = 'api/Execute';
  static const updateTransaction = 'api/Execute';
  static const boardingPassPDF = 'api/MemoStrm';
  static const boardingPassSendEmail = 'http://localhost:64328/api/SendEmail';
  static const getCheckDocoNecessity = 'api/Execute';
  static const selectSeatExtras = 'api/Execute';
}


class MyTheme {
  MyTheme._();

  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.blue,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.deepPurple,
      )));

  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    accentColor: Colors.grey,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: Colors.deepOrange,
    )),
  );
}


class MenuIcons {
  MenuIcons._();

  static const _kFontFam = 'icomoon';
  static const String? _kFontPkg = null;


  static const IconData iconEvent = IconData(0xe934, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconRight = IconData(0xe915, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconLeft = IconData(0xe914, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconAccount = IconData(0xe908, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconInfo = IconData(0xe92d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconPassport= IconData(0xe928, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconVisa= IconData(0xe922, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData star = IconData(0xe940, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconSeat= IconData(0xe924, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconCard= IconData(0xe93b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconTask= IconData(0xe91e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconEdit= IconData(0xe907, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconCalendar= IconData(0xe90a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconLeftArrow= IconData(0xe90e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconRightArrow= IconData(0xe910, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconDownLoad= IconData(0xe946, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconPrint= IconData(0xe906, fontFamily: _kFontFam, fontPackage: _kFontPkg);

}