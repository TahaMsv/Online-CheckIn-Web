import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/classes/seat_map.dart';
import 'package:online_check_in/core/constants/my_json.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/screens/seat_map/seat_map_controller.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../init_test.dart';

void main() async {
  initTest();
  late WidgetRef ref;

  late SeatMapState seatMapState;
  late SeatMapController seatMapController;
  setUp(() {
    ref = getIt<WidgetRef>();
    seatMapState = ref.read(seatMapProvider);
    seatMapController = SeatMapController();
    ref.read(cabinsProvider.notifier).state = List<Cabin>.from(MyJson.flightInformationResJson["Body"]["Seatmap"]["Cabins"].map((x) => Cabin.fromJson(x)));
  });

  group("Seatmap controller", () {
    group('getSeatHeight', () {
      test('should return the default seat height when seatType is not 8, 9, 10, 11, or 12', () {
        // Act
        final result = seatMapState.airCraftBodySize.seatHeight;

        // Assert
        expect(result, 35);
      });

      test('should return 0 when seatType is 8, 9, or 10', () {
        // Arrange

        // Act
        final result1 = seatMapController.getSeatHeight(8);
        final result2 = seatMapController.getSeatHeight(9);
        final result3 = seatMapController.getSeatHeight(10);

        // Assert
        expect(result1, 0);
        expect(result2, 0);
        expect(result3, 0);
      });

      test('should return height - 15 when seatType is 11', () {
        // Act
        final result = seatMapController.getSeatHeight(11);

        // Assert
        expect(result, 20);
      });

      test('should return height - 25 when seatType is 12', () {
        // Act
        final result = seatMapController.getSeatHeight(12);

        // Assert
        expect(result, 10);
      });
    });

    group('getSeatWidth', () {
      test('should return the default seat width when seatType is not 2, 8, 9, 10, 11, or 12', () {
        // Act
        final result = seatMapController.getSeatWidth(1);

        // Assert
        expect(result, 35);
      });

      test('should return width - 15 when seatType is 2, 8, 9, or 11', () {
        // Act
        final result1 = seatMapController.getSeatWidth(2);
        final result2 = seatMapController.getSeatWidth(8);
        final result3 = seatMapController.getSeatWidth(9);
        final result4 = seatMapController.getSeatWidth(11);

        // Assert
        expect(result1, 20);
        expect(result2, 20);
        expect(result3, 20);
        expect(result4, 20);
      });

      test('should return 0 when seatType is 10', () {
        final result = seatMapController.getSeatWidth(10);

        // Assert
        expect(result, 0);
      });

      test('should return width - 25 when seatType is 12', () {
        // Act
        final result = seatMapController.getSeatWidth(12);

        // Assert
        expect(result, 10);
      });
    });

    group('calculatePlaneBodyLength', () {
      test('should calculate the correct plane body length for tablet mode', () {
        // Act
        final result = seatMapController.calculatePlaneBodyLength(mode: RunningMode.tablet);

        // Assert
        expect(result, 2035); // Replace with the expected result
      });

      test('should calculate the correct plane body length for phone mode', () {
        // Act
        final result = seatMapController.calculatePlaneBodyLength(mode: RunningMode.phone);

        // Assert
        expect(result, 1435); // Replace with the expected result
      });

      test('should calculate the correct plane body height for tablet mode', () {
        // Act
        final result = seatMapController.calculatePlaneBodyHeight(mode: RunningMode.tablet);

        // Assert
        expect(result, 504); // Replace with the expected result
      });

      test('should calculate the correct plane body height for phone mode', () {
        // Act
        final result = seatMapController.calculatePlaneBodyHeight(mode: RunningMode.phone);

        // Assert
        expect(result, 344); // Replace with the expected result
      });
    });

    group('numberOfCabinCellsInLine', () {
      test('should return the number of cells in line for the given cabin class', () {
        final result = seatMapController.numberOfCabinCellsInLine(CabinClass.economy);

        // Assert
        expect(result, 12);
      });
    });
  });
}
