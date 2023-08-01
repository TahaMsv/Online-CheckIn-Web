import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/boarding_pass_pdf.dart';

void main() {
  group('BoardingPassPDF', () {
    test('Test toJson() method', () {
      // Arrange
      final boardingPass = BoardingPassPDF(buffer: "example buffer");

      // Act
      final json = boardingPass.toJson();

      // Assert
      expect(json["_buffer"], "example buffer");
    });

    test('Test fromJson() method', () {
      // Arrange
      final json = {
        "_buffer": "example buffer",
      };

      // Act
      final boardingPass = BoardingPassPDF.fromJson(json);

      // Assert
      expect(boardingPass.buffer, "example buffer");
    });
  });
}
