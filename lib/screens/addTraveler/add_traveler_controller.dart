import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import 'add_traveler_repository.dart';
import 'add_traveler_state.dart';
import 'package:flash/flash.dart';
import '../../widgets/CustomFlutterWidget.dart';
import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_cotroller.dart';
import '../login/login_state.dart';
import '../login/login_repository.dart';
import '../login/usecases/login_usecase.dart';
import '../../utils/failure_handler.dart';

class AddTravelerController extends MainController {
  final AddTravelerState addTravelerState = getIt<AddTravelerState>();
  final AddTravelerRepository addTravelerRepository = getIt<AddTravelerRepository>();

  final LoginRepository loginRepository = getIt<LoginRepository>();

  //
  late LoginUseCase loginUseCase = LoginUseCase(repository: loginRepository);

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
      final LoginState loginState = getIt<LoginState>();
      String token = loginState.token!;

      if (!addTravelerState.requesting) {
        addTravelerState.setRequesting(true);

        LoginRequest loginRequest = LoginRequest(
          "[OnlineCheckin].[Authenticate]",
          token,
          {
            "Code": ticketNumber,
            "Code2": lastName,
            "UrlType": 1,
          },
        );
        String newToken = "";
        final fOrToken = await loginUseCase(request: loginRequest);
        fOrToken.fold((f) => FailureHandler.handle(f, retry: () => addTraveller(context)), (token) async {
          newToken = token;
        });

        if (newToken != "") {
          print("here 64");
          final StepsController stepsController = getIt<StepsController>();
          stepsController.addToTravelers(context, newToken, lastName, ticketNumber);
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
