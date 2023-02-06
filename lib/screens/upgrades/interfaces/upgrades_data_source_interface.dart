

import 'package:online_check_in/screens/upgrades/usecases/get_extras_usecase.dart';

import '../../../core/classes/extra.dart';

abstract class UpgradesDataSourceInterface{
  Future< List<Extra>> getExtras(GetExtrasRequest request);
}