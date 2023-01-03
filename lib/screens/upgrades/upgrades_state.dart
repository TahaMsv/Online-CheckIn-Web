import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


  RxBool loading = false.obs;

  List<Color> colors = [const Color(0xff5f6bff), const Color(0xffffc365), const Color(0xfffa4b4b), const Color(0xffffc365),  MyColors.darkGrey];
  List<String> imagesPath = [];
  List<Extra> extras = [];
  RxList<int> winesNumberOfSelected = <int>[].obs;
  RxList<int> entertainmentsNumberOfSelected = <int>[].obs;
  RxList<Extra> winesList = <Extra>[].obs;
  RxList<Extra> entertainmentsList = <Extra>[].obs;

  void refresh(){
    notifyListeners();
  }
}
