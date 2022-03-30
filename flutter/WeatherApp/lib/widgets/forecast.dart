import 'package:weather_sample/models/daily/daily_forecast.dart';
import 'package:weather_sample/models/daily/hourly_forecast.dart';

class ForecastHourlyDaily {
  final List<HourlyForecast>? hourly;
  final List<DailyForecast>? daily;

  ForecastHourlyDaily({this.hourly, this.daily});

  factory ForecastHourlyDaily.fromJson(Map<String, dynamic> json) {
    List<dynamic> hourlyData = json['hourly'];
    List<dynamic> dailyData = json['daily'];

    List<HourlyForecast> hourly = <HourlyForecast>[];
    List<DailyForecast> daily = <DailyForecast>[];

    for (var item in hourlyData) {
      var hour = HourlyForecast.fromJson(item);
      hourly.add(hour);
    }

    for (var item in dailyData) {
      var day = DailyForecast.fromJson(item);
      daily.add(day);
    }

    return ForecastHourlyDaily(hourly: hourly, daily: daily);
  }
}
