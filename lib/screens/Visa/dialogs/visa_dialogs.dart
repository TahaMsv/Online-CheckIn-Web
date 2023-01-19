import 'package:online_checkin_web_refactoring/core/utils/drop_down_utils.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_state.dart';
import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/widgets/MyDropDown.dart';
import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../widgets/SelectingDateWidget.dart';
import '../../../widgets/StepsScreenTitle.dart';
import '../../../widgets/UserTextInput.dart';
import '../visa_controller.dart';
import '../visa_view.dart';

class VisaDetailsDialog extends StatefulWidget {
  const VisaDetailsDialog({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<VisaDetailsDialog> createState() => _VisaDetailsDialogState();
}

class _VisaDetailsDialogState extends State<VisaDetailsDialog> {
  late int index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VisaState visaState = getIt<VisaState>();
    final VisaController visaController = getIt<VisaController>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 500,
      child: Padding(
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
                const Text(
                  "A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination",
                  overflow: TextOverflow.clip,
                  style: MyTextTheme.lightGrey12,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    MyDropDown(index: index, hintText: DropDownUtils.visaType, passOrVisa: DropDownUtils.visa),
                    const SizedBox(width: 20),
                    UserTextInput(
                      controller: visaState.documentNoCs[index],
                      hint: "Document No.",
                      errorText: "",
                      isEmpty: false,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    MyDropDown(index: index, hintText: DropDownUtils.placeOfIssue, passOrVisa: DropDownUtils.visa),
                    const SizedBox(width: 20),
                    SelectingDateWidget(
                      hint: "Issue Date",
                      index: index,
                      updateDate: visaController.selectEntryDate,
                      currDateTime: visaState.travelers[index].visaInfo.issueDate == null ? DateTime.now() : visaState.travelers[index].visaInfo.issueDate!,
                      isCurrDateEmpty: visaState.travelers[index].visaInfo.issueDate == null ? true : false,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: UserTextInput(
                        controller: visaState.destinationCs[index],
                        hint: "Destination",
                        errorText: "",
                        isEmpty: false,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SubmitButton(
                  function: visaState.requesting ? () {} : () => visaController.submitBtnFunction(index),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
