
import 'package:online_check_in/core/classes/visa_type.dart';
import 'package:online_check_in/screens/Visa/usecases/select_visa_types_usecase.dart';

abstract class VisaDataSourceInterface{
  Future< SelectVisaResponse> selectVisaTypes(SelectVisaTypesRequest request);
}