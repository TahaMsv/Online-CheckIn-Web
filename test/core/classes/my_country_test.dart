import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/my_country.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('MyCountry', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = MyJson.selectCountriesResJson["Body"]["Countries"][0];

      // Act
      final myCountry = MyCountry.fromJson(json);

      // Assert
      expect(myCountry.id, json["ID"]);
      expect(myCountry.name, json["Name"]);
      expect(myCountry.englishName, json["EnglishName"]);
      expect(myCountry.code3, json["Code3"]);
      expect(myCountry.worldAreaCode, json["World_Area_Code"]);
      // Assert MyCountry properties...
    });

    test('Test toJson() method', () {
      // Arrange
      final myCountry = MyCountry(id: "AF", code3: "AFG", name: "Afghanistan", worldAreaCode: "701", englishName: "AFG - AFGHANISTAN", currencyId: null, regionId: null, hasOnHoldBooking: null, isDisabled: null);

      // Act
      final json = myCountry.toJson();

      // Assert
      expect(json["ID"],"AF");
      expect(json["Code3"], "AFG");
      // Assert MyCountry properties...
    });

    test('Test example() factory method', () {
      // Arrange
      final englishName = "United States";

      // Act
      final myCountry = MyCountry.example(englishName);

      // Assert
      expect(myCountry.worldAreaCode, null);
      expect(myCountry.currencyId, null);
      expect(myCountry.englishName, englishName);
      // Assert MyCountry properties...
    });
  });
}
