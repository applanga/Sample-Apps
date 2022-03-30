import 'dart:convert';

import 'package:weather_sample/api/api_key.dart';
import 'package:weather_sample/models/current/current_weather_model.dart';
import 'package:weather_sample/models/measurement_unit.dart';
import 'package:weather_sample/widgets/forecast.dart';
import 'package:http/http.dart' as http;

class WeatherMapApi {
  static String apiKey = ApiKey.openWeatherMapApiKey;

  Future<CurrentWeatherModel> getCurrentWeatherData(
      String city, MeasurementUnit measurementUnit) async {
    late CurrentWeatherModel weather;
    String apiKey = ApiKey.openWeatherMapApiKey;
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=${measurementUnit.name}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      weather = CurrentWeatherModel.fromJson(jsonDecode(response.body));
    } else {
      if (response.statusCode == 404) {
        weather = CurrentWeatherModel.fromJson(jsonDecode(response.body));
      }
    }
    return weather;
  }

  Future getForecast(MeasurementUnit measurementUnit, String city) async {
    late CurrentWeatherModel weatherForecast;
    String apiKey = ApiKey.openWeatherMapApiKey;
    late ForecastHourlyDaily forecast;
    double? lat;
    double? lon;

    var urlByCity =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=${measurementUnit.name}";
    final cityResponse = await http.get(Uri.parse(urlByCity));

    weatherForecast =
        CurrentWeatherModel.fromJson(jsonDecode(cityResponse.body));
    lat = weatherForecast.lat;
    lon = weatherForecast.lon;

    var url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=${measurementUnit.name}";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      forecast = ForecastHourlyDaily.fromJson(jsonDecode(response.body));
    }

    return forecast;
  }
}
