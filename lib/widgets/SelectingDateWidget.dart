import 'package:flutter/material.dart';
class SelectingDateWidget extends StatelessWidget {
  const SelectingDateWidget({
    Key? key, required this.hint,
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeaeaea),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 140,
              child: Text(hint),
            ),
            Container(
              width: 20,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xff4d6fff),
                  size: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}