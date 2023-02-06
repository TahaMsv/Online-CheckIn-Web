import 'package:flutter/material.dart';
import 'package:online_check_in/screens/Visa/visa_controller.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:provider/provider.dart';
import '../core/constants/ui.dart';
import '../core/dependency_injection.dart';
import '../core/utils/drop_down_utils.dart';
import '../screens/Passport/passport_controller.dart';
import '../screens/Passport/passport_state.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({Key? key, required this.index, required this.hintText, this.width = 350, this.height = 40, required this.passOrVisa}) : super(key: key);

  final double width;
  final double height;
  final String hintText;
  final int index;

  final String passOrVisa;

  @override
  Widget build(BuildContext context) {
    PassportState passportState = context.watch<PassportState>();
    VisaState visaState = context.watch<VisaState>();
    PassportController passportController = getIt<PassportController>();
    VisaController visaController = getIt<VisaController>();

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.white1,
          width: 2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: DropdownButton(
            dropdownColor: Colors.white,
            hint: Text(
              hintText,
              style: const TextStyle(fontSize: 25),
            ),
            onChanged: (newValue) => passOrVisa == DropDownUtils.passport
                ? passportController.getOnChangedValueByType(type: hintText, newValue: newValue, index: index)
                : visaController.getOnChangedValueByType(type: hintText, newValue: newValue, index: index),
            value: passOrVisa == DropDownUtils.passport
                ? passportController.getValueByType(index: index, type: hintText)
                : visaController.getValueByType(index: index, type: hintText),
            items: (passOrVisa == DropDownUtils.passport
                    ? (hintText == DropDownUtils.passportType
                        ? passportState.listPassportType
                        : hintText == DropDownUtils.nationalityType
                            ? passportState.nationalitiesList
                            : hintText == DropDownUtils.countryOfIssueType
                                ? passportState.countryOfIssueList
                                : passportState.listGender)
                    : (hintText == DropDownUtils.visaType ? visaState.visaListType : visaState.listIssuePlace))
                .map(
              (selectedType) {
                // passportState.travelers[index].passportInfo.nationalityID = selectedType.id;
                return DropdownMenuItem(
                  value: passOrVisa == DropDownUtils.passport
                      ? passportController.getDropdownMenuItemValue(type: hintText, selectedType: selectedType, index: index,)
                      : visaController.getDropdownMenuItemValue(type: hintText, selectedType: selectedType, index: index,),
                  child: Text(
                    passOrVisa == DropDownUtils.passport
                        ? passportController.getDropdownMenuItemText(type: hintText, selectedType: selectedType, index: index,)!
                        : visaController.getDropdownMenuItemText(type: hintText, selectedType: selectedType, index: index,)!,
                    style: const TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
