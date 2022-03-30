import 'package:applanga_flutter/applanga_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_sample/api/weather_map_api.dart';
import 'package:weather_sample/models/current/current_weather_model.dart';
import 'package:weather_sample/models/measurement_unit.dart';
import 'package:weather_sample/widgets/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.city,
      required this.measurementUnit,
      required this.currentLanguage})
      : super(key: key);
  final String city;
  final MeasurementUnit measurementUnit;
  final Locale currentLanguage;
  @override
  State<HomePage> createState() => _HomePageState();
}

bool isLoading = false;

class _HomePageState extends State<HomePage> with ApplangaScreenshotScopeMixin {
  final int selectedIndex = 0;
  final _homeKey = GlobalKey<ScaffoldState>();

  late CurrentWeatherModel? _weather;
  var weatherMapApi = WeatherMapApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeKey,
      backgroundColor: Colors.blue,
      appBar: _buildAppBar(),
      drawer: MyDrawer(
        city: widget.city,
        measurementUnit: widget.measurementUnit,
        currentLanguage: widget.currentLanguage,
      ),
      body: FutureBuilder<CurrentWeatherModel>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _weather = snapshot.data;
            if (_weather == null) {
              return const Text('Error getting weather!');
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCurrentWeatherInformation(_weather!),
                    _currentWeatherDetails(_weather!),
                  ],
                ),
              );
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
        },
        future: weatherMapApi.getCurrentWeatherData(
            widget.city, widget.measurementUnit),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.title,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      );

  Widget _buildCurrentWeatherInformation(CurrentWeatherModel _weather) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(bottom: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
              child: Text(
                widget.city,
                key: const Key('cityName'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            getWeatherIcon(
              _weather.icon!,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
              child: weatherSymbol(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _currentWeatherDetails(CurrentWeatherModel _weather) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
      margin: const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(
                bottom: 50,
              )),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Text(
                  AppLocalizations.of(context)!.description,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              const Spacer(),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Text(
                  _weather.description!,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              Text(
                AppLocalizations.of(context)!.feels_like,
                textAlign: TextAlign.right,
                maxLines: 3,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const Spacer(),
              feelsLikeTempSymbol(),
            ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              Text(
                AppLocalizations.of(context)!.wind,
                textAlign: TextAlign.left,
                maxLines: 3,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const Spacer(),
              Text(
                "${_weather.wind!.toInt()} km/h",
                textAlign: TextAlign.right,
                maxLines: 3,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Text(
                  AppLocalizations.of(context)!.humidity,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              const Spacer(),
              const Spacer(),
              Text(
                "${_weather.humidity!.toInt()}%",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              Text(
                AppLocalizations.of(context)!.pressure,
                textAlign: TextAlign.left,
                maxLines: 3,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const Spacer(),
              Text(
                "${_weather.pressure!.toInt()}%",
                textAlign: TextAlign.right,
                maxLines: 3,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text weatherSymbol() {
    var unit = widget.measurementUnit == MeasurementUnit.metric ? "C" : "F";
    String text = "${_weather!.temp!.toInt()}°$unit";
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
    );
  }

  Text feelsLikeTempSymbol() {
    String text;
    widget.measurementUnit == MeasurementUnit.metric
        ? text = "${_weather!.temp!.toInt()}°C"
        : text = "${_weather!.temp!.toInt()}°F";
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
    );
  }

  Image getWeatherIcon(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      "$path$_icon$imageExtension",
      width: 150,
      height: 150,
    );
  }
}
