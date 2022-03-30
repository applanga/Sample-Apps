class DailyForecast {
  int? dt;
  double? temp;
  double? feelsLike;
  double? low;
  double? high;
  String? description;
  double? pressure;
  double? humidity;
  double? wind;
  String? icon;

  DailyForecast(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.low,
      this.high,
      this.description,
      this.pressure,
      this.humidity,
      this.wind,
      this.icon});

  factory DailyForecast.fromJson(Map<String, dynamic> data) {
    return DailyForecast(
      dt: data['dt'].toInt(),
      temp: data['temp']['day'].toDouble(),
      feelsLike: data['feels_like']['day'].toDouble(),
      low: data['temp']['min'].toDouble(),
      high: data['temp']['max'].toDouble(),
      description: data['weather'][0]['description'],
      pressure: data['pressure'].toDouble(),
      humidity: data['humidity'].toDouble(),
      wind: data['wind_speed'].toDouble(),
      icon: data['weather'][0]['icon'],
    );
  }
}
