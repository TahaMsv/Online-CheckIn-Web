import 'package:flutter/material.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/UserTextInput.dart';
import '../../screens/paymentStepScreen/PaymentStepController.dart';
import '../../widgets/StepsScreenTitle.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class PaymentStepTabletView extends StatelessWidget {
  final PaymentStepController myPaymentStepController;

  PaymentStepTabletView(MainModel model) : myPaymentStepController = Get.put(PaymentStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;
    myPaymentStepController.initPlatformStateForUriUniLinks();
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
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Pay with credit card, Visa or debit or Mastercard debit".tr,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TaxesAndFees(myPaymentStepController: myPaymentStepController),
                  SizedBox(
                    height: 30,
                  ),
                  CardInfo(
                    myPaymentStepController: myPaymentStepController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    height: 5,
                    color: Color(0xffefefef),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BillingAddress(
                    myPaymentStepController: myPaymentStepController,
                  ),
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
                "Taxes & Fees".tr,
                style: TextStyle(color: Color(0xff424242), fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Text(
                "\$ 0.00",
                style: TextStyle(color: Color(0xff424242), fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          MyDottedLine(
            color: Color(0xffeaeaea),
            lineLength: double.infinity,
          ),
          SizedBox(
            height: 10,
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
                      (myPaymentStepController.taxes[index]["title"]! as String).tr,
                      style: TextStyle(color: Color(0xff424242), fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$ ${(myPaymentStepController.taxes[index]["price"]!).toStringAsFixed(2)}",
                      style: TextStyle(color: Color(0xff424242), fontSize: 25, fontWeight: FontWeight.bold),
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total".tr,
                style: TextStyle(color: Color(0xff424242), fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ ${myPaymentStepController.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(color: Color(0xff48c0a2), fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            "Including taxes and fees".tr,
            style: TextStyle(color: Color(0xff424242), fontSize: 25),
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
            "Billing Address".tr,
            style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 35),
          ),
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            controller: myPaymentStepController.addressC,
            hint: "Address".tr,
            height: 200,
            width: Get.width,
            fontSize: 25,
            errorText: "",
            isEmpty: false,
          ),
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            height: 60,
            width: Get.width,
            fontSize: 25,
            controller: myPaymentStepController.billingAddressCardNumberC,
            hint: "Card Number".tr,
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
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: myPaymentStepController.countryC,
                hint: "Card Number".tr,
                errorText: "",
                isEmpty: false,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: myPaymentStepController.provinceC,
                hint: "Province / State".tr,
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
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: myPaymentStepController.cityC,
                hint: "City".tr,
                errorText: "",
                isEmpty: false,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: myPaymentStepController.postalC,
                hint: "Postal / Zip Code".tr,
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
    // MainModel model = context.watch<MainModel>();
    return Container(
      width: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Info".tr,
            style: TextStyle(color: Color(0xff424242), fontWeight: FontWeight.bold, fontSize: 35),
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
            height: 60,
            width: Get.width,
            fontSize: 25,
            controller: myPaymentStepController.cardHolderNameC,
            hint: "Cardholder Name".tr,
            errorText: "",
            isEmpty: false,
          ),
          SizedBox(
            height: 20,
          ),
          UserTextInput(
            height: 60,
            width: Get.width,
            fontSize: 25,
            controller: myPaymentStepController.cardNumberC,
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
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: myPaymentStepController.expiryMonthC,
                hint: "Expiry Month",
                errorText: "",
                isEmpty: false,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UserTextInput(
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: myPaymentStepController.expiryYearC,
                hint: "Expiry Year",
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
                height: 60,
                // width: Get.width,
                fontSize: 25,
                controller: myPaymentStepController.cvv2C,
                hint: "CVV2",
                errorText: "",
                isEmpty: false,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
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
          SizedBox(
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
      margin: EdgeInsets.only(right: 8),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
