import 'package:flutter/material.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:provider/provider.dart';

import '../../../core/platform/device_info.dart';
import '../../../widgets/UserTextInput.dart';
import '../payment_state.dart';

class BillingAddress extends StatelessWidget {
  const BillingAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentState paymentState = context.watch<PaymentState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Billing Address", style: deviceType.isTablet ? MyTextTheme.darkGreyBold30 : MyTextTheme.darkGreyBold22),
         SizedBox(
          height:deviceType.isTablet ? 20:10
        ),
        UserTextInput(
          controller: paymentState.addressC,
          hint: "Address",
          height:deviceType.isTablet ? 200:100,
          width: width,
          fontSize:deviceType.isTablet ? 25:17,
          errorText: "",
          isEmpty: false,
        ),
         SizedBox(
          height:deviceType.isTablet ? 20:10,
        ),
        UserTextInput(
          height:deviceType.isTablet ? 60:30,
          width: width,
          fontSize:deviceType.isTablet ? 25:17,
          controller: paymentState.billingAddressCardNumberC,
          hint: "Card Number",
          errorText: "",
          isEmpty: false,
        ),
         SizedBox(
          height:deviceType.isTablet ? 20:10,
        ),
        Row(
          children: [
            Expanded(
                child: UserTextInput(
              height:deviceType.isTablet ? 60:30,
              // width: Get.width,
              fontSize:deviceType.isTablet ? 25:17,
              controller: paymentState.countryC,
              hint: "Card Number",
              errorText: "",
              isEmpty: false,
            )),
             SizedBox(
              width: deviceType.isTablet ?10:5
            ),
            Expanded(
                child: UserTextInput(
              height: deviceType.isTablet ?60:30,
              // width: Get.width,
              fontSize: deviceType.isTablet ?25:17,
              controller: paymentState.provinceC,
              hint: "Province / State",
              errorText: "",
              isEmpty: false,
            )),
          ],
        ),
         SizedBox(
          height:deviceType.isTablet ? 20:10
        ),
        Row(
          children: [
            Expanded(
                child: UserTextInput(
              height:deviceType.isTablet ? 60:30,
              // width: Get.width,
              fontSize:deviceType.isTablet ? 25:17,
              controller: paymentState.cityC,
              hint: "City",
              errorText: "",
              isEmpty: false,
            )),
             SizedBox(
              width:deviceType.isTablet ? 10:5
            ),
            Expanded(
                child: UserTextInput(
              height:deviceType.isTablet ? 60:30,
              // width: Get.width,
              fontSize:deviceType.isTablet ? 25:17,
              controller: paymentState.postalC,
              hint: "Postal / Zip Code",
              errorText: "",
              isEmpty: false,
            )),
          ],
        ),
      ],
    );
  }
}
