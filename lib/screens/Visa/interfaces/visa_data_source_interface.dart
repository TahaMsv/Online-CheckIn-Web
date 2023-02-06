
import 'package:online_check_in/core/classes/VisaType.dart';
import 'package:online_check_in/screens/Visa/usecases/select_visa_types_usecase.dart';

abstract class VisaDataSourceInterface{
  Future< List<VisaType>> selectVisaTypes(SelectVisaTypesRequest request);
}