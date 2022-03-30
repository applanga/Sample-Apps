import 'package:applanga_flutter/applanga_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_sample/api/weather_map_api.dart';
import 'package:weather_sample/models/measurement_unit.dart';
import 'package:weather_sample/widgets/drawer.dart';
import 'package:weather_sample/widgets/forecast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({
    Key? key,
    required this.city,
    required this.measurementUnit,
    required this.currentLanguage,
  }) : super(key: key);
  final String city;
  final MeasurementUnit measurementUnit;
  final Locale currentLanguage;
  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage>
    with ApplangaScreenshotScopeMixin {
  var weatherMapApi = WeatherMapApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: _buildAppBar(),
      drawer: MyDrawer(
        city: widget.city,
        measurementUnit: widget.measurementUnit,
        currentLanguage: widget.currentLanguage,
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
          ),
          forcastViewsHourly(),
          forcastViewsDaily(),
        ],
      ),
    );
  }

  Widget forcastViewsHourly() {
    ForecastHourlyDaily _forcast;

    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _forcast = snapshot.data;
          // ignore: unnecessary_null_comparison
          if (_forcast == null) {
            return const Text("Error getting weather");
          } else {
            return hourlyBoxes(_forcast);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: weatherMapApi.getForecast(widget.measurementUnit, widget.city),
    );
  }

  Widget forcastViewsDaily() {
    ForecastHourlyDaily _forcast;

    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else {
          if (snapshot.hasData) {
            _forcast = snapshot.data;
            // ignore: unnecessary_null_comparison
            if (_forcast == null) {
              return const Text("Error getting weather");
            } else {
              return dailyBoxes(_forcast);
            }
          } else {
            return const Text('Error');
          }
        }
      },
      future: weatherMapApi.getForecast(widget.measurementUnit, widget.city),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.daily_forecast,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      );

  Image getWeatherIconSmall(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 40,
      height: 40,
    );
  }

  Widget hourlyBoxes(ForecastHourlyDaily _forecast) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 0.0),
        height: 150.0,
        child: ListView.builder(
            padding:
                const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: _forecast.hourly!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 15, bottom: 15, right: 10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  child: Column(children: [
                    forecastHourlySymbol(_forecast, index),
                    getWeatherIconSmall(_forecast.hourly![index].icon!),
                    Text(
                      getTimeFromTimestamp(_forecast.hourly![index].dt!),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ]));
            }));
  }

  Widget dailyBoxes(ForecastHourlyDaily _forcast) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
        itemCount: _forcast.daily!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding:
                  const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
              margin: const EdgeInsets.all(5),
              child: Row(children: [
                Expanded(
                    child: Text(
                  getDateFromTimestamp(_forcast.daily![index].dt!),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Expanded(
                    child: getWeatherIconSmall(_forcast.daily![index].icon!)),
                Expanded(child: forecastDailySymbol(_forcast, index)),
              ]));
        });
  }

  Text forecastDailySymbol(ForecastHourlyDaily _forecast, int index) {
    var unit = widget.measurementUnit == MeasurementUnit.metric ? "C" : "F";
    String text = "${_forecast.hourly![index].temp!.toInt()}°$unit";
    return Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text forecastHourlySymbol(ForecastHourlyDaily _forecast, int index) {
    var unit = widget.measurementUnit == MeasurementUnit.metric ? "C" : "F";
    String text = "${_forecast.hourly![index].temp!.toInt()}°$unit";
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black),
    );
  }

  String getTimeFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('h:mm a');
    return formatter.format(date);
  }

  String getDateFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    switch (date.weekday) {
      case DateTime.monday:
        return AppLocalizations.of(context)!.monday;
      case DateTime.tuesday:
        return AppLocalizations.of(context)!.tuesday;
      case DateTime.wednesday:
        return AppLocalizations.of(context)!.wednesday;
      case DateTime.thursday:
        return AppLocalizations.of(context)!.thursday;
      case DateTime.friday:
        return AppLocalizations.of(context)!.friday;
      case DateTime.saturday:
        return AppLocalizations.of(context)!.saturday;
      case DateTime.sunday:
        return AppLocalizations.of(context)!.sunday;
    }
    var formatter = DateFormat('EEEE');
    return formatter.format(date);
  }
}
