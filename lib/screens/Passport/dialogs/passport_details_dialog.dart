import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../core/utils/drop_down_utils.dart';
import '../../../widgets/MyDropDown.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../../../widgets/SelectingDateWidget.dart';
import '../../../widgets/StepsScreenTitle.dart';
import '../../../widgets/UserTextInput.dart';
import '../passport_controller.dart';
import '../passport_state.dart';
import '../passport_view_web.dart';

class PassportDialog extends StatefulWidget {
  const PassportDialog({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<PassportDialog> createState() => _PassportDialogState();
}

class _PassportDialogState extends State<PassportDialog> {
  late int index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PassportState passportState = getIt<PassportState>();
    final PassportController passportController = getIt<PassportController>();
    double fontSize = 16;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 200),
      child: Dialog(
        backgroundColor: MyColors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const StepsScreenTitle(title: "Passport / Visa Details", description: ""),
              const SizedBox(height: 20),
              Row(
                children: [
                  MyDropDown(index: index, hintText: DropDownUtils.passportType, passOrVisa: DropDownUtils.passport),
                  const SizedBox(width: 20),
                  Expanded(
                    child: UserTextInput(controller: passportState.documentNoCs[index], hint: "Document No.", errorText: "", isEmpty: false),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  MyDropDown(index: index, hintText: DropDownUtils.gender, passOrVisa: DropDownUtils.passport),
                  const SizedBox(width: 20),
                  MyDropDown(index: index, hintText: DropDownUtils.countryOfIssueType, passOrVisa: DropDownUtils.passport),
                  const SizedBox(width: 20),
                  SelectingDateWidget(
                    hint: "Entry Date",
                    index: index,
                    updateDate: passportController.selectEntryDate,
                    currDateTime: passportState.travelers[index].passportInfo.entryDate == null ? DateTime.now() : passportState.travelers[index].passportInfo.entryDate!,
                    isCurrDateEmpty: passportState.travelers[index].passportInfo.entryDate == null ? true : false,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  MyDropDown(index: index, hintText: DropDownUtils.nationalityType, passOrVisa: DropDownUtils.passport),
                  const SizedBox(width: 20),
                  SelectingDateWidget(
                    hint: "Date of Birth",
                    index: index,
                    updateDate: passportController.selectDateOfBirth,
                    currDateTime: passportState.travelers[index].passportInfo.dateOfBirth == null ? DateTime.now() : passportState.travelers[index].passportInfo.dateOfBirth!,
                    isCurrDateEmpty: passportState.travelers[index].passportInfo.dateOfBirth == null ? true : false,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 1),
                  MyElevatedButton(
                    height: 50,
                    width: 175,
                    buttonText: "Submit",
                    bgColor: MyColors.white,
                    fgColor: MyColors.myBlue,
                    function: () => passportController.updateDocuments(),
                    isLoading: passportState.loading,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
