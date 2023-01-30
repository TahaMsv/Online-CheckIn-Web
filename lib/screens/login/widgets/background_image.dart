import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          AssetImages.abomisBackGround,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
