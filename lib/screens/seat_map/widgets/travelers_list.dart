import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../../core/platform/device_info.dart';
import '../../../core/utils/MultiLanguages.dart';
import '../../../widgets/MyDivider.dart';
import '../../../widgets/title_widget.dart';
import '../../steps/steps_state.dart';
import '../seat_map_controller.dart';

class TravellersList extends StatelessWidget {
  const TravellersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StepsState stepsState = context.watch<StepsState>();
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Container(
      decoration: const BoxDecoration(shape: BoxShape.rectangle),
      height: height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(title: "Travellers".translate(context), width: width * 0.5, height: deviceType.isPhone ? 60 : 100, fontSize: deviceType.isPhone ? 22 : 40),
              SizedBox(
                width: width * 0.3,
                child: Row(
                  children: [
                    MyDivider(width: 2, height: deviceType.isPhone ? 40 : 60, color: MyColors.white1),
                    TitleWidget(title: "Seat".translate(context), width: width * 0.2, height: deviceType.isPhone ? 60 : 100, fontSize: deviceType.isPhone ? 22 : 40),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: width,
              child: ListView.builder(
                itemCount: stepsState.travelers.length,
                itemBuilder: (ctx, index) {
                  return TravellerItem(step: stepsState.step, index: index);
                },
              ),
            ),
          ),
        ],
      ),
      // color: Colors.red,
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
        String languageCode = MultiLanguages.of(context)!.locale.languageCode;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final SeatMapController seatMapController = getIt<SeatMapController>();
    StepsState stepsState = context.watch<StepsState>();
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Container(
      decoration: BoxDecoration(border: Border.all(color: MyColors.lightGrey), color: stepsState.whoseTurnToSelect == index ? MyColors.brightYellow.withOpacity(0.4) : MyColors.white),
      height: deviceType.isPhone ? 90 : 150,
      margin: EdgeInsets.only(bottom: deviceType.isPhone ? 10 : 20),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? EdgeInsets.only(left: deviceType.isPhone ? 10 : 20.0) : EdgeInsets.only(right: deviceType.isPhone ? 10 : 20.0),
                  child: Text(stepsState.travelers[index].getFullNameWithGender(), style: deviceType.isPhone ? MyTextTheme.darkGreyW40020 : MyTextTheme.darkGreyW40030),
                ),
                step == 6
                    ? SizedBox(
                        width: width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 2, height: deviceType.isPhone ? 80 : 150, color: MyColors.white1),
                            Expanded(
                              child: !isTravellerSelected
                                  ? Center(
                                      child: SizedBox(
                                        width: deviceType.isPhone ? 40 : 80,
                                        height: deviceType.isPhone ? 40 : 80,
                                        child: IconButton(
                                          onPressed: () {
                                            seatMapController.goToSeatMapTablet(index);
                                          },
                                          icon: Icon(Icons.add_circle_outline_rounded, size: deviceType.isPhone ? 30 : 60, color: MyColors.brightYellow),
                                          color: stepsState.whichOneToEdit == index ? Colors.green : Colors.blue,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        TitleWidget(
                                            title: stepsState.travelers[index].seatId,
                                            width: deviceType.isPhone ? 80 : 100,
                                            height: deviceType.isPhone ? 40 : 80,
                                            fontSize: deviceType.isPhone ? 17 : 35,
                                            textColor: isTravellerSelected ? MyColors.oceanGreen : MyColors.darkGrey),
                                        SizedBox(
                                          width: deviceType.isPhone ? 40 : 80,
                                          height: deviceType.isPhone ? 40 : 80,
                                          child: IconButton(
                                            onPressed: () {
                                              seatMapController.goToSeatMapTablet(index);
                                            },
                                            icon: Icon(Icons.edit, size: deviceType.isPhone ? 25 : 45),
                                            color: stepsState.whichOneToEdit == index ? MyColors.green : MyColors.myBlue,
                                          ),
                                        ),
                                      ],
                                    ),
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

class SelectSeatFor extends StatelessWidget {
  const SelectSeatFor({
    Key? key,
    required this.step,
    required this.index,
  }) : super(key: key);
  final int step;
  final int index;

  @override
  Widget build(BuildContext context) {
        String languageCode = MultiLanguages.of(context)!.locale.languageCode;
    StepsState stepsState = context.watch<StepsState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isTravellerSelected = stepsState.travelers[index].seatId == "--" ? false : true;
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grey),
        borderRadius:languageCode == 'en' ? const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)) : const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: isTravellerSelected ? MyColors.white1 : MyColors.brightYellow.withOpacity(0.4),
      ),
      height: deviceType.isTablet? 200 : 125,
      width:deviceType.isTablet? width * 0.7 : width * 0.75,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  padding: languageCode == 'en' ?  EdgeInsets.only(left:deviceType.isTablet? 20.0:5) :  EdgeInsets.only(right:deviceType.isTablet? 20.0:5),
                  child: Text(
                    stepsState.travelers[index].getFullNameWithGender(),
                    style:deviceType.isTablet? MyTextTheme.darkGreyW40030 : MyTextTheme.darkGreyW50017,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                step == 6
                    ? SizedBox(
                        width: width * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TitleWidget(
                                    title: stepsState.travelers[index].seatId,
                                    width:deviceType.isTablet? 100 : 80,
                                    height:deviceType.isTablet? 80 : 50,
                                    fontSize: deviceType.isTablet?35 : 25,
                                    textColor: isTravellerSelected ? MyColors.oceanGreen : MyColors.darkGrey,
                                  ),
                                ],
                              ),
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
