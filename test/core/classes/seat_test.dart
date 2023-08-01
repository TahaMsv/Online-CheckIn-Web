import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/seat.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('Seat', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = MyJson.flightInformationResJson["Body"]["Seats"][0];

      // Act
      final seat = Seat.fromJson(json);

      // Assert
      expect(seat.line, json["Line"]);
      expect(seat.letter, json["Letter"]);
      expect(seat.isUsedDescription, json["IsUsedDescription"]);
      expect(seat.price, json["Price"]);
    });

    test('Test toJson() method', () {
      // Arrange
      final seat = Seat(
        line: "A",
        letter: "1",
        isUsedDescription: "Occupied",
        price: 10,
      );

      // Act
      final json = seat.toJson();

      // Assert
      expect(json["Line"], "A");
      expect(json["Letter"], "1");
      expect(json["IsUsedDescription"], "Occupied");
      expect(json["Price"], 10);
    });
  });
}
