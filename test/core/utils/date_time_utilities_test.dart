import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:online_check_in/core/utils/date_time_utilities.dart';

void main() {
  test('Test formatDate()', () {
    // Arrange
    final dateTime = DateTime(2023, 5, 25);
    final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    // Act
    final result = DateTimeUtilities.formatDate(dateTime);

    // Assert
    expect(result, formattedDate);
  });

  test('Test formatString()', () {
    // Arrange
    final dateString = '2023-05-25';
    final expectedDateTime = DateTime(2023, 5, 25);

    // Act
    final result = DateTimeUtilities.formatString(dateString);

    // Assert
    expect(result, expectedDateTime);
  });

  test('Test dateFromString()', () {
    // Arrange
    final dateString = '2023-05-25';
    final expectedDateTime = DateTime(2023, 5, 25);

    // Act
    final result = DateTimeUtilities.dateFromString(dateString);

    // Assert
    expect(result, expectedDateTime);
  });

  test('Test stringFromDate()', () {
    // Arrange
    final dateTime = DateTime(2023, 5, 25);
    final expectedString = dateTime.toString();

    // Act
    final result = DateTimeUtilities.stringFromDate(dateTime);

    // Assert
    expect(result, expectedString);
  });
}
