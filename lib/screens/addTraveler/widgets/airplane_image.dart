import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/ui.dart';

class AirplaneImage extends StatelessWidget {
  const AirplaneImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:MyColors.white1,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Image.asset(
              AssetImages.AIRPLANE_IMAGE,
              fit: BoxFit.fill,
              // height: 350,
            ),
          ),
        ],
      ),
    );
  }
}
