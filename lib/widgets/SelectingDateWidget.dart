import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

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
                onPressed: () {
                  // DateTimePicker(
                  //   type: DateTimePickerType.dateTimeSeparate,
                  //   dateMask: 'd MMM, yyyy',
                  //   initialValue: DateTime.now().toString(),
                  //   firstDate: DateTime(2000),
                  //   lastDate: DateTime(2100),
                  //   icon: Icon(Icons.event),
                  //   dateLabelText: 'Date',
                  //   timeLabelText: "Hour",
                  //   selectableDayPredicate: (date) {
                  //     // Disable weekend days to select from the calendar
                  //     if (date.weekday == 6 || date.weekday == 7) {
                  //       return false;
                  //     }
                  //
                  //     return true;
                  //   },
                  //   onChanged: (val) => print(val),
                  //   validator: (val) {
                  //     print(val);
                  //     return null;
                  //   },
                  //   onSaved: (val) => print(val),
                  // );
                },
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