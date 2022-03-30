import 'package:weather_sample/models/current/clouds.dart';
import 'package:weather_sample/models/current/current_weather_model.dart';
import 'package:weather_sample/models/current/rain.dart';
import 'package:weather_sample/models/current/sys.dart';
import 'package:weather_sample/models/current/weather.dart';
import 'package:weather_sample/models/current/wind.dart';

import 'coord.dart';

class CurrentApiResponse {
  CurrentApiResponse({
    Coord? coord,
    List<WeatherModel>? weather,
    String? base,
    CurrentWeatherModel? main,
    Wind? wind,
    Rain? rain,
    Clouds? clouds,
    DateTime? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  });
}
