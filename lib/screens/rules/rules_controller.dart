import 'package:online_checkin_web_refactoring/screens/rules/rules_repository.dart';
import 'package:online_checkin_web_refactoring/screens/rules/rules_state.dart';

import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';

class RulesController extends MainController {

  final RulesState rulesState = getIt<RulesState>();
  final RulesRepository rulesRepository = getIt<RulesRepository>();

  @override
  void onCreate() {}
}
