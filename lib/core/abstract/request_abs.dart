import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../screens/login/login_state.dart';
import 'package:online_check_in/initialize.dart';

abstract class Request {
  final WidgetRef ref = getIt<WidgetRef>();
  final loginState = getIt<WidgetRef>().read(loginProvider.notifier);
  Map<String,dynamic> toJson();
  // T fromJson(Map<String,dynamic> json);

  // String? get token => user.state?.token;
  String? get token => loginState.token;   //todo
}