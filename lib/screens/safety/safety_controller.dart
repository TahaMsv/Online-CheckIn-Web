import 'package:online_check_in/screens/safety/safety_repository.dart';
import 'package:online_check_in/screens/safety/safety_state.dart';

import 'package:online_check_in/initialize.dart';
import '../../core/interfaces/controller.dart';
import '../steps/steps_controller.dart';

class SafetyController extends MainController {
  bool checkValidation() {
    List<bool> checkBoxes = ref.read(checkBoxesProvider);
    for (int i = 0; i < checkBoxes.length; i++) {
      if (checkBoxes[i] == false) return false;
    }
    return true;
  }
}
