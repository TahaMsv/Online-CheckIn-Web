

import 'package:online_checkin_web_refactoring/screens/upgrades/usecases/get_extras_usecase.dart';

import '../../../core/classes/extra.dart';

abstract class UpgradesDataSourceInterface{
  Future< List<Extra>> getExtras(GetExtrasRequest request);
}