import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/screens/upgrades/upgrades_controller.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';

import '../../init_test.dart';

void main() async {
  initTest();

  late UpgradesController upgradesController;
  late UpgradesState upgradesState;
  late WidgetRef ref;

  setUp(() async {
    ref = getIt<WidgetRef>();
    upgradesController = UpgradesController();
    upgradesState = ref.read(upgradesProvider);
  });

  test('Init method loads extras correctly', () async {
    await upgradesController.init();
    expect(ref.read(entertainmentsListProvider)?.length, 1);
  });

  test('Add wine increments the selected count', () {
    const index = 0;

    upgradesController.addWine(index);

    expect(upgradesState.winesNumberOfSelected[index], 1);
  });

  test('Remove wine decrements the selected count', () {
    const index = 0;
    upgradesController.removeWine(index);

    expect(upgradesState.winesNumberOfSelected[index], 0);

    upgradesController.removeWine(index);

    expect(upgradesState.winesNumberOfSelected[index], 0);
  });

  test('Add Entertainment increments the selected count', () {
    const index = 0;
    upgradesController.addEntertainment(index);

    expect(upgradesState.entertainmentsNumberOfSelected[index], 1);
  });

  test('Remove Entertainment decrements the selected count', () {
    const index = 0;

    upgradesController.removeEntertainment(index);

    expect(upgradesState.entertainmentsNumberOfSelected[index], 0);

    upgradesController.removeWine(index);

    expect(upgradesState.entertainmentsNumberOfSelected[index], 0);
  });

  test('After getting extras, isInitBefore should be true', () {
    expect(upgradesState.isInitBefore, true);
  });
}
