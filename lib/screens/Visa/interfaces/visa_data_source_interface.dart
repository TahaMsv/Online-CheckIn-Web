
import 'package:online_checkin_web_refactoring/core/classes/VisaType.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/usecases/select_visa_types_usecase.dart';

abstract class VisaDataSourceInterface{
  Future< List<VisaType>> selectVisaTypes(SelectVisaTypesRequest request);
}