import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';

class DetailPart extends StatelessWidget {
  const DetailPart({
    Key? key,
    required this.title,
    required this.description, required this.isTabletMode,
  }) : super(key: key);
  final String title;
  final String description;
  final bool isTabletMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:isTabletMode? 100: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style:isTabletMode? TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 22):TextStyle(color: MyColors.black.withOpacity(0.5)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(description , style: isTabletMode? const TextStyle(fontWeight: FontWeight.bold, fontSize: 23) : null,)
        ],
      ),
    );
  }
}


