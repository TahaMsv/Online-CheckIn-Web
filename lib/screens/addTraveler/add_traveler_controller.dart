import 'package:online_checkin_web_refactoring/screens/addTraveler/usecases/add_traveler_usecase.dart';

import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';
import 'add_traveler_repository.dart';
import 'add_traveler_state.dart';
import 'package:flash/flash.dart';
import '../../widgets/CustomFlutterWidget.dart';
import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_controller.dart';
import '../login/login_state.dart';
import '../login/login_repository.dart';
import '../login/usecases/login_usecase.dart';

class AddTravelerController extends MainController {
  final AddTravelerState addTravelerState = getIt<AddTravelerState>();
  final AddTravelerRepository addTravelerRepository = getIt<AddTravelerRepository>();

  late AddTravelerUseCase addTravelerUseCase = AddTravelerUseCase(repository: addTravelerRepository);

  void addTraveller(BuildContext context) async {
    String lastName = addTravelerState.lastNameC.text;
    String ticketNumber = addTravelerState.ticketNumberC.text;
    if (ticketNumber == "") {
      // isTicketNumberEmpty.value = true;
      showFlash(
        context: context,
        duration: const Duration(seconds: 4),
        builder: (context, controller) {
          return CustomFlashBar(
            controller: controller,
            contentMessage: "Ticket Number can not be empty",
            titleMessage: "Error",
          );
        },
      );
    } else {
      addTravelerState.setIsTicketNumberEmpty(false);
    }
    if (lastName == "") {
      // isLastNameEmpty.value = true;
      showFlash(
        context: context,
        duration: const Duration(seconds: 4),
        builder: (context, controller) {
          return CustomFlashBar(
            controller: controller,
            contentMessage: "LastName can not be empty",
            titleMessage: "Error",
          );
        },
      );
    } else {
      addTravelerState.setIsLastNameEmpty(false);
    }
    if (ticketNumber != "" && lastName != "") {
      if (!addTravelerState.requesting) {
        addTravelerState.setRequesting(true);

        AddTravelerRequest addTravelerRequest = AddTravelerRequest(
          ticketNumber: ticketNumber,
          lastname: lastName,
        );

        String newToken = "";
        final fOrToken = await addTravelerUseCase(request: addTravelerRequest);
        fOrToken.fold((f) => FailureHandler.handle(f, retry: () => addTraveller(context)), (token) async {
          newToken = token;
        });

        if (newToken != "") {
          final StepsController stepsController = getIt<StepsController>();
          stepsController.addToTravelers(newToken, lastName, ticketNumber);
          addTravelerState.lastNameC.text = "";
          addTravelerState.ticketNumberC.text = "";
          addTravelerState.setIsTicketNumberEmpty(false);
          addTravelerState.setIsLastNameEmpty(false);
        } else {
          showFlash(
            context: context,
            duration: const Duration(seconds: 4),
            builder: (context, controller) {
              return CustomFlashBar(
                controller: controller,
                contentMessage: "Wrong LastName or Booking reference name",
                titleMessage: "Error",
              );
            },
          );
        }
        addTravelerState.setRequesting(false);
      }
      addTravelerState.setRequesting(false);
    }
  }

  @override
  void onCreate() {}
}
