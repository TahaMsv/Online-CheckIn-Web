import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/addTraveler/usecases/add_traveler_usecase.dart';
import 'package:provider/provider.dart';

import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/interfaces/controller.dart';
import '../../core/platform/device_info.dart';
import '../../core/utils/failure_handler.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/UserTextInput.dart';
import '../Passport/passport_controller.dart';
import '../Visa/visa_controller.dart';
import '../steps/steps_state.dart';
import 'add_traveler_repository.dart';
import 'add_traveler_state.dart';
import 'package:flash/flash.dart';
import '../../widgets/CustomFlutterWidget.dart';
import 'package:flutter/material.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import '../login/login_state.dart';
import '../login/login_repository.dart';
import '../login/usecases/login_usecase.dart';

class AddTravelerController extends MainController {
  late AddTravelerState addTravelerState = ref.read(addTravelerStateProvider);

  void addTraveller(BuildContext context) async {
    String lastName = addTravelerState.lastNameC.text;
    String ticketNumber = addTravelerState.ticketNumberC.text;
    if (!addTravelerState.loading) {
      addTravelerState.setLoading(true);
      if (ticketNumber == "") {
        // isTicketNumberEmpty.value = true;
        nav.snackbar(
          Text(
            "Ticket Number can not be empty".translate(context),
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: MyColors.red,
        );
      } else {
        addTravelerState.setIsTicketNumberEmpty(false);
      }
      if (lastName == "") {
        // isLastNameEmpty.value = true;
        nav.snackbar(
            Text(
              "LastName can not be empty".translate(context),
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: MyColors.red);
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
          AddTravelerUseCase addTravelerUseCase = AddTravelerUseCase(repository: AddTravelerRepository());

          final fOrToken = await addTravelerUseCase(request: addTravelerRequest);
          fOrToken.fold((f) => FailureHandler.handle(f, retry: () => addTraveller(context)), (r) async {
            newToken = r.token;
          });

          if (newToken != "") {
            final StepsController stepsController = getIt<StepsController>();
            stepsController.addToTravelers(token: newToken, lastName: lastName, ticketNumber: ticketNumber, isLoginRequest: false);
            addTravelerState.lastNameC.text = "";
            addTravelerState.ticketNumberC.text = "";
            addTravelerState.setIsTicketNumberEmpty(false);
            addTravelerState.setIsLastNameEmpty(false);
          }
          addTravelerState.setRequesting(false);
        }
        addTravelerState.setRequesting(false);
      }
    }
    addTravelerState.setLoading(false);
  }

  // void showAddTravelerBottomSheet(BuildContext context, double height, double width, double keyboardSize) {
  //   double fontSize = 16;
  //
  //   print("keyboardSize: " + keyboardSize.toString());
  //   DeviceType deviceType = DeviceInfo.deviceType(context);
  //   showModalBottomSheet(
  //       context: context,
  //       backgroundColor: Colors.white,
  //       isScrollControlled: true,
  //       constraints: BoxConstraints(
  //         maxWidth: width * 0.9,
  //       ),
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //       ),
  //       builder: (context) {
  //         StepsState stepsState = ref.read(stepsProvider);
  //         return Container(
  //           margin: EdgeInsets.only(bottom: keyboardSize),
  //           height: height * 0.3,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //             // color: Colors.red,
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               SizedBox(height: deviceType.isPhone ? 5 : 15),
  //               Text(
  //                 "Add all passengers to the list on the left here".translate(context),
  //                 style: deviceType.isPhone ? MyTextTheme.lightGrey14 : MyTextTheme.lightGrey20,
  //               ),
  //               SizedBox(height: deviceType.isPhone ? 10 : 15),
  //               UserTextInput(
  //                 height: deviceType.isPhone ? 40 : 63,
  //                 width: width * 0.7,
  //                 fontSize: deviceType.isPhone ? 17 : 22,
  //                 controller: addTravelerState.lastNameC,
  //                 hint: "Last Name".translate(context),
  //                 errorText: "Last Name can't be empty".translate(context),
  //                 isEmpty: addTravelerState.isLastNameEmpty,
  //               ),
  //               SizedBox(height: deviceType.isPhone ? 5 : 10),
  //               UserTextInput(
  //                 height: deviceType.isPhone ? 40 : 63,
  //                 width: width * 0.7,
  //                 fontSize: deviceType.isPhone ? 17 : 22,
  //                 controller: addTravelerState.ticketNumberC,
  //                 hint: "Reservation ID / Ticket Number".translate(context),
  //                 errorText: "Reservation ID / Ticket Number can't be empty".translate(context),
  //                 isEmpty: addTravelerState.isTicketNumberEmpty,
  //                 obscureText: true,
  //               ),
  //               SizedBox(height: deviceType.isPhone ? 10 : 25),
  //               Center(
  //                 child: MyElevatedButton(
  //                   height: deviceType.isPhone ? 35 : 50,
  //                   width: deviceType.isPhone
  //                       ? 200
  //                       : deviceType.isTablet
  //                           ? 250
  //                           : double.infinity,
  //                   buttonText: "Add to Travellers",
  //                   bgColor: const Color(0xff00bfa2),
  //                   fgColor: Colors.white,
  //                   fontSize: deviceType.isPhone ? 17 : 22,
  //                   isLoading: addTravelerState.requesting || stepsState.stepLoading,
  //                   function: () async {
  //                     addTraveller(context);
  //                   },
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
  void showAddTravelerBottomSheet(BuildContext context, double height, double width, double keyboardSize) {
    double fontSize = 16;

    print("keyboardSize: " + keyboardSize.toString());
    DeviceType deviceType = DeviceInfo.deviceType(context);
    showDialog(
        context: context,
        // backgroundColor: Colors.white,
        // isScrollControlled: true,
        // constraints: BoxConstraints(
        //   maxWidth: width * 0.9,
        // ),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
        // ),
        builder: (context) {
          StepsState stepsState = ref.read(stepsProvider);
          return AlertDialog(
            content: Container(
              margin: EdgeInsets.only(bottom: keyboardSize),
              height: height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                // color: Colors.red,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: deviceType.isPhone ? 5 : 15),
                  Text(
                    "Add all passengers to the list on the left here".translate(context),
                    style: deviceType.isPhone ? MyTextTheme.lightGrey14 : MyTextTheme.lightGrey20,
                  ),
                  SizedBox(height: deviceType.isPhone ? 10 : 15),
                  UserTextInput(
                    height: deviceType.isPhone ? 40 : 63,
                    width: width * 0.7,
                    fontSize: deviceType.isPhone ? 17 : 22,
                    controller: addTravelerState.lastNameC,
                    hint: "Last Name".translate(context),
                    errorText: "Last Name can't be empty".translate(context),
                    isEmpty: addTravelerState.isLastNameEmpty,
                  ),
                  SizedBox(height: deviceType.isPhone ? 5 : 10),
                  UserTextInput(
                    height: deviceType.isPhone ? 40 : 63,
                    width: width * 0.7,
                    fontSize: deviceType.isPhone ? 17 : 22,
                    controller: addTravelerState.ticketNumberC,
                    hint: "Reservation ID / Ticket Number".translate(context),
                    errorText: "Reservation ID / Ticket Number can't be empty".translate(context),
                    isEmpty: addTravelerState.isTicketNumberEmpty,
                    obscureText: true,
                  ),
                  SizedBox(height: deviceType.isPhone ? 10 : 25),
                  Center(
                    child: MyElevatedButton(
                      height: deviceType.isPhone ? 35 : 50,
                      width: deviceType.isPhone
                          ? 200
                          : deviceType.isTablet
                              ? 250
                              : double.infinity,
                      buttonText: "Add to Travellers",
                      bgColor: const Color(0xff00bfa2),
                      fgColor: Colors.white,
                      fontSize: deviceType.isPhone ? 17 : 22,
                      isLoading: addTravelerState.requesting || stepsState.stepLoading,
                      function: () async {
                        addTraveller(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

// @override
// void onInit() {
//   print("add traveler init 310");
//   final PassportController passportController = getIt<PassportController>();
//   final VisaController visaController = getIt<VisaController>();
//   passportController.initPassportScreen();
//   visaController.initVisaController();
//   print("add traveler init 315");
//   super.onInit();
// }
}
