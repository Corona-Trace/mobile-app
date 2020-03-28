import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {

  static final AppLocalization _singleton = new AppLocalization._internal();
  AppLocalization._internal();
  static AppLocalization get instance => _singleton;

  Map<dynamic, dynamic> _localisedValues;
  Map<dynamic, dynamic> _englishValues;

  Future<AppLocalization> load(Locale locale) async {
    String jsonContent =
      await rootBundle.loadString("assets/locales/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    if(locale.languageCode != 'en') {
      String jsonEnglishContent =
      await rootBundle.loadString("assets/locales/en.json");
    _englishValues = json.decode(jsonEnglishContent);
    }
    
    return this;
  }

  static String text(String key) {
    return instance._localisedValues[key] ?? instance._englishValues[key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale)  {
    return AppLocalization.instance.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}