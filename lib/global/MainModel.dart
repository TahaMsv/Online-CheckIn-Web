import 'package:flutter/cupertino.dart';
import '../screens/safetyStepScreen/SafetyStepModel.dart';
import '../screens/travellersStepScreen/TravellersStepModel.dart';
import '../screens/enterScreen/EnterScreenModel.dart';
import '../screens/stepsScreen/stepsScreenModel.dart';
import '../screens/splashScreen/SplashModel.dart';

class MainModel with ChangeNotifier,SplashModel,EnterScreenModel,StepsScreenModel,TravellersStepScreenModel,SafetyStepScreenModel {
  bool _loading = false;
  bool get loading =>_loading;
  void setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

}