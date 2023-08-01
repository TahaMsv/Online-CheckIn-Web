import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/flight.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/classes/passenger.dart';
import 'package:online_check_in/core/classes/seat.dart';
import 'package:online_check_in/core/classes/seat_map.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('FlightInformation', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = MyJson.flightInformationResJson["Body"];

      // Act
      final flightInformation = FlightInformation.fromJson(json);

      // Assert

      expect(flightInformation.flight[0].id, json["Flight"][0]["ID"]);
      expect(flightInformation.flight[0].aircraft, json["Flight"][0]["Aircraft"]);

      expect(flightInformation.passengers[0].id, json["Passengers"][0]["ID"]);
      expect(flightInformation.passengers[0].name, json["Passengers"][0]["Name"]);

      expect(flightInformation.seats[0].letter, json["Seats"][0]["Letter"]);
      expect(flightInformation.seats[0].line, json["Seats"][0]["Line"]);

      expect(flightInformation.seatmap.cabins.length, (json["Seatmap"]["Cabins"] as List).length);
    });

    // test('Test toJson() method', () {
    //   // Arrange
    //   final flight = Flight(
    //     id: 1,
    //     aircraft: "ABC123",
    //     fromCity: "City A",
    //     toCity: "City B",
    //     fromCityName: "City A",
    //     toCityName: "City B",
    //     fromTime: "10:00 AM",
    //     toTime: "12:00 PM",
    //     flightDate: DateTime(2023, 5, 25),
    //     terminal: 2,
    //     flnb: "1234",
    //     aircraftShowName: "ABC 123",
    //     boardingTime: "9:30 AM",
    //     checkDocs: 1,
    //   );
    //   final passenger =  Passenger(
    //     id: 1,
    //     name: "John Doe",
    //     classType: "E",
    //     firstName: "John",
    //     lastName: "Doe",
    //     title: "Mr.",
    //     docsTitle: "Passport",
    //   );
    //   final seat = Seat(
    //     id: 1,
    //     number: "A1",
    //     // Seat properties...
    //   );
    //   final seatmap = SeatMap(
    //     id: 1,
    //     // SeatMap properties...
    //   );
    //
    //   final flightInformation = FlightInformation(
    //     flight: [flight],
    //     passengers: [passenger],
    //     seats: [seat],
    //     seatmap: seatmap,
    //   );
    //
    //   // Act
    //   final json = flightInformation.toJson();
    //
    //   // Assert
    //   expect(json["Flight"] is List<dynamic>, true);
    //   expect(json["Passengers"] is List<dynamic>, true);
    //   expect(json["Seats"] is List<dynamic>, true);
    //   expect(json["Seatmap"] is Map<String, dynamic>, true);
    //
    //   expect(json["Flight"][0]["ID"], 1);
    //   expect(json["Flight"][0]["Aircraft"], "ABC123");
    //   // Assert Flight properties...
    //
    //   expect(json["Passengers"][0]["ID"], 1);
    //   expect(json["Passengers"][0]["Name"], "John Doe");
    //   // Assert Passenger properties...
    //
    //   expect(json["Seats"][0]["ID"], 1);
    //   expect(json["Seats"][0]["Number"], "A1");
    //   // Assert Seat properties...
    //
    //   expect(json["Seatmap"]["ID"], 1);
    //   // Assert SeatMap properties...
    // });
  });
}
