import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:weather_sample/models/measurement_unit.dart';
import 'package:weather_sample/screens/home_screen.dart';
import 'package:weather_sample/helper/language_constants.dart';
import 'package:applanga_flutter/applanga_flutter.dart';

import 'generated/applanga_localizations.dart';

InAppLocalhostServer localhostServer = InAppLocalhostServer();

Future main() async {
  await localhostServer.start();
  WidgetsFlutterBinding.ensureInitialized();

  Locale testLocale = await getLocale();

  runApp(MyApp(
    startupLocale: testLocale,
  ));
}

class MyApp extends StatefulWidget {
  final Locale? startupLocale;
  const MyApp({Key? key, this.startupLocale}) : super(key: key);

  static void setSettings(BuildContext context, Locale newLocale, String city,
      MeasurementUnit measurementUnit) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setSettings(newLocale, city, measurementUnit);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _currentLocale;
  late String city;
  late MeasurementUnit measurementUnits;

  @override
  void initState() {
    super.initState();
    _currentLocale =
        widget.startupLocale ?? ApplangaLocalizations.supportedLocales[0];
  }

  setSettings(Locale locale, String city, MeasurementUnit measurementUnit) {
    setState(() {
      _currentLocale = locale;
      city = city;
      measurementUnits = measurementUnit;
    });
  }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.startupLocale != null &&
        widget.startupLocale != oldWidget.startupLocale) {
      setState(() {
        _currentLocale = widget.startupLocale!;
      });
    }
  }

  @override
  void dispose() {
    localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ApplangaWidget(
      child: MaterialApp(
        localizationsDelegates: ApplangaLocalizations.localizationsDelegates,
        supportedLocales: ApplangaLocalizations.supportedLocales,
        locale: _currentLocale,
        home: ApplangaSplashScreen(
          currentLocale: _currentLocale,
        ),
      ),
    );
  }
}

class ApplangaSplashScreen extends StatefulWidget {
  final Locale currentLocale;
  const ApplangaSplashScreen({Key? key, required this.currentLocale})
      : super(key: key);

  @override
  State<ApplangaSplashScreen> createState() => _ApplangaSplashScreenState();
}

class _ApplangaSplashScreenState extends State<ApplangaSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return HomePage(
      city: 'New York',
      currentLanguage: widget.currentLocale,
      measurementUnit: MeasurementUnit.metric,
    );
  }
}
