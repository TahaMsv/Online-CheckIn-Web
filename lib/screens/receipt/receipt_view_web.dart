import 'package:flutter/material.dart';
import 'package:online_check_in/screens/receipt/receipt_controller.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../widgets/StepsScreenTitle.dart';

class ReceiptViewWeb extends StatelessWidget {
  ReceiptViewWeb({Key? key}) : super(key: key);
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
              ? const Center(child: Text("Unable to load boarding pass"))
              : SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      const StepsScreenTitle(title: "Finished!", description: "You can see your check-in below, print it or download it or send it to your mobile"),
                      const SizedBox(height: 20),
                      Expanded(child: SfPdfViewer.memory(receiptState.bytes))
                    ],
                  ),
                ),
    );
  }
}
