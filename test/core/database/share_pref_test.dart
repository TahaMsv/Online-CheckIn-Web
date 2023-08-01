import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/database/share_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late SharedPrefService sharedPrefService;
  SharedPreferences.setMockInitialValues({});

  setUp(() async {
    // Should add for testing, otherwise throeing an error
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPrefService = SharedPrefService(sharedPreferences);
  });

  tearDown(() {
    sharedPreferences.clear();
  });

  test('Test setBool() and getBool() methods', () async {
    // Arrange
    const key = 'boolKey';
    const value = true;

    // Act
    final setResult = await sharedPrefService.setBool(key, value);
    final getResult = sharedPrefService.getBool(key);

    // Assert
    expect(setResult, true);
    expect(getResult, value);
  });

  test('Test setString() and getString() methods', () async {
    // Arrange
    const key = 'stringKey';
    const value = 'Hello, World!';

    // Act
    final setResult = await sharedPrefService.setString(key, value);
    final getResult = sharedPrefService.getString(key);

    // Assert
    expect(setResult, true);
    expect(getResult, value);
  });

  test('Test setInt() and getInt() methods', () async {
    // Arrange
    const key = 'intKey';
    const value = 42;

    // Act
    final setResult = await sharedPrefService.setInt(key, value);
    final getResult = sharedPrefService.getInt(key);

    // Assert
    expect(setResult, true);
    expect(getResult, value);
  });

  test('Test setDouble() and getDouble() methods', () async {
    // Arrange
    const key = 'doubleKey';
    const value = 3.14;

    // Act
    final setResult = await sharedPrefService.setDouble(key, value);
    final getResult = sharedPrefService.getDouble(key);

    // Assert
    expect(setResult, true);
    expect(getResult, value);
  });

  test('Test setListString() and getStringList() methods', () async {
    // Arrange
    const key = 'listStringKey';
    const value = ['apple', 'banana', 'orange'];

    // Act
    final setResult = await sharedPrefService.setListString(key, value);
    final getResult = sharedPrefService.getStringList(key);

    // Assert
    expect(setResult, true);
    expect(getResult, value);
  });
}
