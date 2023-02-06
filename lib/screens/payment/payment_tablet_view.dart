import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_check_in/screens/payment/payment_controller.dart';
import 'package:online_check_in/screens/payment/payment_state.dart';
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
                    title: "Payment".tr,
                    fontSize: 45,
                    description: "",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Pay with credit card, Visa or debit or Mastercard debit".tr,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TaxesAndFees(),
                  const SizedBox(
                    height: 30,
                  ),
                  const CardInfo(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    height: 5,
                    color: const Color(0xffefefef),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const BillingAddress(),
                ],
              ),
            )
          ],
        ));
  }
}

class TaxesAndFees extends StatelessWidget {
  const TaxesAndFees({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    PaymentState paymentState = context.watch<PaymentState>();
    return Container(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Taxes & Fees".tr,
                style: const TextStyle(color: Color(0xff424242), fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const Text(
                "\$ 0.00",
                style: TextStyle(color: Color(0xff424242), fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const MyDottedLine(
            color: Color(0xffeaeaea),
            lineLength: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
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
                    Text(
                      (paymentState.taxes[index]["title"]! as String).tr,
                      style: const TextStyle(color: Color(0xff424242), fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$ ${(paymentState.taxes[index]["price"]!).toStringAsFixed(2)}",
                      style: const TextStyle(color: Color(0xff424242), fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total".tr,
                style: const TextStyle(color: Color(0xff424242), fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ ${paymentState.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(color: Color(0xff48c0a2), fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            "Including taxes and fees".tr,
            style: const TextStyle(color: Color(0xff424242), fontSize: 25),
          ),
        ],
      ),
    );
  }
}

class BillingAddress extends StatelessWidget {
  const BillingAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentState paymentState = context.watch<PaymentState>();
    return Container(
      width: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Billing Address".tr,
            style: const TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 35),
          ),
          const SizedBox(
            height: 20,
          ),
          UserTextInput(
            controller: paymentState.addressC,
            hint: "Address".tr,
            height: 200,
            width: Get.width,
            fontSize: 25,
            errorText: "",
            isEmpty: false,
          ),
          const SizedBox(
            height: 20,
          ),
          UserTextInput(
            height: 60,
            width: Get.width,
            fontSize: 25,
            controller: paymentState.billingAddressCardNumberC,
            hint: "Card Number".tr,
            errorText: "",
            isEmpty: false,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: paymentState.countryC,
                hint: "Card Number".tr,
                errorText: "",
                isEmpty: false,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: paymentState.provinceC,
                hint: "Province / State".tr,
                errorText: "",
                isEmpty: false,
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: paymentState.cityC,
                hint: "City".tr,
                errorText: "",
                isEmpty: false,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: paymentState.postalC,
                hint: "Postal / Zip Code".tr,
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

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MainModel model = context.watch<MainModel>();
    PaymentState paymentState = context.watch<PaymentState>();
    return Container(
      width: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Info".tr,
            style: const TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 35),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              CardImage(
                imagePath: 'assets/images/Amex-card.png',
              ),
              CardImage(
                imagePath: 'assets/images/Discover-card.png',
              ),
              CardImage(
                imagePath: 'assets/images/Visa-card.png',
              ),
              CardImage(
                imagePath: 'assets/images/card4.png',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          UserTextInput(
            height: 60,
            width: Get.width,
            fontSize: 25,
            controller: paymentState.cardHolderNameC,
            hint: "Cardholder Name".tr,
            errorText: "",
            isEmpty: false,
          ),
          const SizedBox(
            height: 20,
          ),
          UserTextInput(
            height: 60,
            width: Get.width,
            fontSize: 25,
            controller: paymentState.cardNumberC,
            hint: "Card Number",
            errorText: "",
            isEmpty: false,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: paymentState.expiryMonthC,
                hint: "Expiry Month",
                errorText: "",
                isEmpty: false,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: paymentState.expiryYearC,
                hint: "Expiry Year",
                errorText: "",
                isEmpty: false,
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: paymentState.cvv2C,
                hint: "CVV2",
                errorText: "",
                isEmpty: false,
              )),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text(
                  "3 or 4 digits usually found on the signature strip",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff989898),
                  ),
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // SizedBox(
          //   height: 40,
          //   width: 375,
          //   child: TextButton(
          //     onPressed: () async {
          //       // create payment method
          //       // final paymentMethod = await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
          //       // String stripeID = paymentMethod.id;
          //       // print(stripeID);
          //       // if (stripeID != null && !model.requesting) {
          //       myPaymentStepController.pay("stripeID");
          //       // }
          //     },
          //     child: Text('pay'.tr),
          //   ),
          // )
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
      width: 75,
      height: 50,
      margin: const EdgeInsets.only(right: 8),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
