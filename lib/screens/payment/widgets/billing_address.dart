import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/core/constants/ui.dart';
import 'package:online_check_in/core/utils/String_utilites.dart';
import 'package:provider/provider.dart';

import '../../../core/platform/device_info.dart';
import '../../../widgets/UserTextInput.dart';
import '../payment_state.dart';

class BillingAddress extends ConsumerWidget {
  const BillingAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PaymentState paymentState = ref.watch(paymentProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Billing Address".translate(context), style: deviceType.isTablet ? MyTextTheme.darkGreyBold30 : MyTextTheme.darkGreyBold22),
        SizedBox(height: deviceType.isTablet ? 20 : 10),
        UserTextInput(
          controller: paymentState.addressC,
          hint: "Address".translate(context),
          height: deviceType.isTablet ? 200 : 100,
          width: width,
          fontSize: deviceType.isTablet ? 25 : 15,
          errorText: "",
          isEmpty: false,
        ),
        SizedBox(
          height: deviceType.isTablet ? 20 : 10,
        ),
        UserTextInput(
          height: deviceType.isTablet ? 60 : 30,
          width: width,
          fontSize: deviceType.isTablet ? 25 : 15,
          controller: paymentState.billingAddressCardNumberC,
          hint: "Card Number".translate(context),
          errorText: "",
          isEmpty: false,
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
              controller: paymentState.countryC,
              hint: "Card Number".translate(context),
              errorText: "",
              isEmpty: false,
            )),
            SizedBox(width: deviceType.isTablet ? 10 : 5),
            Expanded(
                child: UserTextInput(
              height: deviceType.isTablet ? 60 : 30,
              // width: Get.width,
              fontSize: deviceType.isTablet ? 25 : 15,
              controller: paymentState.provinceC,
              hint: "Province / State".translate(context),
              errorText: "",
              isEmpty: false,
            )),
          ],
        ),
        SizedBox(height: deviceType.isTablet ? 20 : 10),
        Row(
          children: [
            Expanded(
                child: UserTextInput(
              height: deviceType.isTablet ? 60 : 30,
              // width: Get.width,
              fontSize: deviceType.isTablet ? 25 : 15,
              controller: paymentState.cityC,
              hint: "City".translate(context),
              errorText: "",
              isEmpty: false,
            )),
            SizedBox(width: deviceType.isTablet ? 10 : 5),
            Expanded(
                child: UserTextInput(
              height: deviceType.isTablet ? 60 : 30,
              // width: Get.width,
              fontSize: deviceType.isTablet ? 25 : 15,
              controller: paymentState.postalC,
              hint: "Postal / Zip Code".translate(context),
              errorText: "",
              isEmpty: false,
            )),
          ],
        ),
      ],
    );
  }
}
