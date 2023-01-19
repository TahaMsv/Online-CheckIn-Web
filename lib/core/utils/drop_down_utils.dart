import 'package:online_checkin_web_refactoring/core/dependency_injection.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_controller.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_controller.dart';

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

  static PassportController passportController = getIt<PassportController>();
  static PassportState passportState = getIt<PassportState>();

  static VisaController visaController = getIt<VisaController>();
  static VisaState visaState = getIt<VisaState>();

  static String? getValueByType({required passOrVisa, required String type, required int index}) {
    String? returnValue;
    if (passOrVisa == passport) {
      if (type == passportType) {
        returnValue = passportState.travelers[index].passportInfo.passportType == null || passportState.travelers[index].passportInfo.passportType == passportType
            ? passportType
            : passportState.travelers[index].passportInfo.passportType;
      } else if (type == nationalityType) {
        returnValue = passportState.travelers[index].passportInfo.nationality == null || passportState.travelers[index].passportInfo.nationality == nationalityType
            ? nationalityType
            : passportState.travelers[index].passportInfo.nationality;
      } else if (type == countryOfIssueType) {
        returnValue = passportState.travelers[index].passportInfo.countryOfIssue == null || passportState.travelers[index].passportInfo.countryOfIssue == countryOfIssueType
            ? countryOfIssueType
            : passportState.travelers[index].passportInfo.countryOfIssue;
      } else if (type == gender) {
        returnValue =
            passportState.travelers[index].passportInfo.gender == null || passportState.travelers[index].passportInfo.gender == gender ? gender : passportState.travelers[index].passportInfo.gender!;
      }
      passportController.refreshList(index);
    } else {
      if (type == placeOfIssue) {
        visaState.travelers[index].visaInfo.placeOfIssue == null || visaState.travelers[index].visaInfo.placeOfIssue == placeOfIssue ? placeOfIssue : visaState.travelers[index].visaInfo.placeOfIssue;
      } else if (type == visaType) {
        returnValue = visaState.travelers[index].visaInfo.type == null || visaState.travelers[index].visaInfo.type == visaType ? visaType : visaState.travelers[index].visaInfo.type;
      }
      visaController.refreshList(index);
    }
    return returnValue;
  }

  static void getOnChangedValueByType({required passOrVisa, required String type, required dynamic newValue, required int index}) {
    String translatedWord = getKeyFromLanguageWords(newValue.toString());
    if (passOrVisa == passport) {
      if (type == passportType) {
        passportState.travelers[index].passportInfo.passportType = translatedWord;
      } else if (type == nationalityType) {
        passportState.travelers[index].passportInfo.nationality = translatedWord;
      } else if (type == countryOfIssueType) {
        passportState.travelers[index].passportInfo.countryOfIssue = translatedWord;
      } else if (type == gender) {
        passportState.travelers[index].passportInfo.gender = translatedWord;
      }
      passportController.refreshList(index);
    } else {
      if (type == placeOfIssue) {
        visaState.travelers[index].visaInfo.placeOfIssue = translatedWord;
      } else if (type == visaType) {
        visaState.travelers[index].visaInfo.type = translatedWord;
      }
      visaController.refreshList(index);
    }
  }

  static String? getDropdownMenuItemValue({required passOrVisa, required String type, required dynamic selectedType, required int index}) {
    String? returnedValue;
    if (passOrVisa == passport) {
      if (type == passportType) {
        returnedValue = selectedType.fullName == passportType ? passportType : selectedType.fullName;
      } else if (type == nationalityType) {
        returnedValue = selectedType.englishName! == nationalityType ? (nationalityType) : selectedType.englishName!;
      } else if (type == countryOfIssueType) {
        returnedValue = selectedType.englishName! == countryOfIssueType ? (countryOfIssueType) : selectedType.englishName!;
      } else if (type == gender) {
        returnedValue = selectedType == gender ? gender : selectedType;
      }
    } else {
      if (type == placeOfIssue) {
        returnedValue = selectedType.englishName! == placeOfIssue ? placeOfIssue : selectedType.englishName!;
      } else if (type == visaType) {
        returnedValue = selectedType.fullName == visaType ? visaType : selectedType.fullName;
      }
    }
    return returnedValue;
  }

  static String? getDropdownMenuItemText({required passOrVisa, required String type, required dynamic selectedType, required int index}) {
    String? returnedValue;
    if (passOrVisa == passport) {
      if (type == passportType) {
        returnedValue = selectedType.fullName == passportType ? passportType : selectedType.fullName;
      } else if (type == nationalityType) {
        returnedValue = selectedType.englishName! == nationalityType ? (nationalityType) : selectedType.englishName!;
      } else if (type == countryOfIssueType) {
        returnedValue = selectedType.englishName! == countryOfIssueType ? (countryOfIssueType) : selectedType.englishName!;
      } else if (type == gender) {
        returnedValue = selectedType == gender ? gender : selectedType;
      }
    } else {
      if (type == placeOfIssue) {
        returnedValue = selectedType.englishName! == placeOfIssue ? placeOfIssue : selectedType.englishName!;
      } else if (type == visaType) {
        returnedValue = selectedType.fullName == visaType ? visaType : selectedType.fullName;
      }
    }
    return returnedValue;
  }
}
