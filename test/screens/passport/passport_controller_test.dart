import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/classes/my_country.dart';
import 'package:online_check_in/core/classes/passport_Info.dart';
import 'package:online_check_in/core/classes/passport_type.dart';
import 'package:online_check_in/core/classes/traveler.dart';
import 'package:online_check_in/core/classes/visa_Info.dart';
import 'package:online_check_in/core/constants/my_json.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/core/utils/drop_down_utils.dart';
import 'package:online_check_in/screens/Passport/passport_controller.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
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
  late PassportController passportController;
  late PassportState passportState;
  late WidgetRef ref;

  final flightInfoJson = MyJson.flightInformationResJson["Body"];
  const mockToken = "B9C56306-3FF3-457C-9C3A-1541734439D9";
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
    passportController = PassportController();
    passportState = ref.read(passportProvider);

    String token = MyJson.authenticateResJson["Body"]["Token"];
    loginState.setToken(token);

    ref.read(flightInformationProvider.notifier).state = FlightInformation.fromJson(flightInfoJson);
    addToTravelersMock(token: mockToken, lastName: "test", ticketNumber: "9999999999");
  });

  group("Passport controller", () {
    test("Passport controller init", () async {
      await passportController.passportInit();

      expect(passportState.getCountriesInit, true);
      expect(passportState.getCountriesInit, true);
    });
    test("setSelected works correctly", () {
      int index = 0;
      String passPortType = passportState.listPassportType.first.name;
      expect(passportState.travelers[index].passportInfo.passportType, null);
      passportController.setSelected(index, passPortType);
      expect(passportState.travelers[index].passportInfo.passportType, passPortType);
    });

    test("selectDateOfBirth works correctly", () {
      int index = 0;
      DateTime date = DateTime(1380, 2, 2);
      expect(passportState.travelers[index].passportInfo.dateOfBirth, null);
      passportController.selectDateOfBirth(index, date);
      expect(passportState.travelers[index].passportInfo.dateOfBirth, date);
    });

    group("getValueByType && getOnChangedValueByType work correctly", () {
      group("PassportType", () {
        test("passportType == null", () {
          int index = 0;
          expect(passportController.getValueByType(type: DropDownUtils.passportType, index: index), '');
        });

        test("passportType == DropDownUtils.passportType", () {
          int index = 0;
          passportController.getOnChangedValueByType(type: DropDownUtils.passportType, newValue: DropDownUtils.passportType, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.passportType, index: index), DropDownUtils.passportType);
        });

        test("passportType == Otherwise", () {
          int index = 0;
          String actualType = passportState.listPassportType.last.name;
          passportController.getOnChangedValueByType(type: DropDownUtils.passportType, newValue: actualType, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.passportType, index: index), actualType);
        });
      });

      group("nationality", () {
        test("nationality == null", () {
          int index = 0;
          expect(passportController.getValueByType(type: DropDownUtils.nationalityType, index: index), DropDownUtils.nationalityType);
        });
        test("nationality == DropDownUtils.nationalityType", () {
          int index = 0;
          String actualValue = DropDownUtils.nationalityType;
          passportController.getOnChangedValueByType(type: DropDownUtils.nationalityType, newValue: actualValue, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.nationalityType, index: index), actualValue);
        });

        test("nationality == Otherwise", () {
          int index = 0;
          String actualValue = passportState.nationalitiesList.last.englishName!;
          passportController.getOnChangedValueByType(type: DropDownUtils.nationalityType, newValue: actualValue, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.nationalityType, index: index), actualValue);
        });
      });

      group("countryOfIssueType", () {
        test("countryOfIssueType == null", () {
          int index = 0;
          expect(passportController.getValueByType(type: DropDownUtils.countryOfIssueType, index: index), DropDownUtils.countryOfIssueType);
        });
        test("countryOfIssueType == DropDownUtils.countryOfIssueType", () {
          int index = 0;
          String actualValue = DropDownUtils.countryOfIssueType;
          passportController.getOnChangedValueByType(type: DropDownUtils.countryOfIssueType, newValue: actualValue, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.countryOfIssueType, index: index), actualValue);
        });

        test("countryOfIssueType == Otherwise", () {
          int index = 0;
          String actualValue = passportState.nationalitiesList.last.englishName!;
          passportController.getOnChangedValueByType(type: DropDownUtils.countryOfIssueType, newValue: actualValue, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.countryOfIssueType, index: index), actualValue);
        });
      });

      group("Gender", () {
        test("Gender == null", () {
          int index = 0;
          expect(passportController.getValueByType(type: DropDownUtils.gender, index: index), DropDownUtils.gender);
        });
        test("Gender == DropDownUtils.Gender", () {
          int index = 0;
          String actualValue = DropDownUtils.gender;
          passportController.getOnChangedValueByType(type: DropDownUtils.gender, newValue: actualValue, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.gender, index: index), actualValue);
        });

        test("Gender == Male", () {
          int index = 0;
          String actualValue = "Male";
          passportController.getOnChangedValueByType(type: DropDownUtils.gender, newValue: actualValue, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.gender, index: index), actualValue);
        });

        test("Gender == Female", () {
          int index = 0;
          String actualValue = "Female";
          passportController.getOnChangedValueByType(type: DropDownUtils.gender, newValue: actualValue, index: index);
          expect(passportController.getValueByType(type: DropDownUtils.gender, index: index), actualValue);
        });
      });
    });
  });
}
