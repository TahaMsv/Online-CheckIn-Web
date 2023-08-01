import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/payment/payment_controller.dart';
import 'package:online_check_in/screens/payment/payment_state.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../widgets/MtDottedLine.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../widgets/UserTextInput.dart';

class PaymentViewWeb extends ConsumerWidget {
  PaymentViewWeb({Key? key}) : super(key: key);
  final PaymentController paymentController = getIt<PaymentController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            StepsScreenTitle(title: "Payment".translate(context), description: "Pay with credit card, Visa or debit or Mastercard debit".translate(context)),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CardInfo(),
                    const SizedBox(width: 10),
                    Container(width: 2, height: 300, color: MyColors.white),
                    const SizedBox(width: 10),
                    const BillingAddress(),
                  ],
                ),
                const TaxesAndFees(),
              ],
            )
          ],
        ));
  }
}

class TaxesAndFees extends ConsumerWidget {
  const TaxesAndFees({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PaymentController paymentController = getIt<PaymentController>();
    PaymentState paymentState = ref.watch(paymentProvider);

    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Taxes & Fees".translate(context), style: MyTextTheme.darkGreyW50017),
              const Text("\$ 0.00", style: MyTextTheme.darkGreyBold15),
            ],
          ),
          const SizedBox(height: 5),
          const MyDottedLine(color: Color(0xffeaeaea), lineLength: double.infinity),
          const SizedBox(height: 5),
          Container(
            height: 200,
            decoration: const BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: Color(0xffeaeaea),
                  width: 2,
                ),
              ),
            ),
            child: ListView.builder(
              itemCount: paymentState.taxes.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((paymentState.taxes[index]["title"]! as String).translate(context), style: MyTextTheme.w300DarkGrey14),
                    Text("\$ ${(paymentState.taxes[index]["price"]! as double).toStringAsFixed(2)}", style: MyTextTheme.w300DarkGrey14),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total".translate(context), style: MyTextTheme.darkGreyBold17),
              Text("\$ ${paymentState.totalPrice.toStringAsFixed(2)}", style: MyTextTheme.darkGreyBold15),
            ],
          ),
          Text("Including taxes and fees".translate(context), style: MyTextTheme.darkGrey12),
        ],
      ),
    );
  }
}

class BillingAddress extends ConsumerWidget {
  const BillingAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PaymentController paymentController = getIt<PaymentController>();
    PaymentState paymentState = ref.watch(paymentProvider);
    return SizedBox(
      width: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Billing Address".translate(context), style: MyTextTheme.darkGreyBold15),
          const SizedBox(height: 10),
          UserTextInput(
            controller: paymentState.addressC,
            hint: "Address".translate(context),
            height: 90,
            errorText: "",
            isEmpty: false,
          ),
          const SizedBox(height: 20),
          UserTextInput(
            controller: paymentState.billingAddressCardNumberC,
            hint: "Card Number".translate(context),
            errorText: "",
            isEmpty: false,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                controller: paymentState.countryC,
                hint: "Card Number".translate(context),
                errorText: "",
                isEmpty: false,
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: UserTextInput(
                controller: paymentState.provinceC,
                hint: "Province / State".translate(context),
                errorText: "",
                isEmpty: false,
              )),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                controller: paymentState.cityC,
                hint: "City".translate(context),
                errorText: "",
                isEmpty: false,
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: UserTextInput(
                controller: paymentState.postalC,
                hint: "Postal / Zip Code".translate(context),
                errorText: "",
                isEmpty: false,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class CardInfo extends ConsumerWidget {
  const CardInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PaymentController paymentController = getIt<PaymentController>();
    PaymentState paymentState = ref.watch(paymentProvider);
    return SizedBox(
      width: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Card Info".translate(context), style: MyTextTheme.darkGreyBold15),
          const SizedBox(height: 10),
          Row(
            children: const [
              CardImage(imagePath: AssetImages.amexCard),
              CardImage(imagePath: AssetImages.discoverCard),
              CardImage(imagePath: AssetImages.visaCard),
              CardImage(imagePath: AssetImages.card4),
            ],
          ),
          const SizedBox(height: 20),
          UserTextInput(
            controller: paymentState.cardHolderNameC,
            hint: "Cardholder Name".translate(context),
            errorText: "",
            isEmpty: false,
          ),
          const SizedBox(height: 20),
          // UserTextInput(
          //   controller: myPaymentStepController.cardNumberC,
          //   hint: "Card Number",
          //   errorText: "",
          //   isEmpty: false,
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //         child: UserTextInput(
          //       controller: myPaymentStepController.expiryMonthC,
          //       hint: "Expiry Month",
          //       errorText: "",
          //       isEmpty: false,
          //     )),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //         child: UserTextInput(
          //       controller: myPaymentStepController.expiryYearC,
          //       hint: "Expiry Year",
          //       errorText: "",
          //       isEmpty: false,
          //     )),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //         child: UserTextInput(
          //       controller: myPaymentStepController.cvv2C,
          //       hint: "CVV2",
          //       errorText: "",
          //       isEmpty: false,
          //     )),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //       child: Text(
          //         "3 or 4 digits usually found on the signature strip",
          //         style: TextStyle(
          //           fontSize: 13,
          //           color: Color(0xff989898),
          //         ),
          //         overflow: TextOverflow.clip,
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 30,
      margin: const EdgeInsets.only(right: 8),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
