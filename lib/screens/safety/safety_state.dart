import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final checkBoxesProvider = StateNotifierProvider<CheckBoxesNotifier, List<bool>>((ref) {
  return CheckBoxesNotifier();
});

class CheckBoxesNotifier extends StateNotifier<List<bool>> {
  CheckBoxesNotifier() : super([false, false, false]);

  void toggleCheckBoxesValue(int index) {
    state[index] = !state[index];
  }
}
