import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../core/platform/device_info.dart';
import '../../../core/utils/MultiLanguages.dart';
import '../../../widgets/MyDivider.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../../../widgets/UserTextInput.dart';
import '../../../widgets/title_widget.dart';
import '../../steps/steps_controller.dart';
import '../../steps/steps_state.dart';
import '../add_traveler_controller.dart';
import '../add_traveler_state.dart';

class TravellersList extends StatelessWidget {
  const TravellersList({
    Key? key,
    required this.width,
    required this.step,
  }) : super(key: key);

  final double width;
  final int step;

  @override
  Widget build(BuildContext context) {
    StepsState stepsState = context.watch<StepsState>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.rectangle),
      height: height * 0.41,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(
                title: "Travellers".translate(context),
                width: width * 0.5,
                height: deviceType.isPhone ? 50 : 95,
                fontSize: deviceType.isPhone ? 20 : 40,
              ),
              if (step == 6)
                SizedBox(
                  width: 112,
                  child: Row(
                    children: [
                      MyDivider(width: 2, height: 60),
                      TitleWidget(title: "Seat".translate(context), width: 100),
                    ],
                  ),
                ),
            ],
          ),
          Container(
            width: width,
            height: height * 0.41 - (deviceType.isPhone ? 50 : 95),
            padding: EdgeInsets.symmetric(horizontal: deviceType.isPhone ? 10 : 20),
            child: ListView.builder(
              itemCount: stepsState.travelers.length + 1,
              itemBuilder: (ctx, index) {
                return index < stepsState.travelers.length
                    ? TravellerItem(
                        step: step,
                        index: index,
                      )
                    : stepsState.step == 0
                        ? const AddNewTraveller()
                        : Container();
              },
            ),
          ),
        ],
      ),
      // color: Colors.red,
    );
  }
}

class AddNewTraveller extends StatelessWidget {
  const AddNewTraveller({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StepsController stepsController = getIt<StepsController>();
    final AddTravelerController addTravelerController = getIt<AddTravelerController>();
    StepsState stepsState = context.watch<StepsState>();
    final AddTravelerState addTravelerState = context.watch<AddTravelerState>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: deviceType.isPhone ? 5 : 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              stepsController.changeStateOFAddingBox();
            },
            child: Container(
              margin: EdgeInsets.only(top: deviceType.isPhone ? 10 : 20),
              child: Row(
                children: [
                  stepsState.isAddingBoxOpen
                      ? RotationTransition(
                          turns: const AlwaysStoppedAnimation(45 / 360),
                          child: Icon(
                            MenuIcons.iconAdd,
                            color: MyColors.mainColor,
                            size: deviceType.isPhone ? 15 : 30,
                          ),
                        )
                      : Icon(
                          MenuIcons.iconAdd,
                          color: MyColors.mainColor,
                          size: deviceType.isPhone ? 15 : 30,
                        ),
                  SizedBox(width: deviceType.isPhone ? 10 : 15),
                  Text("Add Travellers".translate(context), style: deviceType.isPhone ? MyTextTheme.w800MainColor15 : MyTextTheme.w800MainColor22),
                ],
              ),
            ),
          ),
          if (stepsState.isAddingBoxOpen)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: deviceType.isPhone ? 5 : 15),
                Text(
                  "Add all passengers to the list on the left here".translate(context),
                  style: deviceType.isPhone ? MyTextTheme.lightGrey14 : MyTextTheme.lightGrey20,
                ),
                SizedBox(height: deviceType.isPhone ? 10 : 15),
                UserTextInput(
                  height: deviceType.isPhone ? 40 : 63,
                  fontSize: deviceType.isPhone ? 17 : 22,
                  controller: addTravelerState.lastNameC,
                  hint: "Last Name".translate(context),
                  errorText: "Last Name can't be empty".translate(context),
                  isEmpty: addTravelerState.isLastNameEmpty,
                ),
                SizedBox(height: deviceType.isPhone ? 5 : 10),
                UserTextInput(
                  height: deviceType.isPhone ? 40 : 63,
                  fontSize: deviceType.isPhone ? 17 : 22,
                  controller: addTravelerState.ticketNumberC,
                  hint: "Reservation ID / Ticket Number".translate(context),
                  errorText: "Reservation ID / Ticket Number can't be empty".translate(context),
                  isEmpty: addTravelerState.isTicketNumberEmpty,
                  obscureText: true,
                ),
                SizedBox(height: deviceType.isPhone ? 10 : 25),
                Center(
                  child: MyElevatedButton(
                    height: deviceType.isPhone ? 35 : 50,
                    width: deviceType.isPhone ? 250 : double.infinity,
                    buttonText: "Add to Travellers",
                    bgColor: const Color(0xff00bfa2),
                    fgColor: Colors.white,
                    fontSize: deviceType.isPhone ? 17 : 22,
                    isLoading: addTravelerState.requesting || stepsState.stepLoading,
                    function: () => addTravelerController.addTraveller(context),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

class TravellerItem extends StatelessWidget {
  const TravellerItem({
    Key? key,
    required this.step,
    required this.index,
  }) : super(key: key);
  final int step;
  final int index;

  @override
  Widget build(BuildContext context) {
    final StepsController stepsController = getIt<StepsController>();
    StepsState stepsState = context.watch<StepsState>();
        String languageCode = MultiLanguages.of(context)!.locale.languageCode;
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.lightGrey),
        color: stepsState.whoseTurnToSelect == index && step == 6 ? MyColors.brightYellow.withOpacity(0.5) : MyColors.white,
      ),
      height: deviceType.isPhone ? 40 : 70,
      margin: EdgeInsets.only(bottom: deviceType.isPhone ? 5 : 15),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? EdgeInsets.only(left: deviceType.isPhone ? 10 : 20.0) : EdgeInsets.only(right: deviceType.isPhone ? 10 : 20.0),
                  child: Text(
                    stepsState.travelers[index].getFullNameWithGender(),
                    style: TextStyle(
                      color: MyColors.grey,
                      fontSize: deviceType.isPhone ? 16 : 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                step == 0
                    ? Center(
                        child: IconButton(
                          onPressed: () => stepsController.removeFromTravelers(index),
                          icon: Icon(
                            Icons.close,
                            color: MyColors.red,
                            size: deviceType.isPhone ? 25 : 40,
                          ),
                        ),
                      )
                    : step == 6
                        ? SizedBox(
                            width: 112,
                            child: Row(
                              children: [
                                const MyDivider(
                                  width: 2,
                                  height: 100,
                                ),
                                Row(
                                  children: [
                                    TitleWidget(
                                      title: stepsState.travelers[index].seatId,
                                      width: 75,
                                      textColor: isTravellerSelected ? MyColors.mainColor : MyColors.darkGrey,
                                    ),
                                    Container(
                                      width: 35,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
