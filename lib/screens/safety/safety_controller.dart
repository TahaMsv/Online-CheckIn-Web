import 'package:online_checkin_web_refactoring/screens/safety/safety_repository.dart';
import 'package:online_checkin_web_refactoring/screens/safety/safety_state.dart';

import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../steps/steps_controller.dart';

class SafetyController extends MainController {
  final SafetyState safetyState = getIt<SafetyState>();
  final SafetyRepository safetyRepository = getIt<SafetyRepository>();

  changeValue(int index, bool value) {
    final StepsController stepsController = getIt<StepsController>();
    safetyState.checkBoxesValue[index] = value;
    stepsController.updateIsNextButtonDisable();
  }

  bool checkValidation() {
    for (int i = 0; i < safetyState.checkBoxesValue.length; i++) {
      if (safetyState.checkBoxesValue[i] == false) return false;
    }
    return true;
  }

  @override
  void onCreate() {}
}
