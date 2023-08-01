import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/classes/seat_map.dart';
import 'package:online_check_in/core/constants/route_names.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/payment/payment_controller.dart';
import 'package:online_check_in/screens/seat_map/seat_map_controller.dart';
import 'package:online_check_in/screens/steps/steps_repository.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:online_check_in/screens/steps/usecases/get_flight_information_usecase.dart';
import 'package:flash/flash.dart';
import 'package:online_check_in/screens/upgrades/upgrades_controller.dart';
import '../../core/classes/passport_Info.dart';
import '../../core/classes/traveler.dart';
import '../../core/classes/visa_Info.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/interfaces/controller.dart';
import '../../core/navigation/route_names.dart';
import '../../core/platform/device_info.dart';
import '../../core/platform/running_mode_info.dart';
import '../../core/utils/failure_handler.dart';
import '../../widgets/CustomFlutterWidget.dart';
import '../Passport/passport_controller.dart';
import '../login/login_state.dart';
import '../receipt/receipt_controller.dart';
import '../safety/safety_controller.dart';

class StepsController extends MainController {
  late StepsState stepsState = ref.read(stepsProvider);

  // Future<void> getFlightInformation(String token) async {}

  Future<void> addToTravelers({context, token, lastName, ticketNumber, isLoginRequest}) async {
    final LoginState loginState = ref.read(loginProvider);
    stepsState.setLoading(true);

    GetFlightInformationRequest getFlightInformationRequest = GetFlightInformationRequest();
    GetFlightInformationUseCase getFlightInformationUseCase = GetFlightInformationUseCase(repository: StepsRepository());

    final fOrFlightInfo = await getFlightInformationUseCase(request: getFlightInformationRequest);
    fOrFlightInfo.fold((f) => FailureHandler.handle(f, retry: () => addToTravelers(context: context, token: token, lastName: lastName, ticketNumber: ticketNumber, isLoginRequest: isLoginRequest)),
        (r) async {
      ref.read(flightInformationProvider.notifier).state = r.flightInformation;
      // stepsState.setFlightInformation(r.flightInformation);
      FlightInformation currFI = ref.read(flightInformationProvider)!;
      if (currFI != null) {
        for (int i = 0; i < stepsState.travelers.length; i++) {
          if (!RunningModeInfo.runningType().isTest && stepsState.travelers[i].flightInformation.passengers.last.id == currFI!.passengers.last.id) {
            nav.snackbar(Text("This passenger was added before".translate(context), style: TextStyle(fontSize: 18)), backgroundColor: MyColors.red);
            stepsState.setLoading(false);
            return;
          }
        }
        Traveler traveler = Traveler(token: token, ticketNumber: ticketNumber, seatId: "--", flightInformation: currFI!);
        traveler.setPassportInfo(PassportInfo());
        traveler.setVisaInfo(VisaInfo());
        stepsState.setIsDocsNecessary(true);
        stepsState.setIsDocoNecessary(true);
        stepsState.travelers.add(traveler);
        updateIsNextButtonDisable();
        changeTurnToSelect();
        print("steps c 66");
        if (RunningModeInfo.runningType().isTest) return;
        print("steps c 68");
        if (isLoginRequest) {
          print("steps c 70");
          nav.goNamed(RouteNames.addTraveler);
        } else {
          nav.popDialog();
        }
        nav.snackbar(
            Text(
              "Traveler added successfully".translate(context),
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: MyColors.green);
        stepsState.setLoading(false);
      }
      stepsState.setLoading(false);
    });
    stepsState.setLoading(false);
    loginState.setRequesting(false);
  }

  void removeFromTravelers(int index) {
    if (index < stepsState.travelers.length && index >= 0) {
      stepsState.travelers.removeAt(index);
    }
    updateIsNextButtonDisable();
  }

  int findTravellerIndexBySeatId(String seatId) {
    for (int i = 0; i < stepsState.travelers.length; i++) {
      if (stepsState.travelers[i].seatId == seatId) {
        return i;
      }
    }
    return -1;
  }

  void updateIsNextButtonDisable() {
    int step = stepsState.step;
    if (step == 0) {
      stepsState.setIsNextButtonEnable(stepsState.travelers.isNotEmpty);
      return;
    } else if (step == 1) {
      final SafetyController safetyController = getIt<SafetyController>();
      stepsState.setIsNextButtonEnable(safetyController.checkValidation());
      return;
    } else if (step == 6) {
      for (int i = 0; i < stepsState.travelers.length; i++) {
        if (stepsState.travelers[i].seatId == "--") {
          stepsState.setIsNextButtonEnable(false);
          return;
        }
      }
      stepsState.setIsNextButtonEnable(true);
      return;
    }
    stepsState.setIsNextButtonEnable(true);
    // else if (step == 8) {}
  }

  void changeTurnToSelect() {
    print("changeTurnToSelect");
    for (int i = 0; i < stepsState.travelers.length; i++) {
      if (stepsState.travelers[i].seatId == "--") {
        print(i);
        stepsState.setWhoseTurnToSelect(i);
        return;
      }
    }
    print(-1);
    stepsState.setWhoseTurnToSelect(-1);
  }

  bool isStepNeeded(int index) {
    if (index == 1) return false;
    if (index == 3 && !stepsState.isDocsNecessary) return false;
    if (index == 4 && !stepsState.isDocsNecessary) return false;
    if (index == 4 && !stepsState.isDocoNecessary) return false;
    if (index == 5 && stepsState.flightType == "d") return false;
    return true;
  }

  List<int> stepsToShowList() {
    List<int> list = [];
    for (int i = 0; i <= 8; i++) {
      if (isStepNeeded(i)) {
        list.add(i);
      }
    }
    return list;
  }

  void preparePreviousButtonText() {
    int step = stepsState.step;
    if (step == 2) {
      if (stepsState.flightType == "d") {
        stepsState.setNextButtonTextIndex(stepsState.nextButtonTextIndex - 4);
        return;
      }
      if (!stepsState.isDocsNecessary) {
        stepsState.setNextButtonTextIndex(stepsState.nextButtonTextIndex - 3);
        return;
      }
    }
    if (step == 3) {
      if (!stepsState.isDocoNecessary) {
        stepsState.setNextButtonTextIndex(stepsState.nextButtonTextIndex - 2);
        return;
      }
    }
    // else if (step == 5) {
    //   if (!stepsState.isDocsNecessary) {
    //     nextButtonTextIndex -= 3;
    //     return;
    //   }
    //   if (!isDocoNecessary.value) {
    //     nextButtonTextIndex -= 2;
    //     return;
    //   }
    // }
    stepsState.setNextButtonTextIndex(stepsState.nextButtonTextIndex - 1);
  }

  void prepareNextButtonText() {
    int step = stepsState.step;
    if (step == 1 && !stepsState.isDocsNecessary) {
      stepsState.setNextButtonTextIndex(4);
      if (stepsState.flightType == "i") return;
    } else if (step == 2) {
      if (stepsState.isDocsNecessary && !stepsState.isDocoNecessary) {
        stepsState.setNextButtonTextIndex(stepsState.nextButtonTextIndex + 2);
        return;
      }
    }
    stepsState.setNextButtonTextIndex(stepsState.nextButtonTextIndex + 1);
    if (stepsState.nextButtonTextIndex == 4 && stepsState.flightType == "d") {
      stepsState.setNextButtonTextIndex(stepsState.nextButtonTextIndex + 1);
    }
  }

  void increaseStep() async {
    bool isSuccessful = true;
    if (kDebugMode) {
      print("here at setstep");
    }
    int step = stepsState.step;
    if (step < 8) {
      if (step == 6) {
        final SeatMapController seatMapController = getIt<SeatMapController>();
        isSuccessful = await seatMapController.clickOnSeat();
      } else if (step == 7) {
        final ReceiptController receiptController = getIt<ReceiptController>();
        isSuccessful = await receiptController.finalReserve();
        if (isSuccessful) {
          isSuccessful = await receiptController.getBoardingPassPDF();
        }
      }
      if (isSuccessful) {
        if (step == 2 && stepsState.flightType == "d") {
          stepsState.setStep(step + 4);
          stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
        } else if (step == 2 && !stepsState.isDocsNecessary) {
          stepsState.setStep(step + 3);
          stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
        } else if (step == 2 && stepsState.isDocsNecessary) {
          final PassportController passportController = getIt<PassportController>();
          isSuccessful = await passportController.passportInit();
          if (!isSuccessful) return;
          stepsState.setStep(step + 1);
        } else if (step == 3) {
          if (!stepsState.isDocoNecessary) {
            stepsState.setStep(step + 2);
            stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
          } else {
            print("231 at increase");
            final VisaController visaController = getIt<VisaController>();
            isSuccessful = await visaController.visaInit();
            print(isSuccessful);
            if (!isSuccessful) return;
            print("236 at increase");
            stepsState.setStep(step + 1);
          }
        } else if (step == 4) {
          final UpgradesController upgradesController = getIt<UpgradesController>();
          isSuccessful = await upgradesController.init();
          if (!isSuccessful) return;
          stepsState.setStep(step + 1);
        } else if (step == 5) {
          final SeatMapController seatMapController = getIt<SeatMapController>();
          isSuccessful = await seatMapController.init();
          if (!isSuccessful) return;
          stepsState.setStep(step + 1);
        } else if (step == 0) {
          stepsState.setStep(step + 2);
        } else {
          print("240 at increase");
          stepsState.setStep(step + 1);
        }
        print("243 at increase");
        print(stepsState.step);
        prepareNextButtonText();
        navigateToStep(stepsState.step);
        updateIsNextButtonDisable();
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      }
    }
  }

  void navigateToStep(int step) {
    if (kDebugMode) {
      print("Go to step: $step");
    }
    switch (step) {
      case 0:
        nav.pushNamed(RouteNames.addTraveler);
        break;
      case 1:
        nav.pushNamed(RouteNames.safety);
        break;
      case 2:
        nav.pushNamed(RouteNames.rules);
        break;
      case 3:
        nav.pushNamed(RouteNames.passport);
        break;
      case 4:
        nav.pushNamed(RouteNames.visa);
        break;
      case 5:
        nav.pushNamed(RouteNames.upgrades);
        break;
      case 6:
        nav.pushNamed(RouteNames.seatMap);
        break;
      case 7:
        nav.pushNamed(RouteNames.payment);
        break;
      case 8:
        nav.pushNamed(RouteNames.receipt);
        break;
    }

    updateIsNextButtonDisable();
  }

  void decreaseStep() async {
    int step = stepsState.step;
    if (step > 0) {
      preparePreviousButtonText();
      if (step == 5) {
        if (!stepsState.isDocsNecessary) {
          stepsState.setStep(step - 3);
        } else if (!stepsState.isDocoNecessary) {
          stepsState.setStep(step - 2);
        } else {
          stepsState.setStep(step - 1);
        }
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      } else if (step == 6 && stepsState.flightType == "d") {
        stepsState.setStep(step - 4);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      } else if (step == 2) {
        stepsState.setStep(step - 2);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      } else {
        stepsState.setStep(step - 1);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      }
      print("step: ${stepsState.step}");
      updateIsNextButtonDisable();
      nav.pop();
    }
  }

  void changeStateOFAddingBox() {
    bool currState = stepsState.isAddingBoxOpen;
    stepsState.setIsAddingBoxOpen(!currState);
  }
}
