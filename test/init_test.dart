import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/initialize.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getIt.registerSingleton(ref);
    initControllers();
    return Container();
  }
}

void initTest() async {
  SharedPreferences.setMockInitialValues({}); // Should add for testing, otherwise throeing an error
  await init();
  runApp(ProviderScope(
      overrides: [],
      child: Consumer(builder: (builder, ref, c) {
        return const MyApp();
      })));

}



void main() {
  test("Init test", () => {});
}
