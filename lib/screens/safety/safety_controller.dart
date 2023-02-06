import 'package:online_check_in/screens/safety/safety_repository.dart';
import 'package:online_check_in/screens/safety/safety_state.dart';

import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../steps/steps_controller.dart';

class SafetyController extends MainController {
  final SafetyState safetyState = getIt<SafetyState>();
  final SafetyRepository safetyRepository = getIt<SafetyRepository>();


  bool checkValidation() {
    for (int i = 0; i < safetyState.checkBoxesValue.length; i++) {
      if (safetyState.checkBoxesValue[i] == false) return false;
    }
    return true;
  }

}
