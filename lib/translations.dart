import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String parentKey, String nestedKey) {
    return _localizedValues[parentKey][nestedKey] ?? '$nestedKey' + 'not available';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent =
        await rootBundle.loadString("assets/langs/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = jsonDecode(jsonContent);
    _localizedValues = jsonMap.map((key, value) {
      return MapEntry(
          key, value); //not value.toString() so the value will be a map
    });
    return translations;
  }

  get currentLanguage => ui.window.locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'nl'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
