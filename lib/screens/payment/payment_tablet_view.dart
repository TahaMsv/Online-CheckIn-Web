import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/payment/payment_controller.dart';
import 'package:online_check_in/screens/payment/payment_state.dart';
import 'package:online_check_in/screens/payment/widgets/billing_address.dart';
import 'package:online_check_in/screens/payment/widgets/card_info.dart';
import 'package:online_check_in/screens/payment/widgets/taxes_and_fees.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/MtDottedLine.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';

class PaymentViewTablet extends StatelessWidget {
  PaymentViewTablet({Key? key}) : super(key: key);
  final PaymentController paymentController = getIt<PaymentController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    PaymentState paymentState = context.watch<PaymentState>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  StepsScreenTitle(
                    title: "Payment".translate(context),
                    fontSize: 45,
                    description: "",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Pay with credit card, Visa or debit or Mastercard debit".translate(context),
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  const TaxesAndFees(),
                  const SizedBox(height: 30),
                  const CardInfo(),
                  const SizedBox(height: 20),
                  Container(
                    width: Get.width,
                    height: 5,
                    color: const Color(0xffefefef),
                  ),
                  const SizedBox(height: 20),
                  const BillingAddress(),
                ],
              ),
            )
          ],
        ));
  }
}
