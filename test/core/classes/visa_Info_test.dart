import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/visa_Info.dart';

void main() {
  group('VisaInfo', () {
    test('Test updateIsCompleted() method with complete information', () {
      // Arrange
      final visaInfo = VisaInfo(
        type: "Tourist Visa",
        documentNo: "ABC123",
        placeOfIssue: "City A",
        destination: "City B",
        issueDate: DateTime.now(),
      );

      // Act
      final isCompleted = visaInfo.updateIsCompleted();

      // Assert
      expect(isCompleted, true);
      expect(visaInfo.isVisaInfoCompleted, true);
    });

    test('Test updateIsCompleted() method with incomplete information', () {
      // Arrange
      final visaInfo = VisaInfo(
        type: "Business Visa",
        documentNo: "XYZ789",
        placeOfIssue: null,
        destination: "City C",
        issueDate: DateTime.now(),
      );

      // Act
      final isCompleted = visaInfo.updateIsCompleted();

      // Assert
      expect(isCompleted, false);
      expect(visaInfo.isVisaInfoCompleted, false);
    });
  });
}
