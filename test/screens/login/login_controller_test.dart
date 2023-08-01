import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/constants/my_json.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/my_app.dart';
import 'package:online_check_in/screens/login/login_controller.dart';
import 'package:online_check_in/screens/login/login_state.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../init_test.dart';

void main() async {
  initTest();
  late LoginController loginController;
  late LoginState loginState;
  late WidgetRef ref;
  final myJson = MyJson.flightInformationResJson["Body"];

  setUp(() async {
    ref = getIt<WidgetRef>();
    loginController = LoginController();
    loginState = ref.read(loginProvider);
  });

  group("description", () {

    test('Login method should set token', () async {
      await loginController.login(username: "test", password: "9999999999");
      expect(loginState.token, "B9C56306-3FF3-457C-9C3A-1541734439D9");
    });

    test('Checking information of passenger', () {
      FlightInformation fI = ref.read(flightInformationProvider)!;
      expect(fI.passengers.length, (myJson["Passengers"] as List).length);
      expect(fI.passengers[0].name, myJson["Passengers"][0]["Name"]);
      expect(fI.passengers[0].id, myJson["Passengers"][0]["ID"]);
      expect(fI.passengers[0].title, myJson["Passengers"][0]["Title"]);
      expect(fI.passengers[0].firstName, myJson["Passengers"][0]["FirstName"]);
    });

    test('Checking information of flight', () {
      FlightInformation fI = ref.read(flightInformationProvider)!;
      expect(fI.flight[0].id, myJson["Flight"][0]["ID"]);
      expect(fI.flight[0].aircraft, myJson["Flight"][0]["Aircraft"]);
      expect(fI.flight[0].terminal, myJson["Flight"][0]["Terminal"]);
      expect(fI.flight[0].toCity, myJson["Flight"][0]["To_City"]);
      expect(fI.flight[0].fromCity, myJson["Flight"][0]["From_City"]);
    });

    test('Checking information of seatmap', () {
      FlightInformation fI = ref.read(flightInformationProvider)!;
      expect(fI.seatmap.cabins.length, (myJson["Seatmap"]["Cabins"] as List).length);
      expect(fI.seatmap.cabins[0].cabinTitle, myJson["Seatmap"]["Cabins"][0]["CabinTitle"]);
      expect(fI.seatmap.cabins[0].linesCount, myJson["Seatmap"]["Cabins"][0]["LinesCount"]);
      expect(fI.seatmap.cabins[0].cabinClass, myJson["Seatmap"]["Cabins"][0]["CabinClass"]);
    });
  });
}
