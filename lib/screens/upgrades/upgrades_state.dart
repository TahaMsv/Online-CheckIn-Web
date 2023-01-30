
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../core/classes/extra.dart';
import '../../core/constants/ui.dart';

class UpgradesState with ChangeNotifier {
  setState() => notifyListeners();

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  int _leftIndex = 0;

  int get leftIndex => _leftIndex;

    void setleftIndex(int val) {
      _leftIndex = val;
      notifyListeners();
    }

    int _rightIndex = 2;

    int get rightIndex => _rightIndex;

      void setrightIndex(int val) {
        _rightIndex = val;
        notifyListeners();
      }


  List<Color> colors = [MyColors.myBlue, MyColors.brightYellow, MyColors.red, MyColors.brightYellow, MyColors.darkGrey];
  List<String> imagesPath = [];
  List<Extra> extras = [];
  List<int> winesNumberOfSelected = [];
  List<int> entertainmentsNumberOfSelected = [];
  List<Extra> winesList = [];
  List<Extra> entertainmentsList = [];

}
