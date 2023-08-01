import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/utils/app_config.dart';

void main() {
  test('Test AppConfig properties', () {
    // Arrange
    final flavor = Flavor.abomis;
    final lightTheme = ThemeData(primaryColor: Colors.blue);
    final darkTheme = ThemeData(primaryColor: Colors.deepPurple);
    final baseUrl = "https://example.com";
    final logoAddress = "assets/images/logo.png";

    // Act
    final appConfig = AppConfig(
      flavor: flavor,
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      baseUrl: baseUrl,
      logoAddress: logoAddress,
    );

    // Assert
    expect(appConfig.flavor, flavor);
    expect(appConfig.lightTheme, lightTheme);
    expect(appConfig.darkTheme, darkTheme);
    expect(appConfig.baseUrl, baseUrl);
    expect(appConfig.logoAddress, logoAddress);

    expect(AppConfig.instance, appConfig);
    expect(AppConfig.themeLight, lightTheme);
    expect(AppConfig.themeDark, darkTheme);
    expect(AppConfig.baseURL, baseUrl);
    expect(AppConfig.logo, logoAddress);
    expect(AppConfig.isAbomis, true);
  });

  test('Test AppConfig instance is singleton', () {
    // Arrange
    final appConfig1 = AppConfig(
      flavor: Flavor.abomis,
      lightTheme: ThemeData(primaryColor: Colors.blue),
      darkTheme: ThemeData(primaryColor: Colors.deepPurple),
      baseUrl: "https://example.com",
      logoAddress: "assets/images/logo.png",
    );

    // Act
    final appConfig2 = AppConfig(
      flavor: Flavor.abomis,
      lightTheme: ThemeData(primaryColor: Colors.orange),
      darkTheme: ThemeData(primaryColor: Colors.pink),
      baseUrl: "https://example.net",
      logoAddress: "assets/images/logo_alt.png",
    );

    // Assert
    expect(appConfig1, appConfig2);
    expect(AppConfig.instance, appConfig1);
  });

  test('Test FlavorExtension', () {
    // Arrange
    final flavor = Flavor.abomis;

    // Act
    final flavorName = flavor.name;

    // Assert
    expect(flavorName, "Abomis");
  });
}
