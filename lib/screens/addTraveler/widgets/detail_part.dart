import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';
import '../../../core/platform/device_info.dart';

class DetailPart extends StatelessWidget {
  const DetailPart({
    Key? key,
    required this.title,
    required this.description
  }) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return SizedBox(
      height:deviceType.isPhone?50: deviceType.isTablet? 100: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize:deviceType.isPhone?15:deviceType.isTablet? 22:null)
          ),
          const SizedBox(
            height: 10,
          ),
          Text(description , style: deviceType.isTablet?const TextStyle(fontWeight: FontWeight.bold, fontSize: 23) : null,)
        ],
      ),
    );
  }
}


