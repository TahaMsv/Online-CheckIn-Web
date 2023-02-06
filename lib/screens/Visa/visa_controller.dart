import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:online_check_in/screens/Visa/usecases/select_visa_types_usecase.dart';
import 'package:online_check_in/screens/Visa/visa_repository.dart';
import 'package:online_check_in/screens/Visa/visa_state.dart';
import 'package:online_check_in/screens/Visa/visa_view.dart';

import '../../core/classes/VisaType.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../../core/utils/drop_down_utils.dart';
import '../../core/utils/failure_handler.dart';
import '../../core/utils/getTranslatedWord.dart';
import '../../widgets/MyDropDown.dart';
import '../../widgets/SelectingDateWidget.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';
import '../steps/steps_state.dart';
import 'dialogs/visa_dialogs.dart';

class VisaController extends MainController {
  final VisaState visaState = getIt<VisaState>();
  final VisaRepository visaRepository = getIt<VisaRepository>();

  late SelectVisaTypesUseCase selectVisaTypesUseCase = SelectVisaTypesUseCase(repository: visaRepository);

  void init() async {
    visaState.setLoading(true);
    if (!visaState.visaInit) {
      final StepsState stepsState = getIt<StepsState>();
      visaState.travelers = stepsState.travelers;
      await getVisaTypes();
      for (var i = 0; i < visaState.travelers.length; ++i) {
        visaState.documentNoCs.add(TextEditingController());
        visaState.destinationCs.add(TextEditingController());
      }
    }
    visaState.setLoading(false);
  }

  Future<void> getVisaTypes() async {
    SelectVisaTypesRequest selectVisaTypesRequest = SelectVisaTypesRequest();
    final fOrList = await selectVisaTypesUseCase(request: selectVisaTypesRequest);

    fOrList.fold((f) => FailureHandler.handle(f, retry: () => getVisaTypes()), (visaTypesList) async {
      visaState.visaListType.addAll(visaTypesList);
      visaState.setVisaInit(true);
    });
  }

  void updateDocuments() {
    for (var i = 0; i < visaState.travelers.length; ++i) {
      visaState.travelers[i].visaInfo.documentNo = visaState.documentNoCs[i].text == "" ? null : visaState.documentNoCs[i].text;
      visaState.travelers[i].visaInfo.destination = visaState.destinationCs[i].text == "" ? null : visaState.destinationCs[i].text;
    }
  }

  void submitBtnFunction(int index) {
    updateDocuments();
    visaState.setState();
    nav.pop();
  }

  void selectEntryDate(int index, DateTime date) {
    visaState.travelers[index].visaInfo.issueDate = date;
    visaState.setState();
  }

