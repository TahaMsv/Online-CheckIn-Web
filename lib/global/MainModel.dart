import 'package:flutter/cupertino.dart';
import '../screens/enterScreen/EnterScreenModel.dart';
import '../screens/stepsScreen/stepsScreenModel.dart';
import '../screens/splashScreen/SplashModel.dart';

class MainModel with ChangeNotifier,SplashModel,EnterScreenModel,StepsScreenModel {
  bool _loading = false;
  bool get loading =>_loading;
  void setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

}