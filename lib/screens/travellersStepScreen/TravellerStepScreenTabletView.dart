import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/UserTextInput.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../stepsScreen/StepsScreenController.dart';
import '../stepsScreen/StepsScreenView.dart';
import 'TravellersStepController.dart';

class TravellersStepTabletView extends StatelessWidget {
  final TravellersStepScreenController myTravellersStepScreenController;

  TravellersStepTabletView(MainModel model) : myTravellersStepScreenController = Get.put(TravellersStepScreenController(model));

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final flightInformation = myTravellersStepScreenController.welcome!.body.flight[0];
    MainModel model = context.watch<MainModel>();
    final myStepsScreenController = Get.put(StepsScreenController(model));
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            width: width * 0.8,
            height: 350,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC), width: 2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                DatesAndFromToCities(
                  fromCity: flightInformation.fromCity,
                  fromTime: DateFormat('yyyy-MM-dd').format(flightInformation.flightDate),
                  toCity: flightInformation.toCity,
                  toTime: DateFormat('yyyy-MM-dd').format(flightInformation.flightDate),
                ),
                AirplaneImage(),
                FLightExtraDetails(
                  boardingTime: flightInformation.boardingTime,
                  terminal: flightInformation.terminal,
                  aircraft: flightInformation.aircraft,
                  flightClass: "-",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => TravellersList(
              height: height * 0.4,
              width: width,
              step: myStepsScreenController.step,
              myStepsScreenController: myStepsScreenController,
            ),
          )
        ],
      ),
    );
  }
}
class TravellersList extends StatelessWidget {
  const TravellersList({
    Key? key,
    required this.height,
    required this.width,
    required this.step,
    required this.myStepsScreenController,
  }) : super(key: key);

