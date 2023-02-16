import 'package:flutter/material.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';
import '../../../widgets/UserTextInput.dart';
import '../payment_state.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MainModel model = context.watch<MainModel>();
    PaymentState paymentState = context.watch<PaymentState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Card Info".translate(context),
          style: deviceType.isTablet ? MyTextTheme.darkGreyBold30 : MyTextTheme.darkGreyBold22,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: const [
            CardImage(
              imagePath: AssetImages.amexCard,
            ),
            CardImage(imagePath: AssetImages.discoverCard),
            CardImage(imagePath: AssetImages.visaCard),
            CardImage(imagePath: AssetImages.card4),
          ],
        ),
        SizedBox(
          height: deviceType.isTablet ? 20 : 15,
        ),
        UserTextInput(
          height: deviceType.isTablet ? 60 : 30,
          width: width,
          fontSize: deviceType.isTablet ? 25 : 15,
          controller: paymentState.cardHolderNameC,
          hint: "Cardholder Name".translate(context),
          errorText: "",
          isEmpty: false,
        ),
        SizedBox(height: deviceType.isTablet ? 20 : 10),
        UserTextInput(
          height: deviceType.isTablet ? 60 : 30,
          width: width,
          fontSize: deviceType.isTablet ? 25 : 15,
          controller: paymentState.cardNumberC,
          hint: "Card Number".translate(context),
          errorText: "",
          isEmpty: false,
        ),
        SizedBox(height: deviceType.isTablet ? 20 : 10),
        Row(
          children: [
            Expanded(
                child: UserTextInput(
              height: deviceType.isTablet ? 60 : 30,
              // width: Get.width,
              fontSize: deviceType.isTablet ? 25 : 15,
              controller: paymentState.expiryMonthC,
              hint: "Expiry Month".translate(context),
              errorText: "",
              isEmpty: false,
            )),
            SizedBox(
              width: deviceType.isTablet ? 10 : 5,
            ),
            Expanded(
                child: UserTextInput(
              height: deviceType.isTablet ? 60 : 30,
              // width: Get.width,
              fontSize: deviceType.isTablet ? 25 : 15,
              controller: paymentState.expiryYearC,
              hint: "Expiry Year".translate(context),
              errorText: "",
              isEmpty: false,
            )),
          ],
        ),
        SizedBox(
          height: deviceType.isTablet ? 20 : 10,
        ),
        Row(
          children: [
            Expanded(
                child: UserTextInput(
              height: deviceType.isTablet ? 60 : 30,
              // width: Get.width,
              fontSize: deviceType.isTablet ? 25 : 15,
              controller: paymentState.cvv2C,
              hint: "CVV2",
              errorText: "",
              isEmpty: false,
            )),
            SizedBox(
              width: deviceType.isTablet ? 10 : 5,
            ),
            Expanded(
              child: Text(
                "3 or 4 digits usually found on the signature strip".translate(context),
                style: TextStyle(
                  fontSize: deviceType.isTablet ? 20 : 15,
                  color: MyColors.grey,
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
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return Container(
      width: deviceType.isPhone ? 50 : 75,
      height: deviceType.isPhone ? 30 : 50,
      margin: EdgeInsets.only(right: deviceType.isPhone ? 5 : 8),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
