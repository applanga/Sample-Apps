import 'package:weather_sample/models/daily/clouds.dart';
import 'package:weather_sample/models/daily/main.dart';
import 'package:weather_sample/models/daily/rain.dart';
import 'package:weather_sample/models/daily/sys.dart';
import 'package:weather_sample/models/daily/weather.dart';
import 'package:weather_sample/models/daily/wind.dart';

class Day {
  Day({
    int? dt,
    Main? main,
    List<WeatherModel>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    double? pop,
    Rain? rain,
    Sys? sys,
    String? dtTxt,
  });

  factory Day.fromJson(Map<String, dynamic> data) {
    final int dt = data['dt'];
    final Main main = data['main'];
    final List<WeatherModel> weather = data['weather'];
    final Clouds clouds = data['clouds'];
    final Wind wind = data['wind'];
    final int visibility = data['visibility'];
    final double pop = data['pop'];
    final Rain rain = data['rain'];
    final Sys sys = data['sys'];
    final String dtTxt = data['dt_txt'];

    return Day(
      dt: dt,
      main: main,
      weather: weather,
      clouds: clouds,
      wind: wind,
      visibility: visibility,
      pop: pop,
      rain: rain,
      sys: sys,
      dtTxt: dtTxt,
    );
  }
}
