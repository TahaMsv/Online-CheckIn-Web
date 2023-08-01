import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';

class AirplaneImage extends StatelessWidget {
  const AirplaneImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: MyColors.white1,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: deviceType.isPhone ? width * 0.92 : null,
              // height: deviceType.isPhone ? 100 : null,
              // padding: EdgeInsets.symmetric(horizontal: deviceType.isPhone ? 0 : 30.0),
              child: Center(
                child: Image.asset(
                  AssetImages.airplaneImage,
                  fit: BoxFit.fill,

                  // height: 350,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
