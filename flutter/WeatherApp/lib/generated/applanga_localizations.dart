import 'package:applanga_flutter/applanga_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore_for_file: non_constant_identifier_names
class ApplangaLocalizations extends AppLocalizations {
  final AppLocalizations _original;

  ApplangaLocalizations(_locale)
      : _original = lookupAppLocalizations(_locale),
        super(_locale.toString());

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _ApplangaLocalizationsDelegate();
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
  static const List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;

  @override
  String get title =>
      ApplangaFlutter.instance.getIcuString('title') ?? _original.title;

  @override
  String get description =>
      ApplangaFlutter.instance.getIcuString('description') ??
      _original.description;

  @override
  String get feels_like =>
      ApplangaFlutter.instance.getIcuString('feels_like') ??
      _original.feels_like;

  @override
  String get wind =>
      ApplangaFlutter.instance.getIcuString('wind') ?? _original.wind;

  @override
  String get humidity =>
      ApplangaFlutter.instance.getIcuString('humidity') ?? _original.humidity;

  @override
  String get pressure =>
      ApplangaFlutter.instance.getIcuString('pressure') ?? _original.pressure;

  @override
  String get daily_forecast =>
      ApplangaFlutter.instance.getIcuString('daily_forecast') ??
      _original.daily_forecast;

  @override
  String get drawer_subtitle =>
      ApplangaFlutter.instance.getIcuString('drawer_subtitle') ??
      _original.drawer_subtitle;

  @override
  String get home =>
      ApplangaFlutter.instance.getIcuString('home') ?? _original.home;

  @override
  String get about =>
      ApplangaFlutter.instance.getIcuString('about') ?? _original.about;

  @override
  String get settings =>
      ApplangaFlutter.instance.getIcuString('settings') ?? _original.settings;

  @override
  String get location =>
      ApplangaFlutter.instance.getIcuString('location') ?? _original.location;

  @override
  String get measurement_units =>
      ApplangaFlutter.instance.getIcuString('measurement_units') ??
      _original.measurement_units;

  @override
  String get metric =>
      ApplangaFlutter.instance.getIcuString('metric') ?? _original.metric;

  @override
  String get imperial =>
      ApplangaFlutter.instance.getIcuString('imperial') ?? _original.imperial;

  @override
  String get app_language =>
      ApplangaFlutter.instance.getIcuString('app_language') ??
      _original.app_language;

  @override
  String get save_changes =>
      ApplangaFlutter.instance.getIcuString('save_changes') ??
      _original.save_changes;

  @override
  String get monday =>
      ApplangaFlutter.instance.getIcuString('monday') ?? _original.monday;

  @override
  String get tuesday =>
      ApplangaFlutter.instance.getIcuString('tuesday') ?? _original.tuesday;

  @override
  String get wednesday =>
      ApplangaFlutter.instance.getIcuString('wednesday') ?? _original.wednesday;

  @override
  String get thursday =>
      ApplangaFlutter.instance.getIcuString('thursday') ?? _original.thursday;

  @override
  String get friday =>
      ApplangaFlutter.instance.getIcuString('friday') ?? _original.friday;

  @override
  String get saturday =>
      ApplangaFlutter.instance.getIcuString('saturday') ?? _original.saturday;

  @override
  String get sunday =>
      ApplangaFlutter.instance.getIcuString('sunday') ?? _original.sunday;
}

class _ApplangaLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _ApplangaLocalizationsDelegate();

  static const _keys = [
    'title',
    'description',
    'feels_like',
    'wind',
    'humidity',
    'pressure',
    'daily_forecast',
    'drawer_subtitle',
    'home',
    'about',
    'settings',
    'location',
    'measurement_units',
    'metric',
    'imperial',
    'app_language',
    'save_changes',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  static const _languages = ['en', 'de', 'fr'];

  @override
  Future<AppLocalizations> load(Locale locale) async {
    var result = ApplangaLocalizations(locale);
    await ApplangaFlutter.instance
        .setMetaData(locale, 'en', _keys, languages: _languages);
    await ApplangaFlutter.instance.loadLocaleAndUpdate(locale);
    return result;
  }

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.delegate.isSupported(locale);

  @override
  bool shouldReload(_ApplangaLocalizationsDelegate old) => false;
}
