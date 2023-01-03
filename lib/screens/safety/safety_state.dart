
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SafetyState with ChangeNotifier {
  setState() => notifyListeners();

  List<bool> checkBoxesValue = <bool>[false, false, false];

  final List<String> policyWidgetText = [
    "In the past 10 days, I/we have not had a COVID-19 diagnosis and have not experienced the onset of any one of the primary symptoms of COVID-19.",
    "I/we have not been in close contact with someone who has COVID-19 in the past 10 days. EXCEPTION: I/we have been fully vaccinated for at least 2 weeks or have had COVID-19 within the last 90 days and fully recovered so that I/we are not contagious, and I/we remain symptom free.",
    "I/we will wear a face mask throughout the airport, in Delta Sky Clubs and onboard the aircraft, even if fully vaccinated, unless I meet the criteria for exemptions."
  ];
}
