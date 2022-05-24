import 'package:flutter/material.dart';
// import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:onlinecheckin/utility/Constants.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class SelectingDateWidget extends StatefulWidget {
  const SelectingDateWidget({
    Key? key,
    required this.hint,
    required this.updateDate,
    required this.index,
    required this.currDateTime,
    required this.isCurrDateEmpty,
  }) : super(key: key);

  final String hint;
  final Function updateDate;
  final int index;
  final DateTime currDateTime;
  final bool isCurrDateEmpty;

  @override
  State<SelectingDateWidget> createState() => _SelectingDateWidgetState();
}

class _SelectingDateWidgetState extends State<SelectingDateWidget> {
  late DateTime currentDate;

  Future<void> _selectDate(BuildContext context) async {
    // final DateTime? pickedDate = await showDatePicker(context: context, initialDate: currentDate, firstDate: DateTime(1900), lastDate: DateTime(2050));
    // if (pickedDate != null && pickedDate != currentDate)
    //   setState(() {
    //     currentDate = pickedDate;
    //     widget.updateDate(widget.index, currentDate);
    //   });
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(1994),
      firstDate: DateTime(1960),
      lastDate: DateTime(2012),
      dateFormat: "dd-M-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    currentDate = datePicked!;
    widget.updateDate(widget.index, currentDate);
  }

  @override
  void initState() {
    currentDate = widget.currDateTime;
    super.initState();
  }

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
              child: widget.isCurrDateEmpty ? Text(widget.hint) : Text(DateFormat('yyyy-MM-dd').format(currentDate)),
            ),
            Container(
              width: 20,
              child: IconButton(
                onPressed: () => _selectDate(context),
                icon: Icon(
                  MenuIcons.iconCalendar,
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
