import 'package:flutter/cupertino.dart';

import '../../core/constants/route_names.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';
import '../../screens/login/login_repository.dart';
import '../steps/steps_controller.dart';
import '../steps/steps_state.dart';
import 'usecases/login_usecase.dart';
import 'login_state.dart';

class LoginController extends MainController {
  final LoginState loginState = getIt<LoginState>();
  final LoginRepository loginRepository = getIt<LoginRepository>();

  late LoginUseCase loginUseCase = LoginUseCase(repository: loginRepository);

  @override
  void onCreate() {
    // loadPreferences();
  }

  void login({required String username, required String password}) async {
    if (!loginState.requesting) {
      loginState.setRequesting(true);
      final StepsState stepsState = getIt<StepsState>();
      username = "test"; //lastNameC.text.trim();
      password = "9999999999"; // bookingRefNameC.text.trim();
      stepsState.setLoading(true);
      LoginRequest loginRequest = LoginRequest(
        password: password,
        username: username,
      );
      final fOrToken = await loginUseCase(request: loginRequest);

      fOrToken.fold((f) => FailureHandler.handle(f, retry: () => login(username: username, password: password)), (token) async {
        loginState.setToken(token);
        print("Token: " + token);
        final StepsController stepsController = getIt<StepsController>();
        stepsController.addToTravelers(token, username, password);
        nav.goToName(RouteNames.addTraveler);
      });
    }
    loginState.setRequesting(false);
  }

  checkBoxesValidation() {}
}
