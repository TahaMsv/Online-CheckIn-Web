import 'package:flutter/material.dart';

import 'package:online_check_in/initialize.dart';
import '../../../core/platform/device_info.dart';
import '../../../core/utils/multi_languages.dart';
import '../../../widgets/LanguagePicker.dart';
import '../../../widgets/my_drawer.dart';
import '../steps_controller.dart';
import '../steps_view_web.dart';

class TopOfPage extends StatelessWidget {
  const TopOfPage({
    Key? key,
    required this.height,
    required this.width,
    required this.scaffoldState,
  }) : super(key: key);

  final double height;
  final double width;
  final GlobalKey<ScaffoldState>? scaffoldState;

  @override
  Widget build(BuildContext context) {
    // String languageCode = MultiLanguages.of(context)!.locale.languageCode;  //todo
    String languageCode = 'en';
    final StepsController stepsController = getIt<StepsController>();
    DeviceType deviceType = DeviceInfo.deviceType(context);
    return SizedBox(
      height: height * 0.07,
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (deviceType == DeviceType.web || deviceType == DeviceType.desktop) const AbomisLogo(),
            if (deviceType == DeviceType.phone || deviceType == DeviceType.tablet)
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {scaffoldState!.currentState?.openDrawer();},
              ),
            LanguagePicker(
              width: 70,
              initialValue: languageCode == 'en' ? "GB" : "IR",
            ),
          ],
        ),
      ),
    );
  }
}
