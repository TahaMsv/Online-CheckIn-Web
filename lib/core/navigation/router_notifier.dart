import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../screens/Passport/passport_view_mobile.dart';
import '../../screens/Visa/visa_view_mobile.dart';
import '../../screens/addTraveler/add_traveler_view_mobile.dart';
import '../../screens/login/login_controller.dart';
import '../../screens/login/login_state.dart';
import '../../screens/login/login_view_mobile.dart';
import '../../screens/payment/payment_view_mobile.dart';
import '../../screens/receipt/receipt_view_mobile.dart';
import '../../screens/rules/rules_view_mobile.dart';
import '../../screens/safety/sefety_view_mobile.dart';
import '../../screens/seat_map/seat_map_view_mobile.dart';
import '../../screens/seat_map/widgets/plane.dart';
import '../../screens/steps/steps_view_mobile.dart';
import '../../screens/upgrades/upgrades_view_mobile.dart';
import 'route_names.dart';

/// This notifier is meant to implement the [Listenable] our [GoRouter] needs.
///
/// We aim to trigger redirects whenever's needed.
/// This is done by calling our (only) listener everytime we want to notify stuff.
/// This allows to centralize global redirecting logic in this class.
/// In this simple case, we just listen to auth changes.
///
/// SIDE NOTE.
/// This might look overcomplicated at a first glance;
/// Instead, this method aims to follow some good some good practices:
///   1. It doesn't require us to pipe down any `ref` parameter
///   2. It works as a complete replacement for [ChangeNotifier] (it's a [Listenable] implementation)
///   3. It allows for listening to multiple providers if needed (we do have a [Ref] now!)
class RouterNotifier extends AutoDisposeAsyncNotifier<void> implements Listenable {
  VoidCallback? routerListener;

  // bool isAuth = false; // Useful for our global redirect functio

  @override
  Future<void> build() async {
    // One could watch more providers and write logic accordingly

    // isAuth = ref.watch(userProvider) != null;
    // ref.listenSelf((_, __) {
    //   // One could write more conditional logic for when to call redirection
    //   if (state.isLoading) return;
    //   routerListener?.call();
    // });
  }

  /// Redirects the user when our authentication changes
  // String? redirect(BuildContext context, GoRouterState state) {
  //   if (this.state.isLoading || this.state.hasError) return null;
  //
  //   final isSplash = state.location == RouteNames.splash.path;
  //
  //   if (isSplash) {
  //     return isAuth ? RouteNames.home.path : RouteNames.login.path;
  //   }
  //
  //   final isLoggingIn = state.location == RouteNames.login.path;
  //   if (isLoggingIn) return isAuth ? RouteNames.splash.path : null;
  //
  //   return isAuth ? null : RouteNames.splash.path;
  // }

