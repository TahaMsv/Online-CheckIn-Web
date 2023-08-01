import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/classes/aircraft_body_size.dart';

void main() {

  late AirCraftBodySize aircraftBodySize;


  setUp(() {
    aircraftBodySize = AirCraftBodySize.example();
  });


  group('AirCraftBodySize', () {
    test('Test setting properties', () {

      aircraftBodySize.setEachLineWidth(40);
      aircraftBodySize.setSeatWidth(40);
      aircraftBodySize.setSeatHeight(40);
      aircraftBodySize.setLinesMargin(10);
      aircraftBodySize.setFirstClassCabinsRatio(2.0);
      aircraftBodySize.setBusinessCabinsRatio(2.0);

      // Assert
      expect(aircraftBodySize.eachLineWidth, 40);
      expect(aircraftBodySize.seatWidth, 40);
      expect(aircraftBodySize.seatHeight, 40);
      expect(aircraftBodySize.linesMargin, 10);
      expect(aircraftBodySize.firstClassCabinsRatio, 2.0);
      expect(aircraftBodySize.businessCabinsRatio, 2.0);

    });

    test('Test factory example()', () {

      // Assert
      expect(aircraftBodySize.eachLineWidth, 35);
      expect(aircraftBodySize.seatWidth, 35);
      expect(aircraftBodySize.seatHeight, 35);
      expect(aircraftBodySize.linesMargin, 7);
      expect(aircraftBodySize.firstClassCabinsRatio, 1.5);
      expect(aircraftBodySize.businessCabinsRatio, 1.5);
    });
  });
}
