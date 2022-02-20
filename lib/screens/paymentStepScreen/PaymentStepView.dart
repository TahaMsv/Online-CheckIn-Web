import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/UserTextInput.dart';
import '../../screens/paymentStepScreen/PaymentStepController.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';

class PaymentStepView extends StatelessWidget {
  final PaymentStepController myPaymentStepController;

  PaymentStepView(MainModel model) : myPaymentStepController = Get.put(PaymentStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            StepsScreenTitle(
              title: "Payment",
              description: "Pay with credit card, Visa or debit or Mastercard debit",
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardInfo(
                      myPaymentStepController: myPaymentStepController,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 2,
                      height: 300,
                      color: Color(0xffefefef),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    BillingAddress(
                      myPaymentStepController: myPaymentStepController,
                    ),
                  ],
                ),
                Obx(
                  () => TaxesAndFees(myPaymentStepController: myPaymentStepController),
                ),
              ],
            )
          ],
        ));
  }
}

class TaxesAndFees extends StatelessWidget {
  const TaxesAndFees({
    Key? key,
    required this.myPaymentStepController,
  }) : super(key: key);

  final PaymentStepController myPaymentStepController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Taxes & Fees",
                style: TextStyle(color: Color(0xff424242), fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(
                "\$ 0.00",
                style: TextStyle(color: Color(0xff424242), fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          MyDottedLine(
            color: Color(0xffeaeaea),
            lineLength: double.infinity,
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: myPaymentStepController.taxes.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      myPaymentStepController.taxes[index]["title"]!,
                      style: TextStyle(color: Color(0xff424242), fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$ ${(myPaymentStepController.taxes[index]["price"]! as double).toStringAsFixed(2)}",
                      style: TextStyle(color: Color(0xff424242), fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: Color(0xffeaeaea),
                  width: 2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(color: Color(0xff424242), fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ ${myPaymentStepController.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(color: Color(0xff48c0a2), fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            "Including taxes and fees",
            style: TextStyle(color: Color(0xff424242), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class BillingAddress extends StatelessWidget {
  const BillingAddress({
    Key? key,
    required this.myPaymentStepController,
  }) : super(key: key);
  final PaymentStepController myPaymentStepController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Billing Address",
            style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          UserTextInput(
            controller: myPaymentStepController.addressC,
            hint: "Address",
            height: 90,
            errorText: "",
            isEmpty: false,
          ),
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            controller: myPaymentStepController.billingAddressCardNumberC,
            hint: "Card Number",
            errorText: "",
            isEmpty: false,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.countryC,
                hint: "Card Number",
                errorText: "",
                isEmpty: false,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.provinceC,
                hint: "Province / State",
                errorText: "",
                isEmpty: false,
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.cityC,
                hint: "City",
                errorText: "",
                isEmpty: false,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.postalC,
                hint: "Postal / Zip Code",
                errorText: "",
                isEmpty: false,
              )),
            ],
          ),
        ],
      ),
      width: 380,
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
    required this.myPaymentStepController,
  }) : super(key: key);
  final PaymentStepController myPaymentStepController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Info",
            style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
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
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            controller: myPaymentStepController.cardHolderNameC,
            hint: "Cardholder Name",
            errorText: "",
            isEmpty: false,
          ),
          SizedBox(
            height: 20,
          ),
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
          SizedBox(
            height: 40,
            child: CardField(
              onCardChanged: (card) {
                print(card);
              },
            ),
          ),
          SizedBox(
            height: 40,
            width: 375,
            child: TextButton(
              onPressed: () async {
                // create payment method
                final paymentMethod = await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
                String stripeID = paymentMethod.id;
                print(stripeID);
              },
              child: Text('pay'),
            ),
          )
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
      margin: EdgeInsets.only(right: 8),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
