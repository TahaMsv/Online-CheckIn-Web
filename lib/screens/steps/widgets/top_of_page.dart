import 'package:flutter/material.dart';

import '../../../core/dependency_injection.dart';
import '../../../core/platform/device_info.dart';
import '../../../widgets/LanguagePicker.dart';
import '../steps_controller.dart';
import '../steps_view_web.dart';

class TopOfPage extends StatelessWidget {
  const TopOfPage({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    final StepsController stepsController = getIt<StepsController>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (deviceType == DeviceType.web || deviceType == DeviceType.desktop) const AbomisLogo(),
            LanguagePicker(
              width: 200,
              initialValue: languageCode == 'en' ? "GB" : "IR",
            ),
          ],
        ),
      ),
    );
  }
}
