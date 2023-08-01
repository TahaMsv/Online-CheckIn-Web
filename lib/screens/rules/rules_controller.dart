import 'package:online_check_in/screens/rules/rules_repository.dart';
import 'package:online_check_in/screens/rules/rules_state.dart';

import 'package:online_check_in/initialize.dart';
import '../../core/interfaces/controller.dart';

class RulesController extends MainController {

  late RulesState rulesState = ref.read(rulesProvider);
}
