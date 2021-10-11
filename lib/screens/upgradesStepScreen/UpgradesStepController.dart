
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class UpgradesStepController extends MainController {
  UpgradesStepController._();

  static final UpgradesStepController _instance = UpgradesStepController._();

  factory UpgradesStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }


  @override
  void onInit() {
    print("UpgradesStepController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("UpgradesStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("UpgradesStepController Ready");
    super.onReady();
  }
}
