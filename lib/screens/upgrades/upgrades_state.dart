import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../core/classes/extra.dart';
import '../../core/constants/ui.dart';
import '../../initialize.dart';

final upgradesProvider = ChangeNotifierProvider<UpgradesState>((_) => UpgradesState());

final winesListProvider = StateProvider<List<Extra>?>((ref) => []);

final entertainmentsListProvider = StateProvider<List<Extra>?>((ref) => []);

class UpgradesState with ChangeNotifier {
  setState() => notifyListeners();

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool _isInitBefore = false;

  bool get isInitBefore => _isInitBefore;

  void setIsInitBefore(bool val) {
    _isInitBefore = val;
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

  List<int> winesNumberOfSelected = [];
  List<int> entertainmentsNumberOfSelected = [];

  void resetUpgradesState() {
    final ref = getIt<WidgetRef>();
    colors = [MyColors.myBlue, MyColors.brightYellow, MyColors.red, MyColors.brightYellow, MyColors.darkGrey];
    winesNumberOfSelected = [];
    entertainmentsNumberOfSelected = [];
    // winesList = [];
    ref.watch(winesListProvider.notifier).state = [];
    ref.watch(entertainmentsListProvider.notifier).state = [];
    setLoading(false);
    setIsInitBefore(false);
    setrightIndex(2);
    setleftIndex(0);
  }
}
