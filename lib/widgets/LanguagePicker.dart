import 'package:flutter/material.dart';
import '../core/utils/MultiLanguages.dart';
import '../core/utils/country_utils/country_utility.dart';
import '../my_app.dart';
import 'CountryListPicker/country.dart';
import 'CountryListPicker/country_picker_dropdown.dart';

class LanguagePicker extends StatefulWidget {
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
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: CountryPickerDropdown(
        textColor: widget.textColor,
        initialValue: widget.initialValue,
        itemBuilder: _buildDropdownItem,
        // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('GB'),
        //
        // ],
        sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
        onValuePicked: (Country country) {
          // print("${country.name}");
          MultiLanguages multiLanguages = MultiLanguages();
          switch (country.languageCode) {
            case "en":
              multiLanguages.setLocale(context, Locale('en', ''));
              // setState(() {
              //   LanguageTranslation.load(
              //     Locale('en', ''),
              //   );
              // });

              // mainController.changeLanguage(Locale(country.languageCode, "US"));
              break;
            case "fa":
              multiLanguages.setLocale(context, Locale.fromSubtags(languageCode: 'fa'));
              // setState(() {
              //   LanguageTranslation.load(
              //     Locale('fa', ''),
              //   );
              // });

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
