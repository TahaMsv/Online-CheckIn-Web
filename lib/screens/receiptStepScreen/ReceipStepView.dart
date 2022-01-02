import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinecheckin/screens/receiptStepScreen/ReceiptStepController.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReceiptStepView extends StatelessWidget {
  final ReceiptStepController myReceiptStepController;

  ReceiptStepView(MainModel model) : myReceiptStepController = Get.put(ReceiptStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MainModel model = context.watch<MainModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: model.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Obx(
              () => !myReceiptStepController.successfulResponse.value
                  ? Center(
                      child: Text("Unable to load boarding pass"),
                    )
                  : Container(
                      height: height,
                      width: width,
                      child: Column(
                        children: [
                          StepsScreenTitle(
                            title: "Finished!",
                            description: "You can see your check-in below, print it or download it or send it to your mobile",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(child: SfPdfViewer.memory(myReceiptStepController.bytes,))
                        ],
                      ),
                    ),
            ),
    );
  }
}