  /// Our application routes. Obtained through code generation
  final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  List<RouteBase> get routes => [
        MyRoute(
          // controller: RouteNames.login.controller,
          name: RouteNames.login.name,
          path: RouteNames.login.path,
          pageBuilder: (context, state) {
            // LoginController loginController = getIt<LoginController>();
            return NoTransitionPage<void>(key: state.pageKey, child: LoginView());
          },
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            // switch (DeviceInfo.deviceType(context)) {
            //   case DeviceType.tablet:
            //     return StepsViewTablet(childWidget: Center(child: child));
            //   case DeviceType.desktop:
            //     return StepsViewWeb(childWidget: Center(child: child));
            //   case DeviceType.web:
            //     return StepsViewWeb(childWidget: Center(child: child));
            //   case DeviceType.phone:
            //     return StepsView(childWidget: Center(child: child));
            //   default:
            return StepsView(childWidget: Center(child: child));
            // }
          },
          routes: <RouteBase>[
            GoRoute(
              path: RouteNames.addTraveler.path,
              name: RouteNames.addTraveler.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return AddTravelerViewTablet();
                //   case DeviceType.desktop:
                //     return AddTravelerViewWeb();
                //   case DeviceType.web:
                //     return AddTravelerViewWeb();
                //   case DeviceType.phone:
                //     return AddTravelerView();
                //   default:
                return AddTravelerView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.safety.path,
              name: RouteNames.safety.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return SafetyViewTablet();
                //   case DeviceType.web:
                //     return SafetyViewWeb();
                //   case DeviceType.desktop:
                //     return SafetyViewWeb();
                //   case DeviceType.phone:
                //     return SafetyView();
                //   default:
                return SafetyView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.rules.path,
              name: RouteNames.rules.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return RulesViewTablet();
                //   case DeviceType.web:
                //     return RulesViewWeb();
                //   case DeviceType.desktop:
                //     return RulesViewWeb();
                //   case DeviceType.phone:
                //     return RulesView();
                //   default:
                return RulesView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.passport.path,
              name: RouteNames.passport.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return PassportViewTablet();
                //   case DeviceType.web:
                //     return PassportViewWeb();
                //   case DeviceType.desktop:
                //     return PassportViewWeb();
                //   case DeviceType.phone:
                //     return PassportView();
                //   default:
                return PassportView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.visa.path,
              name: RouteNames.visa.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return VisaViewTablet();
                //   case DeviceType.web:
                //     return VisaViewWeb();
                //   case DeviceType.desktop:
                //     return VisaViewWeb();
                //   case DeviceType.phone:
                //     return VisaView();
                //   default:
                return VisaView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.upgrades.path,
              name: RouteNames.upgrades.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return UpgradesViewTablet();
                //   case DeviceType.web:
                //     return UpgradesViewWeb();
                //   case DeviceType.desktop:
                //     return UpgradesViewWeb();
                //   case DeviceType.phone:
                //     return UpgradesView();
                //   default:
                return UpgradesView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.seatMap.path,
              name: RouteNames.seatMap.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return SeatMapViewTablet();
                //   case DeviceType.web:
                //     return SeatMapViewWeb();
                //   case DeviceType.desktop:
                //     return SeatMapViewWeb();
                //   case DeviceType.phone:
                //     return SeatMapView();
                //   default:
                return SeatMapView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.seatMapPlane.path,
              name: RouteNames.seatMapPlane.name,
              builder: (BuildContext context, GoRouterState state) => const Plane(),
            ),
            GoRoute(
              path: RouteNames.payment.path,
              name: RouteNames.payment.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return PaymentViewTablet();
                //   case DeviceType.web:
                //     return PaymentViewWeb();
                //     case DeviceType.desktop:
                //     return PaymentViewWeb();
                //     case DeviceType.phone:
                //     return PaymentView();
                //   default:
                return PaymentView();
                // }
              },
            ),
            GoRoute(
              path: RouteNames.receipt.path,
              name: RouteNames.receipt.name,
              builder: (BuildContext context, GoRouterState state) {
                // switch (DeviceInfo.deviceType(context)) {
                //   case DeviceType.tablet:
                //     return ReceiptViewTablet();
                //   case DeviceType.web:
                //     return ReceiptViewWeb();
                //     case DeviceType.desktop:
                //     return ReceiptViewWeb();
                //     case DeviceType.phone:
                //     return ReceiptView();
                //   default:
                return ReceiptView();
                // }
              },
            ),
          ],
        ),
      ];

  /// Adds [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method on creation to handle its
  /// internal [ChangeNotifier].
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  /// Removes [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method when disposing,
  /// so that it removes its callback when destroyed.
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

final routerNotifierProvider = AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});

/// A simple extension to determine wherever should we redirect our users
// extension RedirecttionBasedOnRole on UserRole {
//   /// Redirects the users based on [this] and its current [location]
//   String? redirectBasedOn(String location) {
//     switch (this) {
//       case UserRole.admin:
//         return null;
//       case UserRole.verifiedUser:
//       case UserRole.unverifiedUser:
//         if (location == AdminPage.path) return HomePage.path;
//         return null;
//       case UserRole.guest:
//       case UserRole.none:
//         if (location != HomePage.path) return HomePage.path;
//         return null;
//     }
//   }
// }

class MyRoute extends GoRoute {
  // final MainController controller;

  MyRoute({
    required super.path,
    // required this.controller,
    super.name,
    super.routes,
    super.pageBuilder,
  });
}
