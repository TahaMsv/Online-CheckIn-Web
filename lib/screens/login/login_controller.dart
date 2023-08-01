import 'package:flutter/cupertino.dart';
import 'package:online_check_in/screens/Passport/passport_state.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/addTraveler/add_traveler_state.dart';
import 'package:online_check_in/screens/payment/payment_state.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';

import '../../core/constants/route_names.dart';
import 'package:online_check_in/initialize.dart';
import '../../core/interfaces/controller.dart';
import '../../core/navigation/route_names.dart';
import '../../core/utils/failure_handler.dart';
import '../../screens/login/login_repository.dart';
import '../steps/steps_controller.dart';
import '../steps/steps_state.dart';
import 'usecases/login_usecase.dart';
import 'login_state.dart';

class LoginController extends MainController {
  late LoginState loginState = ref.read(loginProvider);

  Future<void> login({required String username, required String password}) async {
    if (!loginState.requesting) {
      loginState.setRequesting(true);
      final StepsState stepsState = ref.read(stepsProvider);
      username = "test"; //lastNameC.text.trim();
      password = "9999999999"; // bookingRefNameC.text.trim();
      LoginRequest loginRequest = LoginRequest(
        password: password,
        username: username,
      );
      LoginUseCase loginUseCase = LoginUseCase(repository: LoginRepository());

      final fOrToken = await loginUseCase(request: loginRequest);

      fOrToken.fold((f) => FailureHandler.handle(f, retry: () => login(username: username, password: password)), (r) async {
        print(r.token);
        loginState.setToken(r.token);
        final StepsController stepsController = getIt<StepsController>();
        await stepsController.addToTravelers(token: r.token, lastName: username, ticketNumber: password, isLoginRequest: true);
        print("Here 43 at login");
      });
      loginState.setRequesting(false);
    }
  }

  void goToHome() async {
    // await init();
    nav.goNamed(RouteNames.login);
  }

  void clearAllStates() {
    final StepsState stepsState = ref.read(stepsProvider);;;

    stepsState.resetStepsState();
    final AddTravelerState addTravelerState = ref.read(addTravelerStateProvider);
    addTravelerState.resetAddTravelerState();
    final PassportState passportState = ref.read(passportProvider);
    passportState.resetPassportState();
    final PaymentState paymentState = ref.read(paymentProvider);
    paymentState.resetPaymentState();
    final ReceiptState receiptState = ref.read(receiptProvider);
    receiptState.resetReceiptState();
    final SeatMapState seatMapState = ref.read(seatMapProvider);
    seatMapState.resetSeatMapState();
    final UpgradesState upgradesState = ref.read(upgradesProvider);
    upgradesState.resetUpgradesState();
    final VisaState visaState = ref.read(visaProvider);
    visaState.resetVisaState();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearAllStates();
    });
    // clearAllStates();
  }
}
