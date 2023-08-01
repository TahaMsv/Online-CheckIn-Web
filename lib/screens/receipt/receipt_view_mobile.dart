import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/receipt/receipt_controller.dart';
import 'package:online_check_in/screens/receipt/receipt_state.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../widgets/StepsScreenTitle.dart';

class ReceiptView extends ConsumerWidget {
  ReceiptView({Key? key}) : super(key: key);
  final ReceiptController receiptController = getIt<ReceiptController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ReceiptState receiptState = ref.watch(receiptProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: receiptState.loading
          ? const Center(child: CircularProgressIndicator())
          : !receiptState.successfulResponse
              ? Center(child: Text("Unable to load boarding pass".translate(context)))
              : SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      StepsScreenTitle(title: "Finished!".translate(context), fontSize: 25, description: ""),
                      const SizedBox(height: 10),
                      Text(
                        "You can see your check-in below, print it or download it or send it to your mobile".translate(context),
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                          child: SfPdfViewer.memory(
                        receiptState.bytes!,

                      ))
                    ],
                  ),
                ),
    );
  }
}
