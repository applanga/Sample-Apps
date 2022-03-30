import 'package:applanga_flutter/applanga_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_sample/api/weather_map_api.dart';
import 'package:weather_sample/generated/applanga_localizations.dart';
import 'package:weather_sample/helper/language_constants.dart';
import 'package:weather_sample/models/measurement_unit.dart';
import 'package:weather_sample/widgets/drawer.dart';
import '../main.dart';
import 'home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  final String city;
  final MeasurementUnit measurementUnit;
  final Locale currentLanguage;

  const SettingsPage({
    Key? key,
    required this.city,
    required this.measurementUnit,
    required this.currentLanguage,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SettingsPageState createState() => _SettingsPageState(
        city,
        measurementUnit,
        currentLanguage,
      );
}

class _SettingsPageState extends State<SettingsPage>
    with ApplangaScreenshotScopeMixin {
  _SettingsPageState(
    this.city,
    this.measurementUnit,
    this.currentLanguage,
  );

  final locationController = TextEditingController();
  String city;
  MeasurementUnit measurementUnit;

  Locale currentLanguage;
  var weatherMapApi = WeatherMapApi();

  Future<void> _changeSettings(Locale language) async {
    Locale _currentLocale =
        await setLocale(language.languageCode, (language.countryCode ?? ""));
    MyApp.setSettings(context, _currentLocale, city, measurementUnit);
  }

  @override
  void initState() {
    super.initState();
    locationController.text = city;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(
        city: city,
        measurementUnit: measurementUnit,
        currentLanguage: currentLanguage,
      ),
      body: buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      );

  Widget buildBody() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationInput(),
              const Padding(padding: EdgeInsets.all(20)),
              _buildMeasurementUnits(),
              const Padding(padding: EdgeInsets.all(20)),
              _buildAppLanguageDropdown(),
              const Padding(padding: EdgeInsets.all(20)),
            ],
          ),
        ),
        _buildSaveButton(),
        // _buildDraftModeButton(),
      ],
    );
  }

  Widget _buildLocationInput() => TextFormField(
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.location,
          border: const UnderlineInputBorder(),
        ),
        controller: locationController,
        onSaved: (newValue) => locationController.text,
        onFieldSubmitted: (value) {
          city == value;
        },
      );

  Widget _buildMeasurementUnits() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.measurement_units,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.metric,
            ),
            leading: Radio<MeasurementUnit>(
              value: MeasurementUnit.metric,
              groupValue: measurementUnit,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    measurementUnit = value;
                  }
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.imperial,
            ),
            leading: Radio<MeasurementUnit>(
              value: MeasurementUnit.imperial,
              groupValue: measurementUnit,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    measurementUnit = value;
                  }
                });
              },
            ),
          ),
        ],
      );

  Widget _buildAppLanguageDropdown() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.app_language,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          DropdownButton<Locale>(
            value: currentLanguage,
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),
            items: ApplangaLocalizations.supportedLocales
                .map<DropdownMenuItem<Locale>>(
                  (e) => DropdownMenuItem<Locale>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          languageFullname(e),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (Locale? language) {
              setState(() {
                currentLanguage = language!;
              });
            },
          ),
        ],
      );

  Widget _buildSaveButton() => Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              city = locationController.text;
              _changeSettings(currentLanguage);
              weatherMapApi.getCurrentWeatherData(city, measurementUnit);
              weatherMapApi.getForecast(measurementUnit, city);
              Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    city: city,
                    measurementUnit: measurementUnit,
                    currentLanguage: currentLanguage,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.save_changes,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      );

  languageFullname(Locale locale) {
    if (locale == const Locale('en')) {
      return 'English';
    } else if (locale == const Locale('de')) {
      return 'German';
    } else if (locale == const Locale('de', 'AT')) {
      return 'Austrian German';
    } else if (locale == const Locale('fr')) {
      return 'French';
    } else if (locale == const Locale('ru')) {
      return 'Russian';
    } else {
      return locale.toString();
    }
  }
}
