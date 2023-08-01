import 'multi_languages.dart';
import 'package:flutter/material.dart';

extension Extension on String {
  String translate(BuildContext context) {
    // return MultiLanguages.translate(context, this);
    return this;
    return "MultiLanguages.translate(context, this)"; //todo
  }
}
