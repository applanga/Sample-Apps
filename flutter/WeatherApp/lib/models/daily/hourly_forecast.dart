class HourlyForecast {
  int? dt;
  double? temp;
  double? feelsLike;
  double? pressure;
  double? dewPoint;
  double? uvi;
  double? visibility;
  double? wind;
  String? description;
  String? icon;

  HourlyForecast(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.dewPoint,
      this.uvi,
      this.visibility,
      this.wind,
      this.description,
      this.icon});

  factory HourlyForecast.fromJson(Map<String, dynamic> data) {
    return HourlyForecast(
      dt: data['dt'].toInt(),
      temp: data['temp'].toDouble(),
      feelsLike: data['feels_like'].toDouble(),
      pressure: data['pressure'].toDouble(),
      dewPoint: data['dew_point'].toDouble(),
      uvi: data['uvi'].toDouble(),
      visibility: data['visibility'].toDouble(),
      wind: data['wind_speed'].toDouble(),
      description: data['weather'][0]['description'],
      icon: data['weather'][0]['icon'],
    );
  }
}
