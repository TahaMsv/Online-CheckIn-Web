
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class RulesStepScreenController extends MainController {
  RulesStepScreenController._();

  static final RulesStepScreenController _instance = RulesStepScreenController._();

  factory RulesStepScreenController(MainModel model) {
    _instance.model = model;
    return _instance;
  }


  @override
  void onInit() {
    print("RulesStepScreenController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("RulesStepScreenController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("RulesStepScreenController Ready");
    super.onReady();
  }
}
