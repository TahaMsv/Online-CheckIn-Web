import 'package:flutter/cupertino.dart';
import 'package:online_checkin_web_refactoring/core/classes/flight_information.dart';
import 'package:online_checkin_web_refactoring/core/constants/route_names.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_repository.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/usecases/get_flight_information_usecase.dart';
import 'package:flash/flash.dart';
import '../../core/classes/PassportInfo.dart';
import '../../core/classes/Traveler.dart';
import '../../core/classes/VisaInfo.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../utils/failure_handler.dart';
import '../../widgets/CustomFlutterWidget.dart';
import '../login/login_state.dart';
import '../safety/safety_controller.dart';

class StepsController extends MainController {
  final StepsState stepsState = getIt<StepsState>();
  final StepsRepository stepsRepository = getIt<StepsRepository>();

  late GetFlightInformationUseCase getFlightInformationUseCase = GetFlightInformationUseCase(repository: stepsRepository);

  Future<FlightInformation?> getFlightInformation(String token) async {
    GetFlightInformationRequest getFlightInformationRequest = GetFlightInformationRequest(
      "[OnlineCheckin].[SelectFlightInformation]",
      token,
      {},
    );
    final fOrFlightInfo = await getFlightInformationUseCase(request: getFlightInformationRequest);

    fOrFlightInfo.fold((f) => FailureHandler.handle(f, retry: () => getFlightInformation(token)), (flightInformation) async {
      stepsState.setFlightInformation(flightInformation);
      return flightInformation;
    });
    return null;
  }

  Future<void> addToTravelers(BuildContext context, String token, String lastName, String ticketNumber) async {
    stepsState.setLoading(true);
    await getFlightInformation(token);

    for (int i = 0; i < stepsState.travelers.length; i++) {
      if (stepsState.travelers[i].flightInformation.passengers[0].id == stepsState.flightInformation!.passengers[0].id) {
        showFlash(
          context: context,
          duration: const Duration(seconds: 4),
          builder: (context, controller) {
            return CustomFlashBar(
              controller: controller,
              // contentMessage: "This passenger was added before".tr, //todo
              contentMessage: "This passenger was added before",
              // titleMessage: "Duplicate Traveler".tr,  // todo
              titleMessage: "Duplicate Traveler",
            );
          },
        );
        stepsState.setLoading(false);
        return;
      }
    }
    Traveler traveler = Traveler(token: token, ticketNumber: ticketNumber, seatId: "--", flightInformation: stepsState.flightInformation!);
    traveler.setPassportInfo(PassportInfo());
    traveler.setVisaInfo(VisaInfo());

    // stepsState.flightInformation!.flight[0].checkDocs == 1 && stepsState.flightType == "i" ? stepsState.setIsDocsnecessary(true) : stepsState.setIsDocsnecessary(false);
    // stepsState.flightType == "i" ? stepsState.setIsDocsnecessary(true) : stepsState.setIsDocsnecessary(false); //todo
    stepsState.setIsDocsnecessary(true);
    stepsState.travelers.add(traveler);
    // print(jsonEncode(Traveler.toJson()));
    updateIsNextButtonDisable();
    changeTurnToSelect();
    stepsState.setLoading(false);
  }

  void removeFromTravelers(int index) {
    if (index < stepsState.travelers.length && index >= 0) {
      stepsState.travelers.removeAt(index);
    }
    updateIsNextButtonDisable();
  }

  void updateIsNextButtonDisable() {
    int step = stepsState.step;
    if (step == 0) {
      stepsState.setIsNextButtonEnable(stepsState.travelers.length != 0);
      return;
    } else if (step == 1) {
      final SafetyController safetyController = getIt<SafetyController>();
      stepsState.setIsNextButtonEnable(safetyController.checkValidation());
      return;
    } else if (step == 6) {
      // for (int i = 0; i < travellers.length; i++) { //todo
      //   if (travellers[i].seatId == "--") {
      //     setNextButton(false);
      //     return;
      //   }
      // }
      // setNextButton(true);
      return;
    } else if (step == 7) {
      // PaymentStepController paymentStepController = Get.put(PaymentStepController(model));
    }
    stepsState.setIsNextButtonEnable(true);
    // else if (step == 8) {}
  }

  void changeTurnToSelect() {
    for (int i = 0; i < stepsState.travelers.length; i++) {
      if (stepsState.travelers[i].seatId == "--") {
        stepsState.setwhoseTurnToSelect(i);
        return;
      }
    }

    stepsState.setwhoseTurnToSelect(-1);
  }

  bool isStepNeeded(int index) {
    if (index == 3 && !stepsState.isDocsNecessary) return false;
    if (index == 4 && !stepsState.isDocsNecessary) return false;
    if (index == 4 && !stepsState.isDocoNecessary) return false;
    if (index == 5 && stepsState.flightType == "d") return false;
    return true;
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
    print("here at setstep");
    int step = stepsState.step;
    if (step < 8) {
      if (step == 6) {
        // SeatsStepController seatsStepController = Get.put(SeatsStepController(model)); // todo
        // if (!model.requesting) {
        //   isSuccessful = await seatsStepController.clickOnSeat();
        // }
      } else if (step == 7) {
        // ReceiptStepController receiptStepController = Get.put(ReceiptStepController(model)); // todo
        // if (!model.requesting) {
        //   isSuccessful = await receiptStepController.finalReserve();
        // }
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
          }
        } else {
          stepsState.setStep(step + 1);
        }
        navigateToStep(stepsState.step);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);

      }
    }
  }

  void navigateToStep(int step) {
    switch (step) {
      case 0:
        nav.goToName(RouteNames.addTraveler);
        break;
      case 1:
        nav.goToName(RouteNames.safety);
        break;
      case 2:
        nav.goToName(RouteNames.rules);
        break;
      case 3:
        nav.goToName(RouteNames.passport);
        break;
      case 4:
        nav.goToName(RouteNames.visa);
        break;
      case 5:
        nav.goToName(RouteNames.upgrades);
        break;
      case 6:
        nav.goToName(RouteNames.seats);
        break;
      case 7:
        nav.goToName(RouteNames.payment);
        break;
      case 8:
        nav.goToName(RouteNames.receipt);
        break;
    }
  }

  void decreaseStep() async {
    int step = stepsState.step;
    if (step > 0) {
      preparePreviousButtonText();
      if (step == 5) {
        if (!stepsState.isDocsNecessary) {
          stepsState.setStep(step - 3);
          stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
        } else if (!stepsState.isDocoNecessary) {
          stepsState.setStep(step - 2);
          stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
        }
      } else if (step == 6 && stepsState.flightType == "d") {
        stepsState.setStep(step - 4);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      } else {
        stepsState.setStep(step - 1);
        stepsState.setCurrButtonTextIndex(stepsState.nextButtonTextIndex);
      }
      navigateToStep(stepsState.step);
    }
  }

  void changeStateOFAddingBox() {
    bool currState = stepsState.isAddingBoxOpen;
    stepsState.setIsAddingBoxOpen(!currState);
  }

  @override
  void onCreate() {}
}
