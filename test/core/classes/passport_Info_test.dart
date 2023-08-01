import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/Passport_Info.dart';

void main() {
  group('PassportInfo', () {
    test('Test initial property values', () {
      // Arrange & Act
      final passportInfo = PassportInfo();

      // Assert
      expect(passportInfo.isPassInfoCompleted, false);
      expect(passportInfo.passportType, null);
      expect(passportInfo.documentNo, null);
      expect(passportInfo.gender, null);
      expect(passportInfo.countryOfIssue, null);
      expect(passportInfo.nationality, null);
      expect(passportInfo.dateOfBirth, null);
      expect(passportInfo.entryDate, null);
    });

    test('Test updateIsCompleted() method', () {
      // Arrange
      final passportInfo = PassportInfo();

      // Act
      final isCompletedBeforeUpdate = passportInfo.isPassInfoCompleted;
      final isCompletedAfterUpdate = passportInfo.updateIsCompleted();

      // Assert
      expect(isCompletedBeforeUpdate, false);
      expect(isCompletedAfterUpdate, false);

      // Update properties
      passportInfo.passportType = 'Type';
      passportInfo.documentNo = '123456789';
      passportInfo.gender = 'Male';
      passportInfo.countryOfIssue = 'Country';
      passportInfo.nationality = 'Nationality';
      passportInfo.dateOfBirth = DateTime.now();
      passportInfo.entryDate = DateTime.now();

      // Act
      final isCompletedAfterPropertiesUpdate = passportInfo.updateIsCompleted();

      // Assert
      expect(isCompletedAfterPropertiesUpdate, true);
      expect(passportInfo.isPassInfoCompleted, true);
    });
  });
}
