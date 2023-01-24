
import 'package:flutter/material.dart';
import '../../core/classes/extra.dart';
import '../../core/constants/ui.dart';

class UpgradesState with ChangeNotifier {
  setState() => notifyListeners();
  bool _requesting = false;

  bool get requesting => _requesting;

  void setRequesting(bool val) {
    _requesting = val;
    notifyListeners();
  }

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  List<Color> colors = [MyColors.myBlue, MyColors.brightYellow, MyColors.red, MyColors.brightYellow, MyColors.darkGrey];
  List<String> imagesPath = [];
  List<Extra> extras = [];
  List<int> winesNumberOfSelected = [];
  List<int> entertainmentsNumberOfSelected = [];
  List<Extra> winesList = [];
  List<Extra> entertainmentsList = [];

  void refresh() {
    notifyListeners();
  }
}
