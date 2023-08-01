import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/visa_type.dart';

void main() {
  group('VisaType', () {
    test('Test factory method example()', () {
      // Arrange
      final expectedVisaType = VisaType(
        id: -1,
        shortName: "",
        name: "",
        fullName: "Type",
      );

      // Act
      final visaType = VisaType.example();

      // Assert
      expect(visaType.id, expectedVisaType.id);
      expect(visaType.shortName, expectedVisaType.shortName);
      expect(visaType.name, expectedVisaType.name);
      expect(visaType.fullName, expectedVisaType.fullName);
    });

    test('Test toJson() method', () {
      // Arrange
      final visaType = VisaType(
        id: 1,
        shortName: "V",
        name: "Visa",
        fullName: "Visa Type",
      );

      // Act
      final json = visaType.toJson();

      // Assert
      expect(json, {
        "ID": 1,
        "ShortName": "V",
        "name": "Visa",
        "FullName": "Visa Type",
      });
    });

    test('Test fromJson() method', () {
      // Arrange
      final json = {
        "ID": 1,
        "ShortName": "V",
        "name": "Visa",
        "FullName": "Visa Type",
      };

      // Act
      final visaType = VisaType.fromJson(json);

      // Assert
      expect(visaType.id, 1);
      expect(visaType.shortName, "V");
      expect(visaType.name, "Visa");
      expect(visaType.fullName, "Visa Type");
    });
  });
}
