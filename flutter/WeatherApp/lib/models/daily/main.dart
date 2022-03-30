class Main {
  double? temp;
  double? feelsLike;
  double? minTemp;
  double? maxTemp;
  double? pressure;
  int? seaLevel;
  int? grndLevel;
  double? humidity;
  double? tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.minTemp,
    this.maxTemp,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  static Main fromJson(Map<String, dynamic> data) => Main(
        temp: data['temp'],
        feelsLike: data['feels_ike'],
        minTemp: data['temp_min'],
        maxTemp: data['temp_max'],
        pressure: data['pressure'],
        seaLevel: data['sea_level'],
        grndLevel: data['grnd_level'],
        humidity: data['humidity'],
        tempKf: data['temp_kf'],
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': minTemp,
        'temp_max': maxTemp,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'humidity': humidity,
        'temp_kf': tempKf,
      };
}