  final double height;
  final double width;
  final int step;
  final StepsScreenController myStepsScreenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black.withOpacity(0.1)),
        shape: BoxShape.rectangle,
        // color: Colors.blue,
      ),
      height: height,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(
                title: "Travellers".tr,
                width: width * 0.5,
                height: 100,
                fontSize: 40,
              ),
              if (step == 6)
                Container(
                  width: 112,
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        height: 60,
                        color: Color(0xffededed),
                      ),
                      TitleWidget(
                        title: "Seat".tr,
                        width: 100,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          // Container(
          //   // width: width,
          //   height: 1,
          //   color: Color(0xffeaeaea),
          // ),
          Obx(
                () => Container(
              width: width,
              height: height - 105,
              // color: Colors.yellow,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: myStepsScreenController.travellers.length + 1,
                itemBuilder: (ctx, index) {
                  return index < myStepsScreenController.travellers.length
                      ? TravellerItem(
                    step: step,
                    index: index,
                    myStepsScreenController: myStepsScreenController,
                  )
                      : myStepsScreenController.step == 0
                      ? AddNewTraveller(
                    myStepsScreenController: myStepsScreenController,
                  )
                      : Container();
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

class AddNewTraveller extends StatelessWidget {
  const AddNewTraveller({
    Key? key,
    required this.myStepsScreenController,
  }) : super(key: key);
  final StepsScreenController myStepsScreenController;

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    TravellersStepScreenController myTravellersStepScreenController = Get.put(TravellersStepScreenController(model));
    return Obx(
          () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                myStepsScreenController.changeStateOFAddingBox();
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    myStepsScreenController.isAddingBoxOpen.value
                        ? RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Icon(
                        MenuIcons.iconAdd,
                        color: Color(0xff48c0a2),
                        size: 30,
                      ),
                    )
                        : Icon(
                      MenuIcons.iconAdd,
                      color: Color(0xff48c0a2),
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Add Travellers".tr,
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xff48c0a2),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (myStepsScreenController.isAddingBoxOpen.value)
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add all passengers to the list on the left here".tr,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff808080),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(
                        () => UserTextInput(
                          height: 63,

                      controller: myTravellersStepScreenController.lastNameC,
                      hint: "Last Name".tr,
                      errorText: "Last Name can't be empty".tr,
                      isEmpty: myTravellersStepScreenController.isLastNameEmpty.value,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                        () => UserTextInput(
                          height: 63,
                      controller: myTravellersStepScreenController.ticketNumberC,
                      hint: "Reservation ID / Ticket Number".tr,
                      errorText: "Reservation ID / Ticket Number can't be empty".tr,
                      isEmpty: myTravellersStepScreenController.isTicketNumberEmpty.value,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  AddToTravellersButton(
                    height: 50,
                    myTravellersStepScreenController: myTravellersStepScreenController,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class AddToTravellersButton extends StatelessWidget {
  const AddToTravellersButton({
    Key? key,
    required this.myTravellersStepScreenController,  this.height = 40,
  }) : super(key: key);
  final TravellersStepScreenController myTravellersStepScreenController;
final double height;
  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    return MyElevatedButton(
      height: height,
      width: double.infinity,
      buttonText: "Add to Travellers".tr,
      bgColor: Color(0xff00bfa2),
      fgColor: Colors.white,
      fontSize: 22,
      function: model.requesting ? () {} : myTravellersStepScreenController.addTraveller,
    );
  }
}

class TravellerItem extends StatelessWidget {
  const TravellerItem({
    Key? key,
    required this.step,
    required this.index,
    required this.myStepsScreenController,
  }) : super(key: key);
  final int step;
  final int index;
  final StepsScreenController myStepsScreenController;

  @override
  Widget build(BuildContext context) {
    String languageCode = Get.locale!.languageCode;
    bool isTravellerSelected = myStepsScreenController.travellers[index].seatId == "--" ? false : true;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.rectangle,
        color: myStepsScreenController.whoseTurnToSelect.value == index && step == 6 ? const Color(0xffffae2c).withOpacity(0.5) : Colors.white,
      ),
      height: 70,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: languageCode == 'en' ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                  child: Text(
                    myStepsScreenController.travellers[index].getFullNameWithGender(),
                    style: TextStyle(
                      color: Color(0xff424242),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                step == 0
                    ? IconButton(
                  onPressed: () => myStepsScreenController.removeFromTravellers(index),
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 40,
                  ),
                )
                    : step == 6
                    ? Container(
                  width: 112,
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        height: 100,
                        color: Color(0xffededed),
                      ),
                      Row(
                        children: [
                          TitleWidget(
                            title: myStepsScreenController.travellers[index].seatId,
                            width: 75,
                            textColor: isTravellerSelected ? Color(0xff48c0a2) : Color(0xff424242),
                          ),
                          Container(
                            width: 35,
                            // child: IconButton(
                            //   onPressed: () {
                            //     myStepsScreenController.setWhichOneToEdit(index);
                            //   },
                            //   icon: Icon(Icons.edit),
                            //   color: myStepsScreenController.whichOneToEdit == index ? Colors.green : Colors.blue,
                            // ),
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


class AirplaneImage extends StatelessWidget {
  const AirplaneImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffECECEC),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Image.asset(
              "assets/images/addTravellers/airplane.png",
              fit: BoxFit.fill,
              // height: 350,
            ),
          ),
        ],
      ),
    );
  }
}

class FLightExtraDetails extends StatelessWidget {
  const FLightExtraDetails({
    Key? key,
    required this.boardingTime,
    required this.terminal,
    required this.aircraft,
    required this.flightClass,
  }) : super(key: key);
  final String boardingTime;
  final int terminal;
  final String aircraft;
  final String flightClass;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DetailPart(
                title: "Boarding",
                description: boardingTime,
              ),
              DetailPart(
                title: "Terminal",
                description: terminal.toString(),
              ),
              DetailPart(
                title: "Flight",
                description: aircraft,
              ),
              DetailPart(
                title: "Class",
                description: flightClass,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPart extends StatelessWidget {
  const DetailPart({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 22),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          )
        ],
      ),
    );
  }
}

class DatesAndFromToCities extends StatelessWidget {
  const DatesAndFromToCities({
    Key? key,
    required this.fromCity,
    required this.fromTime,
    required this.toCity,
    required this.toTime,
  }) : super(key: key);
  final String fromCity;
  final String fromTime;
  final String toCity;
  final String toTime;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          color: Color(0xff48C0A2).withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CountryAndDate(city: fromCity, time: fromTime),
              Container(
                child: Icon(
                  MenuIcons.iconRightArrow,
                  color: Color(0xff48C0A2),
                ),
              ),
              CountryAndDate(city: toCity, time: toTime),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryAndDate extends StatelessWidget {
  const CountryAndDate({
    Key? key,
    required this.city,
    required this.time,
  }) : super(key: key);
  final String city;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            city,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            time,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          )
        ],
      ),
    );
  }
}
