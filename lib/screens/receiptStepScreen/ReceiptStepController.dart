
import '../../global/MainController.dart';
import '../../global/MainModel.dart';

class ReceiptStepController extends MainController {
  ReceiptStepController._();

  static final ReceiptStepController _instance = ReceiptStepController._();

  factory ReceiptStepController(MainModel model) {
    _instance.model = model;
    return _instance;
  }


  @override
  void onInit() {
    print("ReceiptStepController Init");
    super.onInit();
  }

  @override
  void onClose() {
    print("ReceiptStepController Close");
    super.onClose();
  }

  @override
  void onReady() {
    print("ReceiptStepController Ready");
    super.onReady();
  }
}
