import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/passenger.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('Passenger', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = MyJson.flightInformationResJson["Body"]["Passengers"][0];

      // Act
      final passenger = Passenger.fromJson(json);

      // Assert
      expect(passenger.id, json["ID"]);
      expect(passenger.name,  json["Name"]);
      expect(passenger.classType,  json["ClassType"]);
      expect(passenger.firstName,  json["FirstName"]);
      expect(passenger.lastName,  json["LastName"]);
      expect(passenger.title,  json["Title"]);
      expect(passenger.docsTitle,  json["DocsTitle"]);
    });

    test('Test toJson() method', () {
      // Arrange
      final passenger = Passenger(
        id: 1,
        name: "John Doe",
        classType: "E",
        firstName: "John",
        lastName: "Doe",
        title: "Mr.",
        docsTitle: "Passport",
      );

      // Act
      final json = passenger.toJson();

      // Assert
      expect(json["ID"], 1);
      expect(json["Name"], "John Doe");
      expect(json["ClassType"], "E");
      expect(json["FirstName"], "John");
      expect(json["LastName"], "Doe");
      expect(json["Title"], "Mr.");
      expect(json["DocsTitle"], "Passport");
    });

    test('Test cabin getter', () {
      // Arrange
      final passengerEconomy = Passenger(
        id: 1,
        name: "John Doe",
        classType: "E",
        firstName: "John",
        lastName: "Doe",
        title: "Mr.",
        docsTitle: "Passport",
      );

      final passengerFirstClass = Passenger(
        id: 2,
        name: "Jane Smith",
        classType: "F",
        firstName: "Jane",
        lastName: "Smith",
        title: "Ms.",
        docsTitle: "Passport",
      );

      final passengerBusiness = Passenger(
        id: 3,
        name: "Robert Johnson",
        classType: "B",
        firstName: "Robert",
        lastName: "Johnson",
        title: "Mr.",
        docsTitle: "Passport",
      );

      final passengerOtherClass = Passenger(
        id: 4,
        name: "Amy Wilson",
        classType: "C",
        firstName: "Amy",
        lastName: "Wilson",
        title: "Mrs.",
        docsTitle: "Passport",
      );

      // Act & Assert
      expect(passengerEconomy.cabin, "Economy");
      expect(passengerFirstClass.cabin, "First Class");
      expect(passengerBusiness.cabin, "Business");
      expect(passengerOtherClass.cabin, "C");
    });
  });
}
