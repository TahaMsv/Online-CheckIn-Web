import 'package:flutter/cupertino.dart';
import '../screens/seatsStepScreen/SeatsStepModel.dart';
import '../screens/receiptStepScreen/ReceiptStepModel.dart';
import '../screens/upgradesStepScreen/UpgradesStepModel.dart';
import '../screens/paymentStepScreen/PaymentStepModel.dart';
import '../screens/visaStepScreen/VisaStepModel.dart';
import '../screens/passportStepScreen/PassportStepModel.dart';
import '../screens/rulesStepScreen/RulesStepModel.dart';
import '../screens/safetyStepScreen/SafetyStepModel.dart';
import '../screens/travellersStepScreen/TravellersStepModel.dart';
import '../screens/enterScreen/EnterScreenModel.dart';
import '../screens/stepsScreen/StepsScreenModel.dart';
import '../screens/splashScreen/SplashModel.dart';

class MainModel
    with
        ChangeNotifier,
        SplashModel,
        EnterScreenModel,
        StepsScreenModel,
        TravellersStepScreenModel,
        SafetyStepScreenModel,
        RulesStepScreenModel,
        UpgradesStepScreenModel,
        PassportStepScreenModel,
        VisaStepScreenModel,
        PaymentStepScreenModel,
        ReceiptStepScreenModel,
        SeatsStepScreenModel {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool _requesting = false;

  bool get requesting => _requesting;

  void setRequesting(bool val) {
    _requesting = val;
    notifyListeners();
  }
}
