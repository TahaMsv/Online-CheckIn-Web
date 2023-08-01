import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/flight.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('Flight', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = MyJson.flightInformationResJson["Body"]["Flight"][0];

      // Act
      final flight = Flight.fromJson(json);

      // Assert
      expect(flight.id, json["ID"]);
      expect(flight.aircraft, json["Aircraft"]);
      expect(flight.fromCity, json["From_City"]);
      expect(flight.toCity, json["To_City"]);
      expect(flight.flightDate, DateTime(2023, 5, 25));
    });

    test('Test toJson() method', () {
      // Arrange
      final flight = Flight(
        id: 1,
        aircraft: "ABC123",
        fromCity: "City A",
        toCity: "City B",
        fromCityName: "City A",
        toCityName: "City B",
        fromTime: "10:00 AM",
        toTime: "12:00 PM",
        flightDate: DateTime(2023, 5, 25),
        terminal: 2,
        flnb: "1234",
        aircraftShowName: "ABC 123",
        boardingTime: "9:30 AM",
        checkDocs: 1,
      );

      // Act
      final json = flight.toJson();

      // Assert
      expect(json["ID"], 1);
      expect(json["Aircraft"], "ABC123");
      expect(json["From_City"], "City A");
      expect(json["To_City"], "City B");
      expect(json["From_CityName"], "City A");
      expect(json["To_CityName"], "City B");
      expect(json["From_Time"], "10:00 AM");
      expect(json["To_Time"], "12:00 PM");
      expect(json["FlightDate"], "2023-05-25");
      expect(json["Terminal"], 2);
      expect(json["FLNB"], "1234");
      expect(json["AircraftShowName"], "ABC 123");
      expect(json["BoardingTime"], "9:30 AM");
      expect(json["CheckDocs"], 1);
    });

    test('Test flightDateString getter', () {
      // Arrange
      final flight = Flight(
        id: 1,
        aircraft: "ABC123",
        fromCity: "City A",
        toCity: "City B",
        fromCityName: "City A",
        toCityName: "City B",
        fromTime: "10:00 AM",
        toTime: "12:00 PM",
        flightDate: DateTime(2023, 5, 25),
        terminal: 2,
        flnb: "1234",
        aircraftShowName: "ABC 123",
        boardingTime: "9:30 AM",
        checkDocs: 1,
      );

      // Act
      final flightDateString = flight.flightDateString;

      // Assert
      expect(flightDateString, "2023-05-25");
    });
  });
}
