import 'package:online_check_in/core/dependency_injection.dart';
import 'package:online_check_in/screens/Passport/passport_controller.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';

import '../../screens/Passport/passport_state.dart';
import '../../screens/Visa/visa_state.dart';
import 'getTranslatedWord.dart';

class DropDownUtils {
  DropDownUtils._();

  static String passportType = "Passport Type";
  static String nationalityType = "Nationality";
  static String countryOfIssueType = "Country of Issue";
  static String gender = "Gender";

  static String visaType = "Type";
  static String placeOfIssue = "Place of issue";

  static String passport = "Passport";
  static String visa = "Visa";

}
