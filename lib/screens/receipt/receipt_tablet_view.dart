import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/receipt/receipt_controller.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class ReceiptViewTablet extends StatelessWidget {
  ReceiptViewTablet({Key? key}) : super(key: key);
  final ReceiptController receiptController = getIt<ReceiptController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ReceiptState receiptState = context.watch<ReceiptState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: receiptState.loading
          ? const Center(child: CircularProgressIndicator())
          : !receiptState.successfulResponse
              ?  Center(child: Text("Unable to load boarding pass".translate(context)))
              : SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                       StepsScreenTitle(title: "Finished!".translate(context), fontSize: 45, description: ""),
                      const SizedBox(height: 20),
                       Text(
                        "You can see your check-in below, print it or download it or send it to your mobile".translate(context),
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      Expanded(child: SfPdfViewer.memory(receiptState.bytes))
                    ],
                  ),
                ),
    );
  }
}
