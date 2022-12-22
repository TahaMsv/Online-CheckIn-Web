import 'package:flutter/material.dart';
import 'CountryListPicker/country.dart';
import 'CountryListPicker/country_picker_dropdown.dart';
import 'CountryListPicker/utils/utils.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({
    Key? key,
    // required this.mainController,
    required this.width,
    this.initialValue = 'GB',
    this.textColor = Colors.black,
  }) : super(key: key);

  // final MainController mainController;   //todo add controller for changing language
  final double width;
  final String initialValue;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: CountryPickerDropdown(
        textColor: textColor,
        initialValue: initialValue,
        itemBuilder: _buildDropdownItem,
        // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('GB'),
        //
        // ],
        sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
        onValuePicked: (Country country) {
          // print("${country.name}");
          switch (country.languageCode) {
            case "en":
              // mainController.changeLanguage(Locale(country.languageCode, "US"));
              break;
            case "fa":
              // mainController.changeLanguage(Locale(country.languageCode, "IR"));
              break;
          }
        },
      ),
    );
  }
}

Widget _buildDropdownItem(Country country, Color textColor) => Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "+${country.phoneCode}(${country.isoCode})",
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
