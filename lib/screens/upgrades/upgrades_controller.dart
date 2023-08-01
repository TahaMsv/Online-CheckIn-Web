import 'package:online_check_in/screens/upgrades/upgrades_repository.dart';
import 'package:online_check_in/screens/upgrades/upgrades_state.dart';
import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';

import 'package:online_check_in/initialize.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/failure_handler.dart';

class UpgradesController extends MainController {
  late UpgradesState upgradesState = ref.read(upgradesProvider);

  Future<bool> init() async {
    print(upgradesState.isInitBefore);
    if (!upgradesState.isInitBefore) {
      upgradesState.setLoading(true);
      GetExtrasRequest getExtrasRequest = GetExtrasRequest();
      GetExtrasUseCase getExtrasUseCase = GetExtrasUseCase(repository: UpgradesRepository());

      final fOrList = await getExtrasUseCase(request: getExtrasRequest);
      fOrList.fold((f) => FailureHandler.handle(f, retry: () => init()), (r) async {
        // print(r.extras);
        for (var i = 0; i < r.extras.length; ++i) {
          print(r.extras[i].title);
          if (r.extras[i].title.toLowerCase().contains("print")) {
            upgradesState.entertainmentsNumberOfSelected.add(0);
            ref.read(entertainmentsListProvider.notifier).state!.add(r.extras[i]);
          } else {
            upgradesState.winesNumberOfSelected.add(0);

            // upgradesState.winesList.add(r.extras[i]);
            ref.read(winesListProvider.notifier).state!.add(r.extras[i]);
          }
        }
        upgradesState.setIsInitBefore(true);
      });
    }
    upgradesState.setLoading(false);
    return upgradesState.isInitBefore;
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
    // TODO: implement onInit
    init();
    super.onInit();
  }
}
