import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/screens/safety/safety_controller.dart';
import 'package:online_check_in/screens/safety/safety_repository.dart';
import 'package:online_check_in/screens/safety/safety_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../init_test.dart';

void main() async {
  initTest();

  late SafetyController safetyController;
  late WidgetRef ref;

  setUp(() {
    ref = getIt<WidgetRef>();
    safetyController = SafetyController();
  });

  group('SafetyController', () {
    test('checkValidation should return false without any toggle', () {
      // Act
      final result = safetyController.checkValidation();

      // Assert
      expect(result, false);
    });

    test('checkValidation should return true if all checkBoxesValue are true', () {
      // Arrange
      ref.read(checkBoxesProvider.notifier).toggleCheckBoxesValue(0);
      ref.read(checkBoxesProvider.notifier).toggleCheckBoxesValue(1);
      ref.read(checkBoxesProvider.notifier).toggleCheckBoxesValue(2);

      // Act
      final result = safetyController.checkValidation();

      // Assert
      expect(result, true);
    });

    test('checkValidation should return false if any checkBoxesValue is false', () {
      // Arrange
      ref.read(checkBoxesProvider.notifier).toggleCheckBoxesValue(1);

      // Act
      final result = safetyController.checkValidation();

      // Assert
      expect(result, false);
    });
  });
}
