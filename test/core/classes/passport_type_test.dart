import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/passport_type.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('PassPortType', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = MyJson.selectDocumentTypesResJson["Body"]["PassportTypes"][0];

      // Act
      final passPortType = PassPortType.fromJson(json);

      // Assert
      expect(passPortType.id, json["ID"]);
      expect(passPortType.shortName, json["ShortName"]);
      expect(passPortType.name, json["name"]);
      expect(passPortType.fullName, json["FullName"]);
    });

    test('Test toJson() method', () {
      // Arrange
      final passPortType = PassPortType(
        id: 1,
        shortName: "Short",
        name: "Name",
        fullName: "Full Name",
      );

      // Act
      final json = passPortType.toJson();

      // Assert
      expect(json["ID"], 1);
      expect(json["ShortName"], "Short");
      expect(json["name"], "Name");
      expect(json["FullName"], "Full Name");
    });

    test('Test example() factory method', () {
      // Act
      final passPortType = PassPortType.example();

      // Assert
      expect(passPortType.id, -1);
      expect(passPortType.shortName, "");
      expect(passPortType.name, "");
      expect(passPortType.fullName, "Passport Type");
    });
  });
}
