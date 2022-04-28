import 'package:flutter/material.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/UserTextInput.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'TravellersStepController.dart';

class TravellersStepView extends StatelessWidget {
  final TravellersStepScreenController myTravellersStepScreenController;

  TravellersStepView(MainModel model) : myTravellersStepScreenController = Get.put(TravellersStepScreenController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          height: 300,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Travellers",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff424242),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Add all passengers to the list on the left here",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff808080),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Obx(
                () => UserTextInput(
                  controller: myTravellersStepScreenController.ticketNumberC,
                  hint: "Reservation ID / Ticket Number",
                  errorText: "Reservation ID / Ticket Number can't be empty",
                  isEmpty: myTravellersStepScreenController.isTicketNumberEmpty.value,
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => UserTextInput(
                  controller: myTravellersStepScreenController.lastNameC,
                  hint: "Last Name",
                  errorText: "Last Name can't be empty",
                  isEmpty: myTravellersStepScreenController.isLastNameEmpty.value,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              AddToTravellersButton(
                myTravellersStepScreenController: myTravellersStepScreenController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToTravellersButton extends StatelessWidget {
  const AddToTravellersButton({
    Key? key,
    required this.myTravellersStepScreenController,
  }) : super(key: key);
  final TravellersStepScreenController myTravellersStepScreenController;

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    return MyElevatedButton(
      height: 40,
      width: double.infinity,
      buttonText: "Add to Travellers",
      bgColor: Color(0xff00bfa2),
      fgColor: Colors.white,
      function: model.requesting ? () {} : myTravellersStepScreenController.addTraveller,
    );
  }
}
