import 'package:weather_sample/models/daily/day.dart';

import 'city.dart';

class DailyApiResponse {
  DailyApiResponse({
    int? cod,
    int? message,
    int? cnt,
    List<Day>? list,
    City? city,
  });

  factory DailyApiResponse.fromJson(Map<String, dynamic> data) {
    final int cod = data['cod'];
    final int message = data['message'];
    final int cnt = data['cnt'];
    final List<Day> list = data['list'];
    final City city = data['city'];

    return DailyApiResponse(
      cod: cod,
      message: message,
      cnt: cnt,
      list: list,
      city: city,
    );
  }
}
