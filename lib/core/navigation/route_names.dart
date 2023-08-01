import 'package:flutter/material.dart';

enum RouteNames {
  initialRoute,
  splash,
  login,
  home,
  steps,
  addTraveler,
  safety,
  rules,
  passport,
  visa,
  payment,
  upgrades,
  receipt,
  seatMap,
  seatMapPlane,
}

extension RouteNamesDetails on RouteNames {
  String get path {
    switch (this) {
      case RouteNames.initialRoute:
        return '/';
      case RouteNames.splash:
        return '/splash';
      case RouteNames.login:
        return '/login';
      case RouteNames.home:
        return '/home';
      case RouteNames.steps:
        return '/steps';
      case RouteNames.addTraveler:
        return '/addTraveler';
      case RouteNames.safety:
        return '/safety';
      case RouteNames.rules:
        return '/rules';
      case RouteNames.passport:
        return '/passport';
      case RouteNames.visa:
        return '/visa';
      case RouteNames.payment:
        return '/payment';
      case RouteNames.upgrades:
        return '/upgrades';
      case RouteNames.receipt:
        return '/receipt';
      case RouteNames.seatMap:
        return '/seatMap';
      case RouteNames.seatMapPlane:
        return '/seatMapPlane';
      default:
        return "/$name";
    }
  }

  String get title {
    switch (this) {
      default:
        return (name.characters.first.toUpperCase() + name.replaceFirst(name.characters.first, ""));
    }
  }

  bool get isMainRoute {
    return [
      RouteNames.login,
      RouteNames.home,
    ].contains(this);
  }

// MainController get controller {
//   switch(this){
//     case RouteNames.splash:
//       return LoginController();
//     case RouteNames.login:
//       return LoginController();
//     case RouteNames.home:
//       return HomeController();
//     case RouteNames.flights:
//       return FlightsController();
//     case RouteNames.airlines:
//      return AirlinesController();
//     case RouteNames.aircrafts:
//      return AircraftsController();
//     case RouteNames.airports:
//       return AirportsController();
//     case RouteNames.users:
//       return UsersController();
//   }
// }
}
