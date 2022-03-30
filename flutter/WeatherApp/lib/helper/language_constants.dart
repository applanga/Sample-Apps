import 'package:flutter/material.dart';
import 'package:weather_sample/generated/applanga_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String language_code = 'languageCode';
// ignore: constant_identifier_names
const String country_code = 'countryCode';

Future<Locale> setLocale(String languageCode, String countryCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(language_code, languageCode);
  await _prefs.setString(country_code, countryCode);
  return Locale(languageCode, countryCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var languageCode = _prefs.getString(language_code) ??
      ApplangaLocalizations.supportedLocales[0].toString();

  var countryCode = _prefs.getString(country_code);
  return Locale(
    languageCode,
    countryCode,
  );
}
