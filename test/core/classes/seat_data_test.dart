import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/seat_data.dart';

void main() {
  test('Test toJson() method', () {
    // Arrange
    final seatData = SeatData(
      passengerId: 123,
      letter: 'A',
      line: 1,
    );

    // Act
    final json = seatData.toJson();

    // Assert
    expect(json['PassengerID'], 123);
    expect(json['Letter'], 'A');
    expect(json['Line'], 1);
  });
}
