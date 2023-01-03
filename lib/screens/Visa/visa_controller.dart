import 'package:flutter/material.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_repository.dart';
import 'package:online_checkin_web_refactoring/screens/Visa/visa_state.dart';

import '../../core/classes/VisaType.dart';
import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';
import '../steps/steps_state.dart';

class VisaController extends MainController {

  final VisaState visaState = getIt<VisaState>();
  final VisaRepository visaRepository = getIt<VisaRepository>();

  void travellersList() {
    final StepsState stepsState = getIt<StepsState>();
    visaState.travelers = stepsState.travelers;
  }

  void updateIsCompleted(int index) {
    visaState.travelers[index].visaInfo.updateIsCompleted();
  }

  void updateDocuments() {
    for (var i = 0; i < visaState.travelers.length; ++i) {
      visaState.travelers[i].visaInfo.documentNo = visaState.documentNoCs[i].text == "" ? null : visaState.documentNoCs[i].text;
      visaState.travelers[i].visaInfo.destination = visaState.destinationCs[i].text == "" ? null : visaState.destinationCs[i].text;
    }
  }

  void submitBtnFunction(int index) {
    // final PassportStepController passportStepController = Get.put(PassportStepController(model));
    updateDocuments();
    updateIsCompleted(index);
    visaState.refreshTravellers();
    // passportStepController.saveDocsDocoDoca(index);
    // Get.back();
  }

  void selectEntryDate(int index, DateTime date) {
    visaState.travelers[index].visaInfo.issueDate = date;
    updateIsCompleted(index);
    visaState.refreshTravellers();
  }

  void refreshList(int index) {
    updateIsCompleted(index);
    visaState.refreshTravellers();
  }

  void showDOCOPopup(int index) {
    // Locale locale = Get.locale!;
    // Get.defaultDialog(
    //   title: "",
    //   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    //   backgroundColor: MyColors.white,
    //   buttonColor: Colors.red,
    //   barrierDismissible: true,
    //   radius: 10,
    //   content: Container(
    //     width: 600,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         StepsScreenTitle(title: "Passport / Visa Details".tr, description: ""),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Text(
    //           "A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination".tr,
    //           overflow: TextOverflow.clip,
    //           style: TextStyle(color: Color(0xff959595), fontSize: 12),
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Row(
    //           children: [
    //             typeDropDown(index, locale),
    //             SizedBox(
    //               width: 20,
    //             ),
    //             UserTextInput(
    //               controller: documentNoCs[index],
    //               hint: "Document No.",
    //               errorText: "",
    //               isEmpty: false,
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Row(
    //           children: [
    //             placeOfIssueDropDown(index, locale),
    //             SizedBox(
    //               width: 20,
    //             ),
    //             Obx(
    //                   () => SelectingDateWidget(
    //                 hint: "Issue Date".tr,
    //                 index: index,
    //                 updateDate: selectEntryDate,
    //                 currDateTime: travellers[index].visaInfo.issueDate == null ? DateTime.now() : travellers[index].visaInfo.issueDate!,
    //                 isCurrDateEmpty: travellers[index].visaInfo.issueDate == null ? true : false,
    //               ),
    //             ),
    //             SizedBox(
    //               width: 20,
    //             ),
    //             Expanded(
    //               child: UserTextInput(
    //                 controller: destinationCs[index],
    //                 hint: "Destination".tr,
    //                 errorText: "",
    //                 isEmpty: false,
    //               ),
    //             )
    //           ],
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         SubmitButton(
    //           function: model.requesting ? () {} : () => submitBtnFunction(index),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  void showBottomSheetForm(BuildContext context, int index) {
    // Locale locale = Get.locale!;
    // showMaterialModalBottomSheet(
    //   context: context,
    //   builder: (context) => Container(
    //     height: Get.height * 0.6,
    //     child: Center(
    //       child: SingleChildScrollView(
    //         controller: ModalScrollController.of(context),
    //         child: Container(
    //           padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               StepsScreenTitle(
    //                 title: "Passport / Visa Details".tr,
    //                 description: "",
    //                 fontSize: 25,
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Text(
    //                 "A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination".tr,
    //                 overflow: TextOverflow.clip,
    //                 style: TextStyle(color: Color(0xff959595), fontSize: 22),
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               typeDropDown(index, locale, height: 80, width: Get.width, fontSize: 20),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               UserTextInput(
    //                 controller: documentNoCs[index],
    //                 hint: "Document No.",
    //                 errorText: "",
    //                 isEmpty: false,
    //                 height: 80,
    //                 width: Get.width,
    //                 fontSize: 23,
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               placeOfIssueDropDown(index, locale, height: 80, width: Get.width, fontSize: 20),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Obx(
    //                     () => SelectingDateWidget(
    //                   height: 80,
    //                   width: Get.width,
    //                   fontSize: 23,
    //                   hint: "Issue Date".tr,
    //                   index: index,
    //                   updateDate: selectEntryDate,
    //                   currDateTime: travellers[index].visaInfo.issueDate == null ? DateTime.now() : travellers[index].visaInfo.issueDate!,
    //                   isCurrDateEmpty: travellers[index].visaInfo.issueDate == null ? true : false,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               UserTextInput(
    //                 height: 80,
    //                 width: Get.width,
    //                 fontSize: 23,
    //                 controller: destinationCs[index],
    //                 hint: "Destination".tr,
    //                 errorText: "",
    //                 isEmpty: false,
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   SizedBox(
    //                     width: 1,
    //                   ),
    //                   SubmitButton(
    //                     height: 60,
    //                     width: 200,
    //                     fontSize: 20,
    //                     function: model.requesting ? () {} : () => submitBtnFunction(index),
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  void onCreate() {
    init();
  }
}
