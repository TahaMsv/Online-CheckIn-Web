import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/initialize.dart';
import '../navigation/navigation_service.dart';
import '../navigation/router.dart';

abstract class MainController {
  late NavigationService nav;
  late WidgetRef ref;
  bool initialized =false;
  MainController() {
    nav = getIt<NavigationService>();
    ref = getIt<WidgetRef>();
    if(!initialized) {
      onCreate();
    }
  }


  void onInit() {
    log(runtimeType.toString() + ' Init');
  }

  void onCreate() {
    log(runtimeType.toString() + ' Create');
    initialized =true;
  }
}
