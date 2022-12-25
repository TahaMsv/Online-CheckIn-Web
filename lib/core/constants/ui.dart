import 'package:flutter/material.dart';

class MyColors {
  MyColors._();

  static const mainColor = Color(0xff48c0a2);
  static const white = Colors.white;
  static const red = Colors.red;
  static const black = Colors.black;
  static const black1 = Color.fromRGBO(52, 52, 52, 1);
  static const black3 = Color.fromRGBO(59, 59, 59, 0.8);
  static const black7 = Color.fromRGBO(0, 0, 0, 0.07);
  static const black8 = Color.fromRGBO(0, 0, 0, 0.08);
  static const color1 = Color(0xfff86f6f);
  static const color2 = Color(0xff4d6fff);
  static const color3 = Color(0xff4d6fff);
  static const color4 = Color(0xffffae2c);

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

class MyTheme {
  MyTheme._();

  // static ThemeData lightAbomis = ThemeData(
  //     fontFamily: "OpenSans",
  //     primaryColor: MyColors.mainColor,
  //     canvasColor: Colors.transparent,
  //     brightness: Brightness.light,
  //     disabledColor: MyColors.brownGrey,
  //     scaffoldBackgroundColor: Colors.white,
  //
  //     timePickerTheme: const TimePickerThemeData(
  //     ),
  //
  //     dividerTheme: const DividerThemeData(
  //         color: MyColors.lineColor,
  //         indent: 1,
  //         space: 1
  //     ),
  //     appBarTheme: const AppBarTheme(
  //       titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.white1),
  //       systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: MyColors.mainColor, statusBarBrightness: Brightness.dark),
  //       backgroundColor: MyColors.mainColor,
  //       iconTheme: IconThemeData(color: MyColors.slateBlue),
  //
  //     ),
  //
  //     // fontFamily: "OpenSans",
  //     textTheme:  const TextTheme(
  //       headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.black),
  //       headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.black),
  //       headline3: TextStyle(fontSize: 20, color: MyColors.black),
  //       headline4: TextStyle(fontSize: 18, color: MyColors.black, fontWeight: FontWeight.bold),
  //       headline5: TextStyle(fontSize: 16, color: MyColors.black),
  //       headline6: TextStyle(fontSize: 14, color: MyColors.black),
  //       subtitle1: TextStyle(fontSize: 12, color: MyColors.black),
  //       subtitle2: TextStyle(fontSize: 10, color: MyColors.black),
  //       // bodyLarge: const TextStyle(fontSize: 14, color: MyColors.black),
  //       // bodyMedium: const TextStyle(fontSize: 12, color: MyColors.black),
  //       // bodySmall: const TextStyle(fontSize: 10, color: MyColors.black),
  //     ),
  //     textButtonTheme: TextButtonThemeData(
  //         style: TextButton.styleFrom(
  //             padding: const EdgeInsets.symmetric(horizontal: 8),
  //             textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //             backgroundColor: MyColors.lightIshBlue,
  //             primary: Colors.white
  //         )),
  //     outlinedButtonTheme: OutlinedButtonThemeData(
  //         style: TextButton.styleFrom(
  //             textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
  //             primary: MyColors.lightIshBlue,
  //             side: const BorderSide(color: MyColors.lightIshBlue, width: 2))),
  //     colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xFF4d6fff, MyColors.materialColor)).copyWith(
  //       secondary: MyColors.darkMint,
  //       primary: MyColors.mainColor,
  //     ),
  //     dataTableTheme: const DataTableThemeData(
  //         headingRowHeight: 35,
  //         dataRowHeight: 40,
  //         columnSpacing:4
  //     )
  // );

  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: Colors.white,
      accentColor: Colors.white,
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
