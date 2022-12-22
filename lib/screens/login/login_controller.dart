import 'package:flutter/cupertino.dart';

import '../../core/constants/route_names.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../screens/login/login_repository.dart';
import '../../utils/failure_handler.dart';
import '../steps/steps_cotroller.dart';
import '../steps/steps_state.dart';
import 'usecases/login_usecase.dart';
import 'login_state.dart';

class LoginController extends MainController {
  final LoginState loginState = getIt<LoginState>();

  // final StepsState stepsState = getIt<StepsState>();

  final LoginRepository loginRepository = getIt<LoginRepository>();

  late LoginUseCase loginUseCase = LoginUseCase(repository: loginRepository);

  @override
  void onCreate() {
    // loadPreferences();
  }

  void login(BuildContext context, {required String username, required String password}) async {
    final StepsState stepsState = getIt<StepsState>();
    username = "test"; //lastNameC.text.trim();
    password = "9999999999"; // bookingRefNameC.text.trim();
    stepsState.setLoading(true);
    LoginRequest loginRequest = LoginRequest(
      "[OnlineCheckin].[Authenticate]",
      null,
      {
        "Code": password,
        "Code2": username,
        "UrlType": 1,
      },
    );
    final fOrToken = await loginUseCase(request: loginRequest);

    fOrToken.fold((f) => FailureHandler.handle(f, retry: () => login(context,username: username, password: password)), (token) async {
      loginState.setToken(token);

      final StepsController stepsController = getIt<StepsController>();
      await stepsController.addToTravelers(context, token, username, password);
      // stepsState.setLoading(false);
      nav.goToName(RouteNames.addTraveler);
    });
    // stepsState.setLoading(false);
  }

  checkBoxesValidation() {}

  loginValidation() {}
}
