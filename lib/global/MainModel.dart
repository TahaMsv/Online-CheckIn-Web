import 'package:flutter/cupertino.dart';
import '../screens/splashScreen/SplashModel.dart';

class MainModel with ChangeNotifier,SplashModel {
  bool _loading = false;
  bool get loading =>_loading;
  void setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

}