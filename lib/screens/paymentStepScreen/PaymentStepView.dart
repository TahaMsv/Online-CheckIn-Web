import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/UserTextInput.dart';
import '../../screens/paymentStepScreen/PaymentStepController.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

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
                TaxesAndFees()
              ],
            )
          ],
        ));
  }
}

class TaxesAndFees extends StatelessWidget {
  const TaxesAndFees({
    Key? key,
  }) : super(key: key);

  static const taxes = [
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
    {"title": "Goods & Services Tax (GST)", "price": "\$ 6.40"},
  ];

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
                "\$ 6.40",
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
              itemCount: taxes.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taxes[index]["title"]!,
                      style: TextStyle(color: Color(0xff424242), fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      taxes[index]["price"]!,
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
                "\$ 6.40",
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
            isEmpty: true,
          ),
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            controller: myPaymentStepController.billingAddressCardNumberC,
            hint: "Card Number",
            errorText: "",
            isEmpty: true,
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
                isEmpty: true,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.provinceC,
                hint: "Province / State",
                errorText: "",
                isEmpty: true,
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
                isEmpty: true,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.postalC,
                hint: "Postal / Zip Code",
                errorText: "",
                isEmpty: true,
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
              CardImage(),
              CardImage(),
              CardImage(),
              CardImage(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            controller: myPaymentStepController.cardHolderNameC,
            hint: "Cardholder Name",
            errorText: "",
            isEmpty: true,
          ),
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            controller: myPaymentStepController.cardNumberC,
            hint: "Card Number",
            errorText: "",
            isEmpty: true,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.expiryMonthC,
                hint: "Expiry Month",
                errorText: "",
                isEmpty: true,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                controller: myPaymentStepController.expiryYearC,
                hint: "Expiry Year",
                errorText: "",
                isEmpty: true,
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
                controller: myPaymentStepController.cvv2C,
                hint: "CVV2",
                errorText: "",
                isEmpty: true,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "3 or 4 digits usually found on the signature strip",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff989898),
                  ),
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 30,
      color: Colors.red,
      margin: EdgeInsets.only(right: 8),
    );
  }
}
