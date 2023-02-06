import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:online_check_in/core/classes/flight_information.dart';
import 'package:online_check_in/core/constants/route_names.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/payment/payment_controller.dart';
import 'package:online_check_in/screens/seat_map/seat_map_controller.dart';
import 'package:online_check_in/screens/steps/steps_repository.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:online_check_in/screens/steps/usecases/get_flight_information_usecase.dart';
import 'package:flash/flash.dart';
import '../../core/classes/PassportInfo.dart';
import '../../core/classes/Traveler.dart';
import '../../core/classes/VisaInfo.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';
import '../../widgets/CustomFlutterWidget.dart';
import '../Passport/passport_controller.dart';
import '../login/login_state.dart';
import '../receipt/receipt_controller.dart';
import '../safety/safety_controller.dart';

class StepsController extends MainController {
  final StepsState stepsState = getIt<StepsState>();
  final StepsRepository stepsRepository = getIt<StepsRepository>();

  late GetFlightInformationUseCase getFlightInformationUseCase = GetFlightInformationUseCase(repository: stepsRepository);

  // Future<void> getFlightInformation(String token) async {}

  Future<void> addToTravelers(String token, String lastName, String ticketNumber) async {
    stepsState.setLoading(true);
    // await getFlightInformation(token);

    GetFlightInformationRequest getFlightInformationRequest = GetFlightInformationRequest();

    final fOrFlightInfo = await getFlightInformationUseCase(request: getFlightInformationRequest);
    print("30 at stepcontroller");
    fOrFlightInfo.fold((f) => FailureHandler.handle(f, retry: () => addToTravelers(token, lastName, ticketNumber)), (flightInformation) async {
      print("32 at stepcontroller");
      stepsState.setFlightInformation(flightInformation);
      if (stepsState.flightInformation != null) {
        print(stepsState.flightInformation!.passengers.last.id);
        print(stepsState.flightInformation!.passengers.last.name);
        for (int i = 0; i < stepsState.travelers.length; i++) {
          print(stepsState.travelers[i].flightInformation.passengers.last.id);
          print(stepsState.travelers[i].flightInformation.passengers.last.name);
          if (stepsState.travelers[i].flightInformation.passengers.last.id == stepsState.flightInformation!.passengers.last.id) {
            nav.snackbar(const Text("This passenger was added before", style: TextStyle(fontSize: 22)), backgroundColor: MyColors.red);
            stepsState.setLoading(false);
            return;
          }
        }
        Traveler traveler = Traveler(token: token, ticketNumber: ticketNumber, seatId: "--", flightInformation: stepsState.flightInformation!);
        traveler.setPassportInfo(PassportInfo());
        traveler.setVisaInfo(VisaInfo());
        stepsState.setIsDocsNecessary(true);
        stepsState.setIsDocoNecessary(true);
        stepsState.travelers.add(traveler);
        updateIsNextButtonDisable();
        changeTurnToSelect();
        nav.snackbar(
            const Text(
              "Traveller added successfuly",
              style: TextStyle(fontSize: 22),
            ),
            backgroundColor: MyColors.green);
        stepsState.setLoading(false);
      }
    });
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
    prepareNextButtonText();
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
      }
      if (isSuccessful) {
        if (step == 2 && stepsState.flightType == "d") {
          stepsState.setStep(step + 4);
          stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
        } else if (step == 2 && !stepsState.isDocsNecessary) {
          stepsState.setStep(step + 3);
          stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
        } else if (step == 3) {
          if (!stepsState.isDocoNecessary) {
            stepsState.setStep(step + 2);
            stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
          } else {
            stepsState.setStep(step + 1);
          }
        } else {
          stepsState.setStep(step + 1);
        }
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
    print("264 at decrease step");
    int step = stepsState.step;
    if (step > 0) {
      print("269 at decrease step");
      preparePreviousButtonText();
      if (step == 5) {
        print("272 at decrease step");
        if (!stepsState.isDocsNecessary) {
          print("274 at decrease step");
          stepsState.setStep(step - 3);
        } else if (!stepsState.isDocoNecessary) {
          print("277 at decrease step");
          stepsState.setStep(step - 2);
        } else {
          print("280 at decrease step");
          stepsState.setStep(step - 1);
        }
        print("283 at decrease step");
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      } else if (step == 6 && stepsState.flightType == "d") {
        print("286 at decrease step");
        stepsState.setStep(step - 4);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      } else {
        print("290 at decrease step");
        stepsState.setStep(step - 1);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      }
      print("294 at decrease step");
      print("step: ${stepsState.step}");
      updateIsNextButtonDisable();
      nav.pop();
    }
  }

  void changeStateOFAddingBox() {
    bool currState = stepsState.isAddingBoxOpen;
    stepsState.setIsAddingBoxOpen(!currState);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
