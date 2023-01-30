import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/payment/payment_controller.dart';
import 'package:online_checkin_web_refactoring/screens/payment/payment_state.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

class PaymentViewTablet extends StatelessWidget {
  PaymentViewTablet({Key? key}) : super(key: key);
  final PaymentController paymentController = getIt<PaymentController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    PaymentState paymentState = context.watch<PaymentState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Container(),
    );
  }
}