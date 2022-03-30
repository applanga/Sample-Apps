import 'package:applanga_flutter/applanga_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_sample/models/measurement_unit.dart';
// import 'package:weather_sample/screens/about.dart';
import 'package:weather_sample/screens/forecast.dart';
import 'package:weather_sample/screens/home_screen.dart';
import 'package:weather_sample/screens/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.city,
    this.controller,
    required this.measurementUnit,
    required this.currentLanguage,
  }) : super(key: key);
  final String city;
  final Locale currentLanguage;
  final Future<WebViewController>? controller;
  final MeasurementUnit measurementUnit;

  @override
  Widget build(BuildContext context) => ApplangaScreenshotScope(
        child: Drawer(
          key: UniqueKey(),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 70,
                          child:
                              Image.asset('assets/images/weatherapplogo.png')),
                      Text(
                        AppLocalizations.of(context)!.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.drawer_subtitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ]),
              ),
              listTileWidget(
                icon: const Icon(Icons.home),
                text: AppLocalizations.of(context)!.home,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        city: city,
                        measurementUnit: measurementUnit,
                        currentLanguage: currentLanguage,
                      ),
                    ),
                  );
                },
              ),
              listTileWidget(
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  size: 24,
                ),
                text: AppLocalizations.of(context)!.daily_forecast,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForecastPage(
                        city: city,
                        measurementUnit: measurementUnit,
                        currentLanguage: currentLanguage,
                      ),
                    ),
                  );
                },
              ),
              // listTileWidget(
              //   icon: const Icon(Icons.info_outline_rounded),
              //   text: AppLocalizations.of(context)!.about,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => AboutPage(
              //                 city: city,
              //                 measurementUnit: measurementUnit,
              //               )),
              //     );
              //   },
              // ),
              listTileWidget(
                icon: const Icon(Icons.settings),
                text: AppLocalizations.of(context)!.settings,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(
                        city: city,
                        measurementUnit: measurementUnit,
                        currentLanguage: currentLanguage,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget listTileWidget({Icon? icon, String? text, Function()? onTap}) =>
      ListTile(
        leading: icon,
        title: Text(
          text!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        onTap: onTap,
      );
}
