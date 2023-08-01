import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/screens/safety/safety_controller.dart';
import 'package:online_check_in/screens/safety/safety_state.dart';
import '../../init_test.dart';

void main() async {
  initTest();

  late WidgetRef ref;

  setUp(() {
    ref = getIt<WidgetRef>();
  });
  group('SafetyState', () {
    test('one toggle should change the value', () {
      // Arrange
      ref.read(checkBoxesProvider.notifier).toggleCheckBoxesValue(0);
      // Assert
      expect(ref.read(checkBoxesProvider), [true, false, false]);
    });

    test('two toggle should not change the value', () {
      // Arrange
      ref.read(checkBoxesProvider.notifier).toggleCheckBoxesValue(0); // This test runs after the previous one, So we just need to toggle once again.
      // Assert
      expect(ref.read(checkBoxesProvider), [false, false, false]);
    });
  });
}
