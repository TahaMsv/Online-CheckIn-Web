import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/Passport_Info.dart' as pi;
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/classes/passport_Info.dart';
import 'package:online_check_in/core/classes/traveler.dart';
import 'package:online_check_in/core/classes/visa_Info.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('Traveler', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = {
        "token": "12345",
        "ticketNumber": "ABC123",
        "seatId": "A1",
        "flightInformation": MyJson.flightInformationResJson["Body"]
      };

      // Act
      final traveler = Traveler.fromJson(json);

      // Assert
      expect(traveler.token, "12345");
      expect(traveler.ticketNumber, "ABC123");
      expect(traveler.seatId, "A1");
      expect(traveler.flightInformation.passengers.length, 1);
      expect(traveler.flightInformation.passengers[0].name, "MIA YOUNG");
    });

    test('Test toJson() method', () {
      // Arrange
      final flightInformation = FlightInformation.fromJson(MyJson.flightInformationResJson["Body"]);
      final traveler = Traveler(
        token: "12345",
        ticketNumber: "ABC123",
        seatId: "A1",
        flightInformation: flightInformation,
      );

      // Act
      final json = traveler.toJson();

      // Assert
      expect(json["token"], "12345");
      expect(json["ticketNumber"], "ABC123");
      expect(json["seatId"], "A1");
      expect(json["flightInformation"]["Passengers"][0]["Name"], "MIA YOUNG");
      expect(json["flightInformation"]["Passengers"][0]["Title"], "MRS");
    });

    test('Test getNickName() method', () {
      final flightInformation = FlightInformation.fromJson(MyJson.flightInformationResJson["Body"]);
      final traveler = Traveler(
        token: "12345",
        ticketNumber: "ABC123",
        seatId: "A1",
        flightInformation: flightInformation,
      );

      // Act
      final nickname = traveler.getNickName();

      // Assert
      expect(nickname, "MY");
    });

    test('Test getFullNameWithGender() method', () {
      // Arrange
      final flightInformation = FlightInformation.fromJson(MyJson.flightInformationResJson["Body"]);
      final traveler = Traveler(
        token: "12345",
        ticketNumber: "ABC123",
        seatId: "A1",
        flightInformation: flightInformation,
      );

      // Act
      final fullNameWithGender = traveler.getFullNameWithGender();

      // Assert
      expect(fullNameWithGender, "Ms. MIA YOUNG");
    });

    test('Test setVisaInfo() and visaInfo getter', () {
      // Arrange
      final visaInfo = VisaInfo();
      final flightInformation = FlightInformation.fromJson(MyJson.flightInformationResJson["Body"]);
      final traveler = Traveler(
        token: "12345",
        ticketNumber: "ABC123",
        seatId: "A1",
        flightInformation: flightInformation,
      );

      // Act
      traveler.setVisaInfo(visaInfo);

      // Assert
      expect(traveler.visaInfo, visaInfo);
    });

    test('Test setPassportInfo() and passportInfo getter', () {
      // Arrange
      final PassportInfo passportInfo = PassportInfo();
      final flightInformation = FlightInformation.fromJson(MyJson.flightInformationResJson["Body"]);
      final traveler = Traveler(
        token: "12345",
        ticketNumber: "ABC123",
        seatId: "A1",
        flightInformation: flightInformation,
      );

      // Act
      traveler.setPassportInfo(passportInfo);

      // Assert
      expect(traveler.passportInfo, passportInfo);
    });
  });
}