  // void showDOCOPopup(int index) {
  //   Locale locale = Get.locale!;
  //   Get.defaultDialog(
  //     title: "",
  //     contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
  //     backgroundColor: MyColors.white,
  //     buttonColor: Colors.red,
  //     barrierDismissible: true,
  //     radius: 10,
  //     content: Container(
  //       width: 600,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           StepsScreenTitle(title: "Passport / Visa Details".tr, description: ""),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Text(
  //             "A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination".tr,
  //             overflow: TextOverflow.clip,
  //             style: TextStyle(color: Color(0xff959595), fontSize: 12),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Row(
  //             children: [
  //               typeDropDown(index, locale),
  //               SizedBox(
  //                 width: 20,
  //               ),
  //               UserTextInput(
  //                 controller: documentNoCs[index],
  //                 hint: "Document No.",
  //                 errorText: "",
  //                 isEmpty: false,
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Row(
  //             children: [
  //               placeOfIssueDropDown(index, locale),
  //               SizedBox(
  //                 width: 20,
  //               ),
  //               Obx(
  //                     () => SelectingDateWidget(
  //                   hint: "Issue Date".tr,
  //                   index: index,
  //                   updateDate: selectEntryDate,
  //                   currDateTime: travellers[index].visaInfo.issueDate == null ? DateTime.now() : travellers[index].visaInfo.issueDate!,
  //                   isCurrDateEmpty: travellers[index].visaInfo.issueDate == null ? true : false,
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 20,
  //               ),
  //               Expanded(
  //                 child: UserTextInput(
  //                   controller: destinationCs[index],
  //                   hint: "Destination".tr,
  //                   errorText: "",
  //                   isEmpty: false,
  //                 ),
  //               )
  //             ],
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           SubmitButton(
  //             function: model.requesting ? () {} : () => submitBtnFunction(index),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void showBottomSheetForm(BuildContext context, double height, double width, int index) {
    // Locale locale = Get.locale!;
    showMaterialModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SizedBox(
        height: height * 0.6,
        child: Center(
          child: SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepsScreenTitle(title: "Passport / Visa Details", description: "", fontSize: 25),
                  const SizedBox(height: 20),
                  const Text("A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination",
                      overflow: TextOverflow.clip, style: MyTextTheme.lightGrey22),
                  const SizedBox(height: 20),
                  MyDropDown(index: index, hintText: DropDownUtils.visaType, width: width, height: 80, passOrVisa: DropDownUtils.visa),
                  const SizedBox(height: 20),
                  UserTextInput(controller: visaState.documentNoCs[index], hint: "Document No.", errorText: "", isEmpty: false, height: 80, width: width, fontSize: 23),
                  const SizedBox(height: 20),
                  MyDropDown(index: index, hintText: DropDownUtils.placeOfIssue, width: width, height: 80, passOrVisa: DropDownUtils.visa),
                  const SizedBox(height: 20),
                  SelectingDateWidget(
                    height: 80,
                    width: width,
                    fontSize: 23,
                    hint: "Issue Date",
                    index: index,
                    updateDate: selectEntryDate,
                    currDateTime: visaState.travelers[index].visaInfo.issueDate == null ? DateTime.now() : visaState.travelers[index].visaInfo.issueDate!,
                    isCurrDateEmpty: visaState.travelers[index].visaInfo.issueDate == null ? true : false,
                  ),
                  const SizedBox(height: 20),
                  UserTextInput(height: 80, width: width, fontSize: 23, controller: visaState.destinationCs[index], hint: "Destination", errorText: "", isEmpty: false),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 1),
                      SubmitButton(
                        height: 60,
                        width: 200,
                        fontSize: 20,
                        function: visaState.loading ? () {} : () => submitBtnFunction(index),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showVisaDialog(int index) {
    nav.dialog(VisaDetailsDialog(index: index));
  }

  String? getValueByType({required String type, required int index}) {
    String? returnValue;
    if (type == DropDownUtils.placeOfIssue) {
      visaState.travelers[index].visaInfo.placeOfIssue == null || visaState.travelers[index].visaInfo.placeOfIssue == DropDownUtils.placeOfIssue
          ? DropDownUtils.placeOfIssue
          : visaState.travelers[index].visaInfo.placeOfIssue;
    } else if (type == DropDownUtils.visaType) {
      returnValue =
          visaState.travelers[index].visaInfo.type == null || visaState.travelers[index].visaInfo.type == DropDownUtils.visaType ? DropDownUtils.visaType : visaState.travelers[index].visaInfo.type;
    }
    return returnValue;
  }

  void getOnChangedValueByType({required String type, required dynamic newValue, required int index}) {
    String translatedWord = getKeyFromLanguageWords(newValue.toString());

    if (type == DropDownUtils.placeOfIssue) {
      visaState.travelers[index].visaInfo.placeOfIssue = translatedWord;
    } else if (type == DropDownUtils.visaType) {
      visaState.travelers[index].visaInfo.type = translatedWord;
    }
    visaState.setState();
  }

  String? getDropdownMenuItemValue({required String type, required dynamic selectedType, required int index}) {
    String? returnedValue;

    if (type == DropDownUtils.placeOfIssue) {
      returnedValue = selectedType.englishName! == DropDownUtils.placeOfIssue ? DropDownUtils.placeOfIssue : selectedType.englishName!;
    } else if (type == DropDownUtils.visaType) {
      returnedValue = selectedType.fullName == DropDownUtils.visaType ? DropDownUtils.visaType : selectedType.fullName;
    }

    return returnedValue;
  }

  String? getDropdownMenuItemText({required String type, required dynamic selectedType, required int index}) {
    String? returnedValue;

    if (type == DropDownUtils.placeOfIssue) {
      returnedValue = selectedType.englishName! == DropDownUtils.placeOfIssue ? DropDownUtils.placeOfIssue : selectedType.englishName!;
    } else if (type == DropDownUtils.visaType) {
      returnedValue = selectedType.fullName == DropDownUtils.visaType ? DropDownUtils.visaType : selectedType.fullName;
    }
    return returnedValue;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
// @override
// void onCreate() {
//
//   super.onCreate();
// }
}
