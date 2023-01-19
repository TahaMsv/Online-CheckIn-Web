import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_state.dart';
import 'package:provider/provider.dart';
import '../core/constants/ui.dart';
import '../core/utils/drop_down_utils.dart';
import '../screens/Passport/passport_controller.dart';
import '../screens/Passport/passport_state.dart';

class MyDropDown extends StatelessWidget {
  MyDropDown({Key? key, required this.index, required this.hintText, this.width = 350, this.height = 40, required this.passOrVisa}) : super(key: key);

  final double width;
  final double height;
  final String hintText;
  final int index;

  final String passOrVisa;

  @override
  Widget build(BuildContext context) {
    PassportState passportState = context.watch<PassportState>();
    VisaState visaState = context.watch<VisaState>();

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
            hint: Text(
              hintText,
              style: const TextStyle(fontSize: 25),
            ),
            onChanged: (newValue) => DropDownUtils.getOnChangedValueByType(type: hintText, newValue: newValue, index: index, passOrVisa: passOrVisa),
            // value: passportController.getValueByType(type: hintText, index: index),
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
                  value: DropDownUtils.getDropdownMenuItemValue(type: hintText, selectedType: selectedType, index: index, passOrVisa: passOrVisa),
                  child: Text(
                    DropDownUtils.getDropdownMenuItemText(type: hintText, selectedType: selectedType, index: index, passOrVisa: passOrVisa)!,
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
