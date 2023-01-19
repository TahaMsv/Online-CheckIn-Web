import 'package:online_checkin_web_refactoring/screens/login/login_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/upgrades_repository.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/upgrades_state.dart';
import 'package:online_checkin_web_refactoring/screens/upgrades/usecases/get_extras_usecase.dart';

import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';


class UpgradesController extends MainController {
  final UpgradesState upgradesState = getIt<UpgradesState>();
  final LoginState loginState = getIt<LoginState>();

  final UpgradesRepository upgradesRepository = getIt<UpgradesRepository>();

  late GetExtrasUseCase getExtrasUseCase = GetExtrasUseCase(repository: upgradesRepository);

  void init() async {
    print('in init17');
    final StepsState stepsState = getIt<StepsState>();
    // if (!upgradesState.requesting) {
    //   upgradesState.setRequesting(true);
    print('in init 21');


    print('before token: ' );
    print( loginState.token);
    print('after token: ' );
    GetExtrasRequest getExtrasRequest = GetExtrasRequest(
      "[OnlineCheckin].[SelectSeatExtras]",
     loginState.token,
      {},
    );
    print("here26");

    final fOrList = await getExtrasUseCase(request: getExtrasRequest);
    print("here29");
    print("fOrList: " + fOrList.toString());
    fOrList.fold((f) => FailureHandler.handle(f, retry: () => init()), (extras) async {
      print("extras: " + extras.toString());
      for (var i = 0; i < extras.length - 1; ++i) {
        upgradesState.winesNumberOfSelected.add(0);
      }
      upgradesState.entertainmentsNumberOfSelected.add(0);
      for (var i = 0; i < extras.length; ++i) {
        if (i == extras.length - 1) {
          upgradesState.entertainmentsList.add(extras[i]);
          // print("here1");
        } else {
          upgradesState.winesList.add(extras[i]);
          // print("here2");
        }
      }
      // upgradesState.loading.value = true;
    });
    // }
    // upgradesState.setRequesting(false);
  }

  void addWine(int index) {
    upgradesState.winesNumberOfSelected[index]++;
    upgradesState.refresh();
  }

  void removeWine(int index) {
    if (upgradesState.winesNumberOfSelected[index] > 0) {
      upgradesState.winesNumberOfSelected[index]--;
      upgradesState.refresh();
    }
  }

  void addEntertainment(int index) {
    upgradesState.entertainmentsNumberOfSelected[index]++;
    upgradesState.refresh();
  }

  void removeEntertainment(int index) {
    if (upgradesState.entertainmentsNumberOfSelected[index] > 0) {
      upgradesState.entertainmentsNumberOfSelected[index]--;
      upgradesState.entertainmentsNumberOfSelected.refresh();
    }
  }

  @override
  void onCreate() {

  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
