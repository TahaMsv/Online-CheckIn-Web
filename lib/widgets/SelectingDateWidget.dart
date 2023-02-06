import 'package:flutter/material.dart';

// import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

import '../core/constants/ui.dart';

class SelectingDateWidget extends StatefulWidget {
  const SelectingDateWidget({
    Key? key,
    required this.hint,
    required this.updateDate,
    required this.index,
    required this.currDateTime,
    required this.isCurrDateEmpty,
    this.height = 40,
    this.width = 200,
     this.fontSize = 18,
  }) : super(key: key);

  final String hint;
  final Function updateDate;
  final int index;
  final DateTime currDateTime;
  final bool isCurrDateEmpty;
  final double height;
  final double width;
  final double fontSize;

  @override
  State<SelectingDateWidget> createState() => _SelectingDateWidgetState();
}

class _SelectingDateWidgetState extends State<SelectingDateWidget> {
  late DateTime currentDate;

  Future<void> _selectDate(BuildContext context) async {
    // final DateTime? pickedDate = await showDatePicker(context: context, initialDate: currentDate, firstDate: DateTime(1900), lastDate: DateTime(2050));
    // if (pickedDate != null && pickedDate != currentDate) {
    //   setState(() {
    //     currentDate = pickedDate;
    //     widget.updateDate(widget.index, currentDate);
    //   });
    // }
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: currentDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2023),
      dateFormat: "dd-M-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,

    );
    currentDate = datePicked!;
    widget.updateDate(widget.index, currentDate);
    setState(() {
    });
  }

  @override
  void initState() {
    currentDate = widget.currDateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.white1,
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
              child: widget.isCurrDateEmpty
                  ? Text(
                      widget.hint,
                      style: TextStyle(fontSize: widget.fontSize),
                    )
                  : Text(
                      DateFormat('yyyy-MM-dd').format(currentDate),
                      style: TextStyle(fontSize: widget.fontSize),
                    ),
            ),
            SizedBox(
              width: widget.fontSize + 20,
              height: widget.fontSize + 20,
              child: IconButton(
                onPressed: () => _selectDate(context),
                icon: Icon(
                  MenuIcons.iconCalendar,
                  color: MyColors.myBlue,
                  size: widget.fontSize ,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
