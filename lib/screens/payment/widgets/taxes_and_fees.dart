import 'package:flutter/material.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:online_check_in/screens/payment/payment_state.dart';
import 'package:provider/provider.dart';

import '../../../core/platform/device_info.dart';
import '../../../widgets/MtDottedLine.dart';

class TaxesAndFees extends StatelessWidget {
  const TaxesAndFees({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentState paymentState = context.watch<PaymentState>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Taxes & Fees".translate(context),
                style: deviceType.isTablet ? MyTextTheme.darkGreyW50030 : MyTextTheme.darkGreyW50022,
              ),
              Text(
                "\$ 0.00",
                style: deviceType.isTablet ? MyTextTheme.darkGreyBold30 : MyTextTheme.darkGreyBold22,
              ),
            ],
          ),
          SizedBox(height: deviceType.isTablet ? 10 : 5),
          const MyDottedLine(color: MyColors.white1, lineLength: double.infinity),
          SizedBox(height: deviceType.isTablet ? 10 : 5),
          Container(
            height:deviceType.isTablet? 200: 100,
            decoration: const BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: MyColors.white1,
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
                      (paymentState.taxes[index]["title"]! as String),
                      style: deviceType.isTablet ? MyTextTheme.darkGreyW50025 : MyTextTheme.darkGreyW50017,
                    ),
                    Text(
                      "\$ ${(paymentState.taxes[index]["price"]!).toStringAsFixed(2)}",
                      style: deviceType.isTablet ? MyTextTheme.darkGreyW50025 : MyTextTheme.darkGreyBold17,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: deviceType.isTablet ? 10 : 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total".translate(context),
                style: deviceType.isTablet ? MyTextTheme.darkGreyBold30 : MyTextTheme.darkGreyBold22,
              ),
              Text(
                "\$ ${paymentState.totalPrice.toStringAsFixed(2)}",
                style: deviceType.isTablet ? MyTextTheme.darkGreyBold30 : MyTextTheme.darkGreyBold22,
              ),
            ],
          ),
          Text(
            "Including taxes and fees".translate(context),
                       style: deviceType.isTablet ? MyTextTheme.darkGreyW50025 : MyTextTheme.darkGreyW50017,
          ),
        ],
      ),
    );
  }
}
