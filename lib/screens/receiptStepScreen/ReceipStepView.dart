import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/screens/receiptStepScreen/ReceiptStepController.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class ReceiptStepView extends StatelessWidget {
  final ReceiptStepController myReceiptStepController;

  ReceiptStepView(MainModel model) : myReceiptStepController = Get.put(ReceiptStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StepsScreenTitle(
            title: "Finished!",
            description: "You can see your check-in below, print it or download it or send it to your mobile",
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 180,vertical: 15) ,
                  // color: Colors.green,

                  child: Image.asset(
                    'assets/images/ticket.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
