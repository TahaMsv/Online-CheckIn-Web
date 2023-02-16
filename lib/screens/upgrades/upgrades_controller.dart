import 'package:online_check_in/screens/upgrades/upgrades_repository.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';
import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';

import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';

class UpgradesController extends MainController {
  final UpgradesState upgradesState = getIt<UpgradesState>();
  final UpgradesRepository upgradesRepository = getIt<UpgradesRepository>();

  late GetExtrasUseCase getExtrasUseCase = GetExtrasUseCase(repository: upgradesRepository);

  void init() async {
    if (!upgradesState.isInitBefore) {
      upgradesState.setLoading(true);
      GetExtrasRequest getExtrasRequest = GetExtrasRequest();
      final fOrList = await getExtrasUseCase(request: getExtrasRequest);

      fOrList.fold((f) => FailureHandler.handle(f, retry: () => init()), (extras) async {
        for (var i = 0; i < extras.length; ++i) {
          if (extras[i].title.toLowerCase().contains("print")) {
            upgradesState.entertainmentsNumberOfSelected.add(0);
            upgradesState.entertainmentsList.add(extras[i]);
          } else {
            upgradesState.winesNumberOfSelected.add(0);
            upgradesState.winesList.add(extras[i]);
          }
        }
        print(upgradesState.entertainmentsList);
        print(upgradesState.winesList);
        upgradesState.setIsInitBefore(true);
      });
    }
    upgradesState.setLoading(false);
  }

  void addWine(int index) {
    upgradesState.winesNumberOfSelected[index]++;
    upgradesState.setState();
  }

  void removeWine(int index) {
    if (upgradesState.winesNumberOfSelected[index] > 0) {
      upgradesState.winesNumberOfSelected[index]--;
      upgradesState.setState();
    }
  }

  void addEntertainment(int index) {
    upgradesState.entertainmentsNumberOfSelected[index]++;
    upgradesState.setState();
  }

  void removeEntertainment(int index) {
    if (upgradesState.entertainmentsNumberOfSelected[index] > 0) {
      upgradesState.entertainmentsNumberOfSelected[index]--;
      upgradesState.setState();
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
