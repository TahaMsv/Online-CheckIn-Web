import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/classes/passport_Info.dart';
import 'package:online_check_in/core/classes/traveler.dart';
import 'package:online_check_in/core/classes/visa_Info.dart';
import 'package:online_check_in/core/constants/my_json.dart';
import 'package:online_check_in/initialize.dart';
import 'package:online_check_in/core/utils/drop_down_utils.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/login/login_state.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import '../../init_test.dart';

void main() async {
  initTest();

  late LoginState loginState;
  late StepsState stepsState;
  late VisaController visaController;
  late VisaState visaState;
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
    stepsState = ref.read(stepsProvider);
    visaController = VisaController();
    visaState = ref.read(visaProvider);

    String token = MyJson.authenticateResJson["Body"]["Token"];
    loginState.setToken(token);

    ref.read(flightInformationProvider.notifier).state = FlightInformation.fromJson(flightInfoJson);
    addToTravelersMock(token: mockToken, lastName: "test", ticketNumber: "9999999999");

  });

  group("Visa controller", () {
    test("Visa controller init", () async {
      await visaController.visaInit();

      expect(visaState.visaInit, true);
    });

    test("selectDateOfBirth works correctly", () {
      int index = 0;
      DateTime date = DateTime(1380, 2, 2);
      expect(visaState.travelers[index].visaInfo.issueDate, null);
      visaController.selectEntryDate(index, date);
      expect(visaState.travelers[index].visaInfo.issueDate, date);
    });

    group("getValueByType && getOnChangedValueByType work correctly", () {
      group("VisaType", () {
        test("visaType == null", () {
          int index = 0;
          expect(visaController.getValueByType(type: DropDownUtils.visaType, index: index), DropDownUtils.visaType);
        });

        test("visaType == DropDownUtils.visaType", () {
          int index = 0;
          visaController.getOnChangedValueByType(type: DropDownUtils.visaType, newValue: DropDownUtils.visaType, index: index);
          expect(visaController.getValueByType(type: DropDownUtils.visaType, index: index), DropDownUtils.visaType);
        });

        test("visaType == Otherwise", () {
          int index = 0;
          String actualType = visaState.visaListType.last.name;
          visaController.getOnChangedValueByType(type: DropDownUtils.visaType, newValue: actualType, index: index);
          expect(visaController.getValueByType(type: DropDownUtils.visaType, index: index), actualType);
        });
      });

      group("placeOfIssue", () {
        test("placeOfIssue == null", () {
          int index = 0;
          expect(visaController.getValueByType(type: DropDownUtils.placeOfIssue, index: index), DropDownUtils.placeOfIssue);
        });
        test("placeOfIssue == DropDownUtils.placeOfIssue", () {
          int index = 0;
          String actualValue = DropDownUtils.placeOfIssue;
          visaController.getOnChangedValueByType(type: DropDownUtils.placeOfIssue, newValue: actualValue, index: index);
          expect(visaController.getValueByType(type: DropDownUtils.placeOfIssue, index: index), actualValue);
        });

        test("placeOfIssue == Otherwise", () {
          int index = 0;
          String actualValue = visaState.listIssuePlace.last.englishName!;
          visaController.getOnChangedValueByType(type: DropDownUtils.placeOfIssue, newValue: actualValue, index: index);
          expect(visaController.getValueByType(type: DropDownUtils.placeOfIssue, index: index), actualValue);
        });
      });
    });
  });
}
