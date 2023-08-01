import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/seat_map.dart';
import 'package:online_check_in/core/constants/my_json.dart';

void main() {
  group('SeatMap', () {
    test('Test fromJson() method', () {
      // Arrange
      final json = MyJson.flightInformationResJson["Body"]["Seatmap"];
      // Act
      final seatMap = SeatMap.fromJson(json);

      // Assert
      expect(seatMap.cabins[0].cabinClass, json["Cabins"][0]["CabinClass"]);
      expect(seatMap.cabins[0].linesCount, json["Cabins"][0]["LinesCount"]);
      expect(seatMap.cabins[0].cabinTitle, json["Cabins"][0]["CabinTitle"]);

    });
  });
}
