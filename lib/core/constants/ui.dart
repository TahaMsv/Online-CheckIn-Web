import 'package:flutter/material.dart';

class MyColors {
  MyColors._();

  static const mainColor = Color(0xff48c0a2);
  static const myBlue = Color(0xff4c6ef6);
  static const black = Colors.black;
  static const grey = Colors.grey;
  static const white = Colors.white;
  static const white1 = Color(0xffeaeaea);
  static const brownGrey = Color.fromRGBO(141, 141, 141, 1);
  static const darkGrey = Color(0xff424242);
  static const lightGrey = Color(0xff808080);
  static const sonicSilver = Color(0xff767676);
  static const oceanGreen = Color(0xff48c0a2);
  static const brightYellow = Color(0xffffae2c);

  static const materialColor = {
    50: Color.fromRGBO(77, 111, 255, .1),
    100: Color.fromRGBO(77, 111, 255, .2),
    200: Color.fromRGBO(77, 111, 255, .3),
    300: Color.fromRGBO(77, 111, 255, .4),
    400: Color.fromRGBO(77, 111, 255, .5),
    500: Color.fromRGBO(77, 111, 255, .6),
    600: Color.fromRGBO(77, 111, 255, .7),
    700: Color.fromRGBO(77, 111, 255, .8),
    800: Color.fromRGBO(77, 111, 255, .9),
    900: Color.fromRGBO(77, 111, 255, 1),
  };
}

class MyTextTheme {
  MyTextTheme._();

  static const boldWhite24 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.white);
  static const boldWhite16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.white);
  static const white16 = TextStyle(fontSize: 16, color: MyColors.white);
  static const white12 = TextStyle(fontSize: 12, color: MyColors.white);
  static const boldDarkGray18 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: MyColors.darkGrey);
  static const boldDarkGray30 = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: MyColors.darkGrey);
  static const boldDarkGray24 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.darkGrey);
  static const w800MainColor15 = TextStyle(fontSize: 15, color: MyColors.mainColor, fontWeight: FontWeight.w800);
  static const lightGrey14 = TextStyle(fontSize: 14, color: MyColors.lightGrey);
  static const w300DarkGrey14 = TextStyle(color: MyColors.darkGrey, fontSize: 14, fontWeight: FontWeight.w300);
  static const w800MainColor22 = TextStyle(fontSize: 22, color: MyColors.mainColor, fontWeight: FontWeight.w800);
  static const lightGrey20 = TextStyle(fontSize: 20, color: MyColors.lightGrey);
}

class MyTheme {
  MyTheme._();

  static ThemeData lightAbomis = ThemeData(
    fontFamily: "OpenSans",
    primaryColor: MyColors.white,
    canvasColor: Colors.transparent,
    brightness: Brightness.light,
    disabledColor: MyColors.brownGrey,
    scaffoldBackgroundColor: MyColors.white,

    timePickerTheme: const TimePickerThemeData(),

    // fontFamily: "OpenSans",
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.darkGrey),
      headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.darkGrey),
      headline3: TextStyle(fontSize: 20, color: MyColors.darkGrey),
      headline4: TextStyle(
        fontSize: 18,
        color: MyColors.darkGrey,
      ),
      headline5: TextStyle(fontSize: 16, color: MyColors.darkGrey),
      headline6: TextStyle(fontSize: 14, color: MyColors.darkGrey),
      subtitle1: TextStyle(fontSize: 12, color: MyColors.darkGrey),
      subtitle2: TextStyle(fontSize: 10, color: MyColors.darkGrey),

      // bodyLarge: const TextStyle(fontSize: 14, color: Colors.black),
      // bodyMedium: const TextStyle(fontSize: 12, color: Colors.black),
      // bodySmall: const TextStyle(fontSize: 10, color: Colors.black),
    ),
  );

  // static ThemeData light = ThemeData.light().copyWith(
  //     primaryColor: MyColors.white,
  //     accentColor: MyColors.white,
  //     textButtonTheme: TextButtonThemeData(
  //         style: TextButton.styleFrom(
  //       primary: Colors.deepPurple,
  //     )));

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
  static const IconData iconPassport = IconData(0xe928, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconVisa = IconData(0xe922, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData star = IconData(0xe940, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconSeat = IconData(0xe924, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconCard = IconData(0xe93b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconTask = IconData(0xe91e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconEdit = IconData(0xe907, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconCalendar = IconData(0xe90a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconLeftArrow = IconData(0xe90e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconRightArrow = IconData(0xe910, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconDownLoad = IconData(0xe946, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconPrint = IconData(0xe906, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconAdd = IconData(0xe909, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
