import 'package:flutter/material.dart';

import '../../../widgets/LanguagePicker.dart';
import '../steps_controller.dart';
import '../steps_view.dart';
class TopOfPage extends StatelessWidget {
  const TopOfPage({
    Key? key,
    required this.height,
    required this.width,
    required this.stepsController,
    required this.isTabletMode,
  }) : super(key: key);

  final double height;
  final double width;
  final StepsController stepsController;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    String languageCode = "en";
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isTabletMode) AbomisLogo(),
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
