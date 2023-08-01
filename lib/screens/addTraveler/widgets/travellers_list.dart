import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import '../../../core/platform/device_info.dart';
import '../../../core/utils/multi_languages.dart';
import '../../../widgets/MyDivider.dart';
import '../../../widgets/MyElevatedButton.dart';
import '../../../widgets/UserTextInput.dart';
import '../../../widgets/title_widget.dart';
import '../../steps/steps_controller.dart';
import '../../steps/steps_state.dart';
import '../add_traveler_controller.dart';
import '../add_traveler_state.dart';

class TravellersList extends ConsumerWidget {
  const TravellersList({
    Key? key,
    required this.width,
    required this.step,
  }) : super(key: key);

  final double width;
  final int step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StepsState stepsState = ref.watch(stepsProvider);
    DeviceType deviceType = DeviceInfo.deviceType(context);
    double height = MediaQuery.of(context).size.height;
    double travelerItemHeight = deviceType.isPhone ? 40 : 80;
    double tempHeight = (deviceType.isPhone ? 60 : 90) + stepsState.travelers.length * (travelerItemHeight + (deviceType.isPhone ? 5 : 15));
    double listHeight = tempHeight < height * 0.3 ? tempHeight : height * 0.3;
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.rectangle),
      margin: EdgeInsets.only(bottom: 10),
      height: listHeight,
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
            height: listHeight - (deviceType.isPhone ? 50 : 95),
            padding: EdgeInsets.symmetric(horizontal: deviceType.isPhone ? 10 : 20),
            child: ListView.builder(
              itemCount: stepsState.travelers.length,
              itemBuilder: (ctx, index) {
                return TravellerItem(
                  step: step,
                  index: index,
                  travelerItemHeight: travelerItemHeight,
                );
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
    final AddTravelerController addTravelerController = getIt<AddTravelerController>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: deviceType.isPhone ? 5 : 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              addTravelerController.showAddTravelerBottomSheet(context, height, width, keyboardSize);
            },
            child: Container(
              margin: EdgeInsets.only(top: deviceType.isPhone ? 10 : 20),
              child: Row(
                children: [
                  Icon(
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
        ],
      ),
    );
  }
}

class TravellerItem extends ConsumerWidget {
  const TravellerItem({
    Key? key,
    required this.step,
    required this.index,
    required this.travelerItemHeight,
  }) : super(key: key);
  final int step;
  final int index;
  final double travelerItemHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StepsController stepsController = getIt<StepsController>();
    StepsState stepsState = ref.watch(stepsProvider);
    // String languageCode = MultiLanguages.of(context)!.locale.languageCode;  //todo
    String languageCode = 'en';
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.lightGrey),
        color: stepsState.whoseTurnToSelect == index && step == 6 ? MyColors.brightYellow.withOpacity(0.5) : MyColors.white,
      ),
      height: travelerItemHeight,
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
