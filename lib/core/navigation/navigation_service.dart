// /*
// import 'dart:async';
//
// import 'package:flash/flash.dart';
// import 'package:flutter/material.dart';
// import 'package:online_check_in/core/navigation/router.dart';
//
// import '../../widgets/CustomFlutterWidget.dart';
// import '../interfaces/controller.dart';
//
// class NavigationService {
//   final NavigationMode mode;
//   final Map<String, MainController> _registeredControllers = {};
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   final MyRouter router = MyRouter();
//
//   NavigationService({this.mode = NavigationMode.goRouter});
//
//   Future<dynamic> pushNamed(String routeName, {Map<String, String>? arguments}) {
//     if (_registeredControllers.containsKey(routeName)) {
//       _registeredControllers[routeName]!.onInit();
//     }
//     if (mode == NavigationMode.goRouter) {
//       MyRouter.router.pushNamed(routeName, params: arguments ?? {});
//       return Future.value(null);
//     } else {
//       return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
//     }
//   }
//
//   Future<dynamic> popAndTo(String routeName, {Map<String, String>? arguments}) {
//     if (_registeredControllers.containsKey(routeName)) {
//       _registeredControllers[routeName]!.onInit();
//     }
//     if (mode == NavigationMode.goRouter) {
//       MyRouter.router.goNamed(routeName, params: arguments ?? {});
//       return Future.value(null);
//     } else {
//       return navigatorKey.currentState!.popAndPushNamed(routeName, arguments: arguments);
//     }
//   }
//
//   void pop() {
//     Navigator.pop(context!);
//   }
//
//   void goBack({dynamic result}) {
//     if (mode == NavigationMode.goRouter) {
//       MyRouter.router.pop();
//     } else {
//       return navigatorKey.currentState!.pop(result);
//     }
//   }
//
//   void goToName(String routeName, {Map<String, String>? arguments}) {
//     if (_registeredControllers.containsKey(routeName)) {
//       _registeredControllers[routeName]!.onInit();
//     }
//     if (mode == NavigationMode.goRouter) {
//       MyRouter.router.goNamed(routeName, params: arguments ?? {});
//     } else {
//       navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
//     }
//   }
//
//   BuildContext? get context => mode == NavigationMode.goRouter ? MyRouter.context : navigatorKey.currentState?.context;
//
//   Future<dynamic> dialog(Widget content) {
//     return showDialog(context: context!, builder: (c) => content);
//   }
//
//   snackbar(Widget content, {Color? backgroundColor, SnackBarAction? action, Duration? duration, IconData? icon}) {
//     ScaffoldMessenger.of(context!).clearSnackBars();
//     ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
//       content: icon == null
//           ? content
//           : Row(
//               children: [Icon(icon), const SizedBox(width: 8), Expanded(child: content)],
//             ),
//       backgroundColor: backgroundColor,
//       behavior: SnackBarBehavior.floating,
//       margin: EdgeInsets.only(
//         bottom: MediaQuery.of(context!).size.height - 100,
//       ),
//       action: action,
//       duration: duration ?? const Duration(seconds: 3),
//     ));
//   }
//
//   void popAll() {
//     while (MyRouter.router.canPop()) {
//       MyRouter.router.pop();
//     }
//   }
//
//   registerController(String name, MainController controller) {
//     _registeredControllers.putIfAbsent(name, () => controller);
//   }
//
//   void popDialog([dynamic result]) {
//     Navigator.pop(context!, result);
//   }
// }
//
// enum NavigationMode { version1, goRouter }
// */


import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_check_in/core/navigation/route_names.dart';

import '../abstract/navigation_abs.dart';
import 'router.dart';

class NavigationService extends BasicNavigationService {
  final List<int> _openedDialogs = [];
  BuildContext get context => rootRouterKey.currentState!.context;
  bool get isDialogOpened => _openedDialogs.isEmpty;

  @override
  void goNamed(
      RouteNames route, {
        Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{},
        Object? extra,
      }) async {
    context.goNamed(route.name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  @override
  bool canPop() {
    return context.canPop();
  }

  @override
  void go(String location, {Object? extra}) {
    context.go(location, extra: extra);
  }

  @override
  String namedLocation(String name, {Map<String, String> pathParameters = const <String, String>{}, Map<String, dynamic> queryParameters = const <String, dynamic>{}}) {
    return context.namedLocation(name, pathParameters: pathParameters, queryParameters: queryParameters);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    return context.pop(result);
  }

  @override
  Future<T?> push<T extends Object?>(String location, {Object? extra}) {
    return context.push(location, extra: extra);
  }

  @override
  Future<T?> pushNamed<T extends Object?>(RouteNames route, {Map<String, String> pathParameters = const <String, String>{}, Map<String, dynamic> queryParameters = const <String, dynamic>{}, Object? extra}) {
    print(pathParameters);
    return context.pushNamed(route.name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  @override
  void pushReplacement(String location, {Object? extra}) {
    return context.pushReplacement(location, extra: extra);
  }

  @override
  void pushReplacementNamed(String name, {Map<String, String> pathParameters = const <String, String>{}, Map<String, dynamic> queryParameters = const <String, dynamic>{}, Object? extra}) {
    return context.pushReplacementNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  @override
  void replace(String location, {Object? extra}) {
    return context.replace(location, extra: extra);
  }

  @override
  void replaceNamed(String name, {Map<String, String> pathParameters = const <String, String>{}, Map<String, dynamic> queryParameters = const <String, dynamic>{}, Object? extra}) {
    return context.replaceNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  @override
  Future dialog(Widget content) async {
    _openedDialogs.add(_openedDialogs.length);
    late dynamic res;
    await showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: false,
      builder: (context) => content,
    ).then((value) {
      log("Dialog Then $value");
      _openedDialogs.removeLast();
      res = value;
      return value;
    });
    return res;
  }

  @override
  void hideSnackBars() {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  @override
  void popDialog({result, Function? onPop}) {
    Navigator.pop(context, result);
    onPop?.call();
  }

  @override
  void snackbar(Widget content, {Color? backgroundColor, SnackBarAction? action, Duration? duration, IconData? icon, EdgeInsetsGeometry? padding, EdgeInsetsGeometry? margin}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: margin,
      padding: padding,
      content: icon == null
          ? content
          : Row(
        children: [Icon(icon, color: Colors.white), const SizedBox(width: 8), Expanded(child: content)],
      ),
      backgroundColor: backgroundColor,
      action: action,
      duration: duration ?? const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    ));
  }

  // void goBack({required AddFlightResponse result, required void Function()? onPop}) {
  //   pop(result);
  //   onPop?.call();
  //   // navigatorKey.currentState!.pop(result);
  // }
}
