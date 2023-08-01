import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/constants/assets.dart';
import '../../../core/utils/multi_languages.dart';
class PlaneWings extends StatelessWidget {
  const PlaneWings({
    Key? key,
    required this.planeBodyLength, required this.isTabletMode,
  }) : super(key: key);

  final double planeBodyLength;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
        // String languageCode = MultiLanguages.of(context)!.locale.languageCode;  //todo
    String languageCode = 'en';
    return Container(
      margin:isTabletMode?(languageCode == "en" ? EdgeInsets.only(left: 400 + planeBodyLength / 2) : EdgeInsets.only(right: 400 + planeBodyLength / 2)):( languageCode == "en" ? EdgeInsets.only(left: 400 + planeBodyLength / 2) : EdgeInsets.only(right: 400 + planeBodyLength / 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 400,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(AssetImages.airplaneWing, fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            width: 400,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(AssetImages.airplaneDownWing, fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }
}
