
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class VisaStepController extends MainController {
  VisaStepController._();

  static final VisaStepController _instance = VisaStepController._();

  factory VisaStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }


  @override
  void onInit() {
    print("VisaStepController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("VisaStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("VisaStepController Ready");
    super.onReady();
  }
}
