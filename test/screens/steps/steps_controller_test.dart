import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/classes/passport_Info.dart';
import 'package:online_check_in/core/classes/traveler.dart';
import 'package:online_check_in/core/classes/visa_Info.dart';
import 'package:online_check_in/core/constants/my_json.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/screens/login/login_controller.dart';
import 'package:online_check_in/screens/login/login_state.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../init_test.dart';

void main() async {
  initTest();
  late LoginState loginState;
  late StepsState stepsState;
  late StepsController stepsController;
  late WidgetRef ref;

  final flightInfoJson = MyJson.flightInformationResJson["Body"];
  const mockToken = "B9C56306-3FF3-457C-9C3A-1541734439D9";
  String token = MyJson.authenticateResJson["Body"]["Token"];

  void addToTravelersMock({token, lastName, ticketNumber}) {
    FlightInformation fI = ref.read(flightInformationProvider)!;
    for (int i = 0; i < stepsState.travelers.length; i++) {
      if (stepsState.travelers[i].flightInformation.passengers.last.id == fI.passengers.last.id) {
        stepsState.setLoading(false);
        return;
      }
    }

    Traveler traveler = Traveler(token: token, ticketNumber: ticketNumber, seatId: "--", flightInformation: fI);
    traveler.setPassportInfo(PassportInfo());
    traveler.setVisaInfo(VisaInfo());
    stepsState.setIsDocsNecessary(true);
    stepsState.setIsDocoNecessary(true);
    stepsState.travelers.add(traveler);
    stepsState.setLoading(false);
  }

  setUp(() async {
    ref = getIt<WidgetRef>();
    loginState = ref.read(loginProvider);
    stepsController = StepsController();
    stepsState = ref.read(stepsProvider);

    loginState.setToken(token);

    ref.read(flightInformationProvider.notifier).state = FlightInformation.fromJson(flightInfoJson);
    addToTravelersMock(token: mockToken, lastName: "test", ticketNumber: "9999999999");
  });

  group("Steps controller", () {
    group("addToTraveler method and removeFromTravelers", () {
      test('addToTraveler method works correctly', () {
        expect(loginState.token, mockToken);
        expect(stepsState.isDocoNecessary, true);
        expect(stepsState.isDocsNecessary, true);
        expect(stepsState.isDocsNecessary, true);
        expect(stepsState.travelers.length, 1);
      });

      test('addToTraveler method should not add duplicate traveler ', () {
        // loginController.login(username: "test", password: "9999999999");

        addToTravelersMock(token: mockToken, lastName: "test", ticketNumber: "9999999999");
        expect(stepsState.travelers.length, 1);
      });

      test('removeFromTravelers works correctly', () {
        // loginController.login(username: "test", password: "9999999999");
        stepsController.removeFromTravelers(0);
        expect(stepsState.travelers.length, 0);
      });

      test('removeFromTravelers should not remove any traveler if does not exist', () {
        // loginController.login(username: "test", password: "9999999999");
        stepsController.removeFromTravelers(1);
        expect(stepsState.travelers.length, 1);
        stepsController.removeFromTravelers(0);
        expect(stepsState.travelers.length, 0);
        stepsController.removeFromTravelers(1);
        expect(stepsState.travelers.length, 0);
      });
    });

    test('findTravellerIndexBySeatId works correctly', () {
      // loginController.login(username: "test", password: "9999999999");
      int index = stepsController.findTravellerIndexBySeatId("--");
      expect(index, 0);

      index = stepsController.findTravellerIndexBySeatId("A10");
      expect(index, -1);
    });

    test('changeTurnToSelect works correctly', () {
      // loginController.login(username: "test", password: "9999999999");
      stepsController.changeTurnToSelect();
      expect(stepsState.whoseTurnToSelect, 0);

      stepsState.travelers[0].seatId = "A10";
      stepsController.changeTurnToSelect();
      expect(stepsState.whoseTurnToSelect, -1);
    });
    test('changeStateOFAddingBox works correctly', () {
      // loginController.login(username: "test", password: "9999999999");
      stepsController.changeStateOFAddingBox();
      expect(stepsState.isAddingBoxOpen, true);

      stepsController.changeStateOFAddingBox();
      expect(stepsState.isAddingBoxOpen, false);
    });

    group("isStepNeeded method", () {
      test('isStepNeeded works correctly for step 0', () {
        expect(stepsController.isStepNeeded(0), true);
      });
      test('isStepNeeded works correctly for step 1', () {
        expect(stepsController.isStepNeeded(1), false);
      });
      test('isStepNeeded works correctly for step 2', () {
        expect(stepsController.isStepNeeded(2), true);
      });
      test('isStepNeeded works correctly for step 3', () {
        expect(stepsController.isStepNeeded(3), true);
        stepsState.setIsDocsNecessary(false);
        expect(stepsController.isStepNeeded(3), false);
      });
      test('isStepNeeded works correctly for step 4', () {
        stepsState.setIsDocsNecessary(true);
        expect(stepsController.isStepNeeded(4), true);
        stepsState.setIsDocoNecessary(false);
        expect(stepsController.isStepNeeded(4), false);
        stepsState.setIsDocsNecessary(false);
        expect(stepsController.isStepNeeded(4), false);
      });
      test('isStepNeeded works correctly for step 5', () {
        expect(stepsController.isStepNeeded(5), true);
        stepsState.flightType = 'd';
        expect(stepsController.isStepNeeded(5), false);
      });
      test('isStepNeeded works correctly for step 6, 7, 8', () {
        expect(stepsController.isStepNeeded(6), true);
      });
    });

    group("stepsToShowList method", () {
      test('stepsToShowList works correctly', () {
        stepsState.setIsDocsNecessary(true);
        stepsState.setIsDocoNecessary(true);
        stepsState.flightType = 'i';
        expect(stepsController.stepsToShowList(), [0, 2, 3, 4, 5, 6, 7, 8]);
      });

      test('stepsToShowList works correctly if setIsDocoNecessary(false)', () {
        stepsState.setIsDocoNecessary(false);
        expect(stepsController.stepsToShowList(), [0, 2, 3, 5, 6, 7, 8]);
      });
      test('stepsToShowList works correctly if setIsDocsNecessary(false)', () {
        stepsState.setIsDocsNecessary(false);
        expect(stepsController.stepsToShowList(), [0, 2, 5, 6, 7, 8]);
      });
      test('stepsToShowList works correctly if flightType = "d"', () {
        stepsState.setIsDocsNecessary(true);
        stepsState.setIsDocoNecessary(true);
        stepsState.flightType = 'd';
        expect(stepsController.stepsToShowList(), [0, 2, 3, 4, 6, 7, 8]);
      });
    });

    test('Login method should set token', () {
      // loginController.login(username: "test", password: "9999999999");

      expect(loginState.token, mockToken);
    });

    test('Checking information of passenger', () {
      // loginController.login(username: "test", password: "9999999999");
      FlightInformation fI = ref.read(flightInformationProvider)!;

      expect(fI.passengers.length, (flightInfoJson["Passengers"] as List).length);
      expect(fI.passengers[0].name, flightInfoJson["Passengers"][0]["Name"]);
      expect(fI.passengers[0].id, flightInfoJson["Passengers"][0]["ID"]);
      expect(fI.passengers[0].title, flightInfoJson["Passengers"][0]["Title"]);
      expect(fI.passengers[0].firstName, flightInfoJson["Passengers"][0]["FirstName"]);
    });

    test('Checking information of flight', () {
      // loginController.login(username: "test", password: "9999999999");
      FlightInformation fI = ref.read(flightInformationProvider)!;

      expect(fI.flight[0].id, flightInfoJson["Flight"][0]["ID"]);
      expect(fI.flight[0].aircraft, flightInfoJson["Flight"][0]["Aircraft"]);
      expect(fI.flight[0].terminal, flightInfoJson["Flight"][0]["Terminal"]);
      expect(fI.flight[0].toCity, flightInfoJson["Flight"][0]["To_City"]);
      expect(fI.flight[0].fromCity, flightInfoJson["Flight"][0]["From_City"]);
    });

    test('Checking information of seatmap', () {
      // loginController.login(username: "test", password: "9999999999");
      FlightInformation fI = ref.read(flightInformationProvider)!;

      expect(fI.seatmap.cabins.length, (flightInfoJson["Seatmap"]["Cabins"] as List).length);
      expect(fI.seatmap.cabins[0].cabinTitle, flightInfoJson["Seatmap"]["Cabins"][0]["CabinTitle"]);
      expect(fI.seatmap.cabins[0].linesCount, flightInfoJson["Seatmap"]["Cabins"][0]["LinesCount"]);
      expect(fI.seatmap.cabins[0].cabinClass, flightInfoJson["Seatmap"]["Cabins"][0]["CabinClass"]);
    });
  });
}
